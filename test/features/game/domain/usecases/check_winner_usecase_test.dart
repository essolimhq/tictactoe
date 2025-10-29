import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/usecases/check_winner_usecase.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  late CheckWinnerUseCase useCase;
  late MockWinnerDetectionService mockWinnerDetection;

  setUpAll(() {
    registerFallbackValue(TestFixtures.emptyBoard);
    registerFallbackValue(const Position(row: 0, col: 0));
    registerFallbackValue(Player.x());
  });

  setUp(() {
    mockWinnerDetection = MockWinnerDetectionService();
    useCase = CheckWinnerUseCase(mockWinnerDetection);
  });

  group('CheckWinnerUseCase', () {
    test('should return winner result', () {
      final board = TestFixtures.xWinsTopRow;
      const lastMove = Position(row: 0, col: 2);
      const player = Player.x();
      const expectedResult = WinnerStatus.winner(Player.x(), [
        Position(row: 0, col: 0),
        Position(row: 0, col: 1),
        Position(row: 0, col: 2),
      ]);
      when(() => mockWinnerDetection.checkWinner(any(), any(), any())).thenReturn(expectedResult);

      final result = useCase(board, lastMove, player);

      verify(() => mockWinnerDetection.checkWinner(board, lastMove, player)).called(1);
      expect(result, expectedResult);
    });

    test('should return draw', () {
      final board = TestFixtures.drawBoard;
      const lastMove = Position(row: 2, col: 2);
      const player = Player.x();
      const expectedResult = WinnerStatus.draw();
      when(() => mockWinnerDetection.checkWinner(any(), any(), any())).thenReturn(expectedResult);

      final result = useCase(board, lastMove, player);

      expect(result, isA<Draw>());
    });

    test('should return none', () {
      final board = TestFixtures.boardWithOneMove;
      const lastMove = Position(row: 0, col: 0);
      const player = Player.x();
      const expectedResult = WinnerStatus.none();
      when(() => mockWinnerDetection.checkWinner(any(), any(), any())).thenReturn(expectedResult);

      final result = useCase(board, lastMove, player);

      expect(result, isA<None>());
    });
  });
}
