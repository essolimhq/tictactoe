import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';
import 'package:tictactoe/features/game/domain/strategies/abstracts/ai_strategy.dart';

/// Minimax algorithm implementation for AI.
class MinimaxStrategy implements AIStrategy {
  final WinnerDetectionService _winnerDetectionService;

  MinimaxStrategy(this._winnerDetectionService);

  @override
  Either<GameError, Position> findBestMove(Board board, Player aiPlayer) {
    if (board.emptyIndices.isEmpty) {
      return left(const GameError.noValidMoves());
    }

    int bestScore = -1000;
    Position? bestPosition;

    final size = board.size;

    for (int emptyIndex in board.emptyIndices) {
      final position = Position.fromIndex(emptyIndex, boardSize: size);
      final simulatedBoard = _simulateMove(board, position, aiPlayer);

      final score = _minimax(
        simulatedBoard,
        position,
        false, // Next move would be opponent's (minimizing)
        aiPlayer,
      );

      if (score > bestScore) {
        bestScore = score;
        bestPosition = position;
      }
    }

    return bestPosition != null ? right(bestPosition) : left(const GameError.noValidMoves());
  }

  /// Minimax algorithm implementation.
  int _minimax(
    Board board,
    Position lastPosition,
    bool isMaximizing,
    Player aiPlayer,
  ) {
    final lastMovedPlayer = isMaximizing ? aiPlayer : aiPlayer.opposite;

    final winnerStatus = _winnerDetectionService.checkWinner(
      board,
      lastPosition,
      lastMovedPlayer,
    );

    if (winnerStatus is Winner) {
      return winnerStatus.player == aiPlayer ? 10 : -10;
    } else if (winnerStatus is Draw) {
      return 0;
    }

    final size = board.size;

    if (isMaximizing) {
      int bestScore = -1000;

      for (int emptyIndex in board.emptyIndices) {
        final position = Position.fromIndex(emptyIndex, boardSize: size);
        final newBoard = _simulateMove(board, position, aiPlayer);

        final score = _minimax(newBoard, position, false, aiPlayer);
        bestScore = max(score, bestScore);
      }

      return bestScore;
    } else {
      int bestScore = 1000;

      for (int emptyIndex in board.emptyIndices) {
        final position = Position.fromIndex(emptyIndex, boardSize: size);
        final newBoard = _simulateMove(board, position, aiPlayer.opposite);

        final score = _minimax(newBoard, position, true, aiPlayer);
        bestScore = min(score, bestScore);
      }

      return bestScore;
    }
  }

  /// Simulates a move on the board without mutating the original.
  Board _simulateMove(Board board, Position position, Player player) {
    final newCells = List<Player>.from(board.cells);
    newCells[position.index] = player;

    final newMove = Move(
      player: player,
      position: position,
      timestamp: DateTime.now(),
    );
    final newMoves = [...board.moves, newMove];

    return board.copyWith(
      cells: newCells,
      moves: newMoves,
    );
  }
}
