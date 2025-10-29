import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  group('Board', () {
    test('empty() should create a 3x3 board with all empty cells', () {
      // Arrange & Act
      final board = Board.empty();

      // Assert
      expect(board.size, 3);
      expect(board.winningLength, 3);
      expect(board.cells.length, 9);
      expect(board.cells.every((cell) => cell == Player.none()), true);
      expect(board.isFull, false);
    });

    test('withSize() should create a board with custom size', () {
      // Arrange & Act
      final board = Board.withSize(size: 5, winningLength: 4);

      // Assert
      expect(board.size, 5);
      expect(board.winningLength, 4);
      expect(board.cells.length, 25);
      expect(board.cells.every((cell) => cell == Player.none()), true);
    });

    test('at() should return player at given position', () {
      // Arrange
      final board = TestFixtures.cellZeroOccupied;
      const position = Position(row: 0, col: 0);

      // Act
      final player = board.at(position);

      // Assert
      expect(player, Player.x());
    });

    test('isEmpty() should return true for empty cell and false for occupied', () {
      // Arrange
      final board = TestFixtures.cellZeroOccupied;

      // Act & Assert
      expect(board.isEmpty(Position(row: 0, col: 0)), false); // Occupied by X
      expect(board.isEmpty(Position(row: 0, col: 1)), true); // Empty
    });

    test('emptyIndices should return correct indices', () {
      // Arrange
      final emptyBoard = TestFixtures.emptyBoard;
      final partialBoard = TestFixtures.boardWithOneMove; // Only index 0 occupied
      final fullBoard = TestFixtures.drawBoard;

      // Act & Assert
      expect(emptyBoard.emptyIndices.length, 9);
      expect(partialBoard.emptyIndices.length, 8);
      expect(partialBoard.emptyIndices.contains(0), false);
      expect(fullBoard.emptyIndices.isEmpty, true);
    });

    test('isFull should return correct status', () {
      // Arrange
      final emptyBoard = TestFixtures.emptyBoard;
      final partialBoard = TestFixtures.boardWithOneMove;
      final fullBoard = TestFixtures.drawBoard;

      // Act & Assert
      expect(emptyBoard.isFull, false);
      expect(partialBoard.isFull, false);
      expect(fullBoard.isFull, true);
    });
  });
}
