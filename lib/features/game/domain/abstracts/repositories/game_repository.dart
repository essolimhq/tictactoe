import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

/// Repository interface for game state.
abstract class GameRepository {
  /// Saves the current game state.
  Future<Either<Exception, Unit>> saveGameState(GameState state);

  /// Loads the previously saved game state.
  Future<Either<Exception, Option<GameState>>> loadGameState();

  /// Deletes the saved game state.
  Future<Either<Exception, Unit>> deleteGameState();
}
