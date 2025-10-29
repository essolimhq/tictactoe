import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/usecases/reset_game_usecase.dart';

void main() {
  late ResetGameUseCase useCase;

  setUp(() {
    useCase = ResetGameUseCase();
  });

  group('ResetGameUseCase', () {
    test('should create empty board', () {
      final board = useCase();

      expect(board.cells.length, 9);
      expect(board.cells.every((cell) => cell == Player.none()), true);
    });

    test('should create empty board with custom size', () {
      final board = useCase(size: 5);

      expect(board.cells.length, 25);
      expect(board.cells.every((cell) => cell == Player.none()), true);
    });
  });
}
