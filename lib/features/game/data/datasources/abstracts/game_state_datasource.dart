import 'package:tictactoe/features/game/data/models/game_state_model.dart';

/// Data source interface for game state.
abstract class GameStateDataSource {
  /// Saves game state to storage.
  Future<void> saveGameState(GameStateModel gameState);

  /// Check if saved game exist
  Future<bool> isSavedGameExist();

  /// Loads game state from storage.
  Future<GameStateModel> loadGameState();

  /// Deletes saved game state.
  Future<void> deleteGameState();
}
