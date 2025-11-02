import 'package:tictactoe/features/game/domain/entities/game_state.dart';

/// Repository interface for game state.
abstract class GameRepository {
  /// Saves the current game state.
  Future<void> saveGameState(GameState state);

  /// Loads the previously saved game state.
  Future<GameState> loadGameState();

  /// Check if game state exist
  Future<bool> gameStateExist();

  /// Deletes the saved game state.
  Future<void> deleteGameState();
}
