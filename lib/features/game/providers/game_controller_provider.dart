import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';
import 'package:tictactoe/features/game/domain/usecases/delete_saved_game_usecase.dart';
import 'package:tictactoe/features/game/domain/usecases/find_best_move_usecase.dart';
import 'package:tictactoe/features/game/domain/usecases/score/load_score_usecase.dart';
import 'package:tictactoe/features/game/domain/usecases/score/update_score_usecase.dart';
import 'package:tictactoe/features/game/providers/check_winner_usecase_provider.dart';
import 'package:tictactoe/features/game/providers/minimax_strategy_provider.dart';
import 'package:tictactoe/features/game/providers/play_move_usecase_provider.dart';
import 'package:tictactoe/features/game/providers/save_game_usecase_provider.dart';

part 'game_controller_provider.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  GameState build() {
    return GameState.initial();
  }

  Future<void> start(GameMode? mode) async {
    try {
      final saveGameUseCase = ref.read(saveGameUseCaseProvider);
      final loadScoreUseCase = ref.read(loadScoreUsecaseProvider);

      final savedScore = await loadScoreUseCase();

      state = state.copyWith(
        gameMode: mode ?? state.gameMode,
        score: savedScore,
        status: GameStatus.playing(),
      );

      saveGameUseCase(state);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void reStart() {
    state = GameState.initial().copyWith(
      gameMode: state.gameMode,
      status: GameStatus.playing(),
    );
  }

  Future<void> quit() async {
    state = GameState.initial().copyWith(
      status: Menu(),
    );

    final deleteSavedGameUseCase = ref.read(deleteSavedGameUseCaseProvider);
    await deleteSavedGameUseCase();
  }

  Future<void> play(Position position) async {
    if (!state.status.isPlaying) return;

    final moveUseCase = ref.read(playMoveUseCaseProvider);
    final saveGameUseCase = ref.read(saveGameUseCaseProvider);

    HapticFeedback.lightImpact();

    moveUseCase(state.board, position, state.currentPlayer).fold(
      (e) => _handleGameError(e),
      (updatedBoard) async {
        state = state.copyWith(board: updatedBoard);
        _checkWinner(state.board, position, state.currentPlayer);
        await saveGameUseCase(state);
      },
    );
  }

  Player getPlayer(Position position) {
    if (!position.isValid) return Player.none();
    return state.board.at(position);
  }

  void resumeGame(GameState savedState) {
    state = savedState;
  }

  void _checkWinner(Board board, Position position, Player player) {
    final checkWinnerUseCase = ref.read(checkWinnerUseCaseProvider);
    final saveScoreUseCase = ref.read(updateScoreUseCaseProvider);
    final checkWinnerResult = checkWinnerUseCase(board, position, state.currentPlayer);

    checkWinnerResult.when(
      winner: (Player winner, List<Position> winningLine) {
        HapticFeedback.heavyImpact();
        state = state.copyWith(
          winner: winner,
          winningLine: winningLine,
          status: GameStatus.hasWin(),
        );

        saveScoreUseCase(winner);

        state = winner.when(
          x: () => state.copyWith(score: state.score.copyWith(x: state.score.x + 1)),
          o: () => state.copyWith(score: state.score.copyWith(x: state.score.o + 1)),
          none: () => state.copyWith(score: state.score.copyWith(x: state.score.draw + 1)),
        );
      },
      draw: () {
        state = state.copyWith(
          status: IsDraw(),
          score: state.score.copyWith(draw: state.score.draw + 1),
        );
        saveScoreUseCase(Player.none());
      },
      none: () => _switchPlayer(),
    );
  }

  Future<void> _switchPlayer() async {
    state = state.copyWith(currentPlayer: state.currentPlayer.opposite);

    if (state.gameMode == GameMode.vsAI && state.currentPlayer.isO) {
      await _aiMove();
    }
  }

  Future<void> _aiMove() async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Read strategy and create Use Case on the fly based on AI difficulty
    // TODO: Get difficulty from game state when implemented
    final aiStrategy = ref.read(minimaxStrategyProvider);
    final findBestMoveUseCase = FindBestMoveUseCase(aiStrategy);

    final bestMoveResult = findBestMoveUseCase(state.board, Player.o());

    bestMoveResult.fold(
      (error) => null,
      (bestPosition) {
        if (bestPosition.isValid) {
          play(bestPosition);
        }
      },
    );
  }

  void _handleGameError(GameError gameError) {
    switch (gameError) {
      case InvalidPositionError():
        state = state.copyWith(error: "La position est invalide");
        break;
      case CellOccupiedError():
        // TODO: Handle this case.
        throw UnimplementedError();
      case GameNotActiveError():
        // TODO: Handle this case.
        throw UnimplementedError();
      case GameNotOverError():
        // TODO: Handle this case.
        throw UnimplementedError();
      case InvalidBoardSizeError():
        // TODO: Handle this case.
        throw UnimplementedError();
      case NoValidMovesError():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
