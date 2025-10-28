import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/features/game/data/constants/game_storage_keys.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/data/models/game_state_model.dart';

/// Local implementation using Storage abstraction for game state persistence.
class GameStateLocalDataSource implements GameStateDataSource {
  final Storage _storage;

  GameStateLocalDataSource(this._storage);

  @override
  Future<Either<Exception, Unit>> saveGameState(GameStateModel gameState) async {
    try {
      final json = gameState.toJson();
      return await _storage.write(GameStorageKey.gameState.key, json);
    } catch (e) {
      return left(Exception('Failed to save game state: $e'));
    }
  }

  @override
  Future<Either<Exception, Option<GameStateModel>>> loadGameState() async {
    return (await _storage.read<Map<dynamic, dynamic>>(GameStorageKey.gameState.key)).fold(
      (error) => left(error),
      (optionJson) {
        try {
          return right(
            optionJson.map((json) {
              final jsonMap = Map<String, dynamic>.from(json);
              return GameStateModel.fromJson(jsonMap);
            }),
          );
        } catch (e) {
          return left(Exception('Failed to parse game state: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> deleteGameState() async {
    return await _storage.delete(GameStorageKey.gameState.key);
  }
}
