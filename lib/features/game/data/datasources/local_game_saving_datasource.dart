import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/features/game/data/constants/game_storage_keys.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/data/models/game_state_model.dart';

/// Local implementation using Storage abstraction for game state persistence.
class LocalGameSavingDataSource implements GameStateDataSource {
  final Storage _storage;

  LocalGameSavingDataSource(this._storage);

  @override
  Future<void> saveGameState(GameStateModel gameState) async {
    await _storage.write(GameStorageKey.gameState.key, gameState);
  }

  @override
  Future<GameStateModel> loadGameState() async {
    final json = await _storage.read(GameStorageKey.gameState.key);
    if (json == null) {
      throw Exception('No saved game state found');
    }
    return GameStateModel.fromJson(json);
  }

  @override
  Future<void> deleteGameState() async {
    return await _storage.delete(GameStorageKey.gameState.key);
  }

  @override
  Future<bool> isSavedGameExist() async {
    return await _storage.exists(GameStorageKey.gameState.key);
  }
}
