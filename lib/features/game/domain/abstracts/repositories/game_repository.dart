import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

/// Repository interface for game state persistence.
abstract class GameRepository {
  /// Saves the current game state.
  ///
  /// Returns:
  /// - Left(error) if save fails
  /// - Right(unit) if save succeeds
  Future<Either<Exception, Unit>> saveGameState(GameState state);

  /// Loads the previously saved game state.
  ///
  /// Returns:
  /// - Left(error) if load fails
  /// - Right(Some(GameState)) if a saved state exists
  /// - Right(None) if no saved state exists
  Future<Either<Exception, Option<GameState>>> loadGameState();

  /// Deletes the saved game state.
  ///
  /// Returns:
  /// - Left(error) if delete fails
  /// - Right(unit) if delete succeeds
  Future<Either<Exception, Unit>> deleteGameState();
}
