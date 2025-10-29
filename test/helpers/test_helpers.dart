import 'package:mocktail/mocktail.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';

class MockStorage extends Mock implements Storage {}

class MockGameStateDataSource extends Mock implements GameStateDataSource {}

class MockWinnerDetectionService extends Mock implements WinnerDetectionService {}

class TestFixtures {
  static Board get emptyBoard => Board.empty();

  static Board get boardWithOneMove => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get xAlmostWinsTopRow => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.x(),
          Player.none(), // X can win here
          Player.o(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get xWinsTopRow => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.x(),
          Player.x(),
          Player.o(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get oWinsLeftColumn => Board.empty().copyWith(
        cells: [
          Player.o(),
          Player.x(),
          Player.x(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.o(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get xWinsDiagonal => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.x(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.x(),
        ],
      );

  static Board get oWinsAntiDiagonal => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.x(),
          Player.o(),
          Player.none(),
          Player.o(),
          Player.none(),
          Player.o(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get drawBoard => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.o(),
          Player.x(),
          Player.x(),
          Player.o(),
          Player.o(),
          Player.o(),
          Player.x(),
          Player.x(),
        ],
      );

  static Board get xWinsMiddleRow => Board.empty().copyWith(
        cells: [
          Player.o(),
          Player.o(),
          Player.none(),
          Player.x(),
          Player.x(),
          Player.x(),
          Player.none(),
          Player.none(),
          Player.none(),
        ],
      );

  static Board get oWinsBottomRow => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.x(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.o(),
          Player.o(),
          Player.o(),
        ],
      );

  static Board get xWinsMiddleColumn => Board.empty().copyWith(
        cells: [
          Player.o(),
          Player.x(),
          Player.none(),
          Player.o(),
          Player.x(),
          Player.none(),
          Player.none(),
          Player.x(),
          Player.none(),
        ],
      );

  static Board get oWinsRightColumn => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.x(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.o(),
          Player.none(),
          Player.none(),
          Player.o(),
        ],
      );

  static Board get nearlyFullBoard => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.o(),
          Player.x(),
          Player.x(),
          Player.o(),
          Player.o(),
          Player.o(),
          Player.x(),
          Player.none(),
        ],
      );

  static Board get cellZeroOccupied => Board.empty().copyWith(
        cells: [
          Player.x(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
          Player.none(),
        ],
      );
}
