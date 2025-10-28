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
import 'package:tictactoe/features/game/domain/usecases/find_best_move_usecase.dart';
import 'package:tictactoe/features/game/presentation/providers/check_winner_usecase_provider.dart';
import 'package:tictactoe/features/game/presentation/providers/minimax_strategy_provider.dart';
import 'package:tictactoe/features/game/presentation/providers/play_move_usecase_provider.dart';

part 'game_controller_provider.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  GameState build() {
    return GameState.initial();
  }

  void setGameMode(GameMode mode) {
    state = state.copyWith(gameMode: mode);
  }

  void start(GameMode? mode) {
    state = state.copyWith(
      gameMode: mode ?? state.gameMode,
      status: GameStatus.playing(),
    );
  }

  void reStart() {
    state = GameState.initial().copyWith(
      gameMode: state.gameMode,
      status: GameStatus.playing(),
    );
  }

  void quit() {
    state = GameState.initial().copyWith(
      status: GameStatus.menu(),
    );
  }

  void play(Position position) {
    if (!state.status.isPlaying) return;
    final playMoveUseCase = ref.read(playMoveUseCaseProvider);

    HapticFeedback.lightImpact();

    playMoveUseCase(state.board, position, state.currentPlayer).fold(
      (e) => _handleGameError(e),
      (board) {
        state = state.copyWith(board: board);
        _checkWinner(state.board, position, state.currentPlayer);
      },
    );
  }

  Player getPlayer(Position position) {
    if (!position.isValid) return Player.none();
    return state.board.at(position);
  }

  void _checkWinner(Board board, Position position, Player player) {
    final checkWinnerUseCase = ref.read(checkWinnerUseCaseProvider);
    final winningStatus = checkWinnerUseCase(board, position, state.currentPlayer);

    winningStatus.when(
      winner: (Player winner, List<Position> winningLine) {
        HapticFeedback.heavyImpact();
        state = state.copyWith(
          winner: winner,
          winningLine: winningLine,
          status: GameStatus.win(),
        );
      },
      draw: () => state = state.copyWith(status: GameStatus.isDraw()),
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
      (error) => null, // No valid move found
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
