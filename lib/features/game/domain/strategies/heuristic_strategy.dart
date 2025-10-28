import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';
import 'package:tictactoe/features/game/domain/strategies/abstracts/ai_strategy.dart';

/// Heuristic-based AI strategy for easy difficulty.
class HeuristicStrategy implements AIStrategy {
  final Random _random;

  HeuristicStrategy(WinnerDetectionService winnerDetectionService, {Random? random})
      : _random = random ?? Random();

  @override
  Either<GameError, Position> findBestMove(Board board, Player aiPlayer) {
    // Check if there are available moves
    if (board.emptyIndices.isEmpty) {
      return left(const GameError.noValidMoves());
    }

    final size = board.size;

    // Convert empty indices to Positions
    final emptyPositions =
        board.emptyIndices.map((index) => Position.fromIndex(index, boardSize: size)).toList();

    // 1. Try to take center if available (good heuristic)
    final centerPosition = emptyPositions.firstWhere(
      (pos) => pos.isCenter,
      orElse: () => Position(row: -1, col: -1, boardSize: size),
    );
    if (centerPosition.isValid) {
      return right(centerPosition);
    }

    // 2. Try to take a corner if available
    final cornerPositions = emptyPositions.where((pos) => pos.isCorner).toList();
    if (cornerPositions.isNotEmpty) {
      final randomCorner = cornerPositions[_random.nextInt(cornerPositions.length)];
      return right(randomCorner);
    }

    // 3. Pick any random available position
    final randomPosition = emptyPositions[_random.nextInt(emptyPositions.length)];
    return right(randomPosition);
  }
}
