import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';

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

  void start(GameMode mode) {
    state = state.copyWith(
      gameMode: mode,
      status: GameStatus.playing(),
    );
  }

  void play(Position position) {
    if (!position.isValid) return;
    if (!state.board.isEmpty(position) || !state.status.isPlaying) return;

    HapticFeedback.lightImpact();

    _updateBoard(position);

    final winningStatus = _hasWinner(position);

    winningStatus.when(
      winner: (Player winner) {
        HapticFeedback.heavyImpact();
        state = state.copyWith(
          winner: winner,
          status: GameStatus.win(),
        );
      },
      draw: () {
        state = state.copyWith(
          status: GameStatus.draw(),
        );
      },
      none: () {
        _switchPlayer();
      },
    );
  }

  bool isWinnerCell() {
    return false;
  }

  Player getPlayer(Position position) {
    if (!position.isValid) return Player.none();

    return state.board.at(position);
  }

  void _updateBoard(Position position) {
    final updatedCells = [...state.board.cells];
    updatedCells[position.index] = state.currentPlayer;
    state = state.copyWith(board: state.board.copyWith(cells: updatedCells));
  }

  void _switchPlayer() {
    state = state.copyWith(currentPlayer: state.currentPlayer.opposite);
  }

  WinnerStatus _hasWinner(Position position) {
    final currentPlayer = state.currentPlayer;

    // Check the Row
    if (_isLineHasWinner(position.copyWith(col: 0), 0, 1)) {
      return WinnerStatus.winner(currentPlayer);
    }

    // Check the Column
    if (_isLineHasWinner(position.copyWith(row: 0), 1, 0)) {
      return WinnerStatus.winner(currentPlayer);
    }

    // Check Diagonals (only if the move was on a diagonal)
    if (position.isDiagonal) {
      if (_isLineHasWinner(position.copyWith(row: 0, col: 0), 1, 1)) {
        return WinnerStatus.winner(currentPlayer);
      }
    }

    // Check anti-diagonal (2, 4, 6)
    if (position.isAntiDiagonal) {
      if (_isLineHasWinner(position.copyWith(row: 0, col: 0), 1, -1)) {
        return WinnerStatus.winner(currentPlayer);
      }
    }

    // Check for Draw
    if (state.moveHistory.length == 9) {
      return WinnerStatus.draw();
    }

    return WinnerStatus.none();
  }

  bool _isLineHasWinner(
    Position lineStartPosition,
    int horizontalCheckDirection,
    int verticalCheckDirection,
  ) {
    final board = state.board;

    for (int i = 0; i < 3; i++) {
      final position = Position(
        row: lineStartPosition.row + i * horizontalCheckDirection,
        col: lineStartPosition.col + i * verticalCheckDirection,
      );
      final currentCellPlayer = board.at(position);

      if (currentCellPlayer != state.currentPlayer) {
        return false;
      }
    }

    return true;
  }
}
