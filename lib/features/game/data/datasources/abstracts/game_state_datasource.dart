import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/data/models/game_state_model.dart';

/// Data source interface for game state.
abstract class GameStateDataSource {
  /// Saves game state to storage.
  Future<Either<Exception, Unit>> saveGameState(GameStateModel gameState);

  /// Loads game state from storage.
  Future<Either<Exception, Option<GameStateModel>>> loadGameState();

  /// Deletes saved game state.
  Future<Either<Exception, Unit>> deleteGameState();
}
