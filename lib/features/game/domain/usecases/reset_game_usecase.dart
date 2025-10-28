import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Use case for resetting/initializing a game board.
class ResetGameUseCase {
  Board call({int size = 3}) {
    final totalCells = size * size;
    return Board(
      cells: List.filled(totalCells, const Player.none()),
    );
  }
}
