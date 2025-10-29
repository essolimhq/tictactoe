import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/services/standard_winner_detection.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  late StandardWinnerDetection service;

  setUp(() {
    service = StandardWinnerDetection();
  });

  group('StandardWinnerDetection', () {
    test('should detect horizontal win', () {
      // Arrange
      final board = TestFixtures.xWinsTopRow;
      const lastMove = Position(row: 0, col: 2);
      const player = Player.x();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert
      expect(result, isA<Winner>());
      final winner = result as Winner;
      expect(winner.player, Player.x());
      expect(winner.winningLine.length, 3);
    });

    test('should detect vertical win', () {
      // Arrange
      final board = TestFixtures.oWinsLeftColumn;
      const lastMove = Position(row: 2, col: 0);
      const player = Player.o();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert
      expect(result, isA<Winner>());
      final winner = result as Winner;
      expect(winner.player, Player.o());
      expect(winner.winningLine.length, 3);
    });

    test('should detect diagonal win', () {
      // Arrange
      final board = TestFixtures.xWinsDiagonal;
      const lastMove = Position(row: 2, col: 2);
      const player = Player.x();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert
      expect(result, isA<Winner>());
      final winner = result as Winner;
      expect(winner.player, Player.x());
      expect(winner.winningLine.length, 3);
    });

    test('should detect draw when board is full with no winner', () {
      // Arrange
      final board = TestFixtures.drawBoard;
      const lastMove = Position(row: 2, col: 2);
      const player = Player.x();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert
      expect(result, isA<Draw>());
    });

    test('should return None when game continues', () {
      // Arrange
      final board = TestFixtures.boardWithOneMove;
      const lastMove = Position(row: 0, col: 0);
      const player = Player.x();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert
      expect(result, isA<None>());
    });

    test('should only check diagonal when last move is on diagonal', () {
      // Arrange - Board where X has a winning diagonal, but last move wasn't on it
      final board = Board.empty().copyWith(
        cells: [
          Player.x(), // (0,0)
          Player.o(), // (0,1) <- last move NOT on diagonal
          Player.none(),
          Player.none(),
          Player.x(), // (1,1)
          Player.none(),
          Player.none(),
          Player.none(),
          Player.x(), // (2,2)
        ],
      );
      const lastMove = Position(row: 0, col: 1); // Not on diagonal
      const player = Player.o();

      // Act
      final result = service.checkWinner(board, lastMove, player);

      // Assert - Should not detect the diagonal win since last move wasn't on it
      expect(result, isA<None>());
    });
  });
}
