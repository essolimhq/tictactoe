import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';
import 'package:tictactoe/features/game/domain/usecases/play_move_usecase.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  late PlayMoveUseCase useCase;

  setUp(() {
    useCase = PlayMoveUseCase();
  });

  group('PlayMoveUseCase', () {
    test('should return updated board when move is valid', () {
      final board = TestFixtures.emptyBoard;
      const position = Position(row: 0, col: 0);
      const player = Player.x();

      final result = useCase(board, position, player);

      result.fold(
        (error) => fail('Expected success but got error: $error'),
        (newBoard) {
          expect(newBoard.cells[0], Player.x());
          expect(newBoard.cells[position.index], player);
        },
      );
    });

    test('should return InvalidPositionError when position is out of bounds', () {
      final board = TestFixtures.emptyBoard;
      const position = Position(row: 3, col: 3);
      const player = Player.x();

      final result = useCase(board, position, player);

      result.fold(
        (error) {
          expect(error, isA<InvalidPositionError>());
        },
        (_) => fail('Expected InvalidPositionError but got success'),
      );
    });

    test('should return CellOccupiedError when cell is already occupied', () {
      final board = TestFixtures.cellZeroOccupied;
      const position = Position(row: 0, col: 0);
      const player = Player.o();

      final result = useCase(board, position, player);

      result.fold(
        (error) {
          expect(error, isA<CellOccupiedError>());
        },
        (_) => fail('Expected CellOccupiedError but got success'),
      );
    });

    test('should handle consecutive moves correctly', () {
      var board = TestFixtures.emptyBoard;

      final move1 = useCase(board, const Position(row: 0, col: 0), Player.x());
      move1.fold(
        (error) => fail('Move 1 failed: $error'),
        (newBoard) {
          board = newBoard;
          expect(board.cells[0], Player.x());
        },
      );

      final move2 = useCase(board, const Position(row: 1, col: 1), Player.o());
      move2.fold(
        (error) => fail('Move 2 failed: $error'),
        (newBoard) {
          expect(newBoard.cells[4], Player.o());
          expect(newBoard.cells[0], Player.x());
        },
      );
    });

    test('should not mutate original board', () {
      // Arrange
      final board = TestFixtures.emptyBoard;
      const position = Position(row: 0, col: 0);
      const player = Player.x();

      // Act
      final result = useCase(board, position, player);

      // Assert
      result.fold(
        (error) => fail('Expected success but got error: $error'),
        (newBoard) {
          // Original board should remain unchanged
          expect(board.cells[0], Player.none());
          // New board should have the move
          expect(newBoard.cells[0], Player.x());
        },
      );
    });
  });
}
