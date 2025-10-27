import 'dart:math';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
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

    final winningStatus = _checkWinnerMinimax(state.board, position, state.currentPlayer);

    winningStatus.when(
      winner: (Player winner, List<Position> winningLine) {
        HapticFeedback.heavyImpact();
        state = state.copyWith(
          winner: winner,
          winningLine: winningLine,
          status: GameStatus.win(),
        );
      },
      draw: () {
        state = state.copyWith(
          status: GameStatus.isDraw(),
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

  Future<void> _switchPlayer() async {
    state = state.copyWith(currentPlayer: state.currentPlayer.opposite);

    if (state.gameMode == GameMode.vsAI && state.currentPlayer.isO) {
      await _aiMove();
    }
  }

  WinnerStatus _checkWinnerMinimax(Board board, Position lastMovePosition, Player currentPlayer) {
    // Check the Row
    List<Position>? winningLine = _isLineHasWinner(board, lastMovePosition.copyWith(col: 0), 0, 1);
    if (winningLine != null) {
      return WinnerStatus.winner(currentPlayer, winningLine);
    }

    // Check the Column
    winningLine = _isLineHasWinner(board, lastMovePosition.copyWith(row: 0), 1, 0);
    if (winningLine != null) {
      return WinnerStatus.winner(currentPlayer, winningLine);
    }

    // Check Diagonals (only if the move was on a diagonal)
    if (lastMovePosition.isDiagonal) {
      winningLine = _isLineHasWinner(board, lastMovePosition.copyWith(row: 0, col: 0), 1, 1);
      if (winningLine != null) {
        return WinnerStatus.winner(currentPlayer, winningLine);
      }
    }

    // Check anti-diagonal (2, 4, 6)
    if (lastMovePosition.isAntiDiagonal) {
      winningLine = _isLineHasWinner(board, lastMovePosition.copyWith(row: 0, col: 0), 1, -1);
      if (winningLine != null) {
        return WinnerStatus.winner(currentPlayer, winningLine);
      }
    }

    // Check for Draw
    if (state.moveHistory.length == 9) {
      return WinnerStatus.draw();
    }

    return WinnerStatus.none();
  }

  List<Position>? _isLineHasWinner(
    Board board,
    Position lineStartPosition,
    int horizontalCheckDirection,
    int verticalCheckDirection,
  ) {
    List<Position> winningLine = [];

    for (int i = 0; i < 3; i++) {
      final position = Position(
        row: lineStartPosition.row + i * horizontalCheckDirection,
        col: lineStartPosition.col + i * verticalCheckDirection,
      );
      final currentCellPlayer = board.at(position);

      if (currentCellPlayer != state.currentPlayer) {
        return null;
      }

      winningLine.add(position);
    }

    return winningLine;
  }

  Future<void> _aiMove() async {
    await Future.delayed(Duration(milliseconds: 400));
    final bestMovePosition = findBestMove(state.board);

    if (bestMovePosition.isValid) {
      play(bestMovePosition);
    }
  }

  Position findBestMove(Board board) {
    int bestScore = -1000;
    Position? bestPosition;

    for (int emptyIndex in board.emptyIndices) {
      bestPosition = Position.fromIndex(emptyIndex);
      final movePosition = Position.fromIndex(emptyIndex);
      final movedBoard = _makeHypotheticalMove(board, movePosition, Player.o());

      int score = simpleMiniMax(movedBoard, movePosition, false);

      if (score > bestScore) {
        bestScore = score;
        bestPosition = Position.fromIndex(emptyIndex);
      }
    }

    return bestPosition ?? Position.fromIndex(board.emptyIndices.first);
  }

  int simpleMiniMax(Board board, Position lastMovedPosition, bool isMaximizing) {
    final lastMovedPlayer = isMaximizing ? Player.x() : Player.o();

    final winningResult = _checkWinnerMinimax(board, lastMovedPosition, lastMovedPlayer);

    if (winningResult is Winner) {
      return winningResult.player is PlayerO ? 10 : -10;
    } else if (winningResult is Draw) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int emptyIndex in board.emptyIndices) {
        final newPosition = Position.fromIndex(emptyIndex);
        final newBoard = _makeHypotheticalMove(board, newPosition, Player.o());

        int score = simpleMiniMax(newBoard, newPosition, false);
        bestScore = max(score, bestScore);
      }

      return bestScore;
    } else {
      int bestScore = 1000;
      for (int emptyIndex in board.emptyIndices) {
        final newPosition = Position.fromIndex(emptyIndex);
        final newBoard = _makeHypotheticalMove(board, newPosition, Player.x());

        int score = simpleMiniMax(newBoard, newPosition, true);
        bestScore = max(score, bestScore);
      }

      return bestScore;
    }
  }

  // int minimax(Board board, int depth, bool isMaximizing, int alpha, int beta, Position position) {
  //   final winnerStatus = _hasWinner(position);
  //
  //   if (winnerStatus is Winner) {
  //     return winnerStatus.player.maybeMap(
  //       x: (x) => depth - 10,
  //       o: (o) => 10 - depth,
  //       orElse: () => 0,
  //     );
  //   }
  //
  //   if (winnerStatus is Draw) return 0;
  //
  //   return 0;
  //
  //   // if (isMaximizing) {
  //   //   int maxScore = -1000;
  //   //
  //   //   for (int row = 0; row < board.emptyIndices)
  //   // }
  // }

  Board _makeHypotheticalMove(Board oldBoard, Position pos, Player player) {
    // Create a new list of cells based on the old one
    List<Player> newCells = List.from(oldBoard.cells);
    newCells[pos.index] = player;

    // (Optional but good) Add a new Move to the history
    List<Move> newMoves = List.from(oldBoard.moves);
    newMoves.add(Move(player: player, position: pos, timestamp: DateTime.now()));

    // Return a new Board object with the updated cells and moves
    return oldBoard.copyWith(
      cells: newCells,
      moves: newMoves,
    );
  }
}
