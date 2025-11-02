import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';

/// Use case for playing a move on the board.
class PlayMoveUseCase {
  Either<GameError, Board> call(
    Board board,
    Position position,
    Player player,
  ) {
    if (!position.isValid) {
      return left(
        GameError.invalidPosition(
          row: position.row,
          col: position.col,
          boardSize: 3, // TODO: Support dynamic board size
        ),
      );
    }

    if (!board.isEmpty(position)) {
      return left(
        GameError.cellOccupied(
          row: position.row,
          col: position.col,
        ),
      );
    }

    final updatedCells = List<Player>.from(board.cells);
    updatedCells[position.index] = player;

    return right(board.copyWith(cells: updatedCells));
  }
}
