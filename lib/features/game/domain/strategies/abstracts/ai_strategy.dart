import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';

/// Abstract strategy for AI move selection.
abstract class AIStrategy {
  Either<GameError, Position> findBestMove(Board board, Player aiPlayer);
}
