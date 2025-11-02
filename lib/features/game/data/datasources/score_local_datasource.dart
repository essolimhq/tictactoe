import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/features/game/data/constants/game_storage_keys.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';
import 'package:tictactoe/features/game/data/models/score_model.dart';

class LocalStatsSavingDataSource implements ScoreDataSource {
  final Storage _storage;

  LocalStatsSavingDataSource(this._storage);

  @override
  Future<void> saveScores(ScoreModel score) async {
    await _storage.write(GameStorageKey.score.key, score);
  }

  @override
  Future<ScoreModel> loadScores() async {
    final json = await _storage.read(GameStorageKey.score.key);
    if (json == null) {
      throw Exception('No saved scores found');
    }
    return ScoreModel.fromJson(json);
  }

  @override
  Future<void> resetScores() async {
    return await saveScores(ScoreModel(x: 0, o: 0, draw: 0));
  }

  @override
  Future<bool> exist() async {
    return await _storage.exists(GameStorageKey.score.key);
  }
}
