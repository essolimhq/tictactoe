import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

void main() {
  group('Position', () {
    test('should create position with row and col with default boardSize', () {
      const position = Position(row: 1, col: 2);

      expect(position.row, 1);
      expect(position.col, 2);
      expect(position.boardSize, 3);
    });

    test('fromIndex should create correct position', () {
      final pos0 = Position.fromIndex(0); // (0,0)
      final pos4 = Position.fromIndex(4); // (1,1)
      final pos8 = Position.fromIndex(8); // (2,2)

      expect(pos0.row, 0);
      expect(pos0.col, 0);

      expect(pos4.row, 1);
      expect(pos4.col, 1);

      expect(pos8.row, 2);
      expect(pos8.col, 2);
    });

    test('index getter should return correct index', () {
      expect(const Position(row: 0, col: 0).index, 0);
      expect(const Position(row: 0, col: 1).index, 1);
      expect(const Position(row: 0, col: 2).index, 2);
      expect(const Position(row: 1, col: 0).index, 3);
      expect(const Position(row: 1, col: 1).index, 4);
      expect(const Position(row: 2, col: 2).index, 8);
    });

    test('isValid should validate valid positions', () {
      expect(const Position(row: 0, col: 0).isValid, true);
      expect(const Position(row: 2, col: 2).isValid, true);
      expect(const Position(row: 1, col: 1).isValid, true);

      expect(const Position(row: -1, col: 0).isValid, false);
      expect(const Position(row: 0, col: 3).isValid, false);
      expect(const Position(row: 3, col: 3).isValid, false);
    });

    test('diagonal checks', () {
      // top-left to bottom-right
      expect(const Position(row: 0, col: 0).isDiagonal, true);
      expect(const Position(row: 1, col: 1).isDiagonal, true);
      expect(const Position(row: 2, col: 2).isDiagonal, true);
      expect(const Position(row: 0, col: 1).isDiagonal, false);

      // top-right to bottom-left
      expect(const Position(row: 0, col: 2).isAntiDiagonal, true);
      expect(const Position(row: 1, col: 1).isAntiDiagonal, true);
      expect(const Position(row: 2, col: 0).isAntiDiagonal, true);
      expect(const Position(row: 0, col: 0).isAntiDiagonal, false);
    });
  });
}
