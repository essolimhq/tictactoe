import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';
import 'package:tictactoe/features/game/data/models/score_model.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/score_repository.dart';
import 'package:tictactoe/features/game/domain/entities/score.dart';

/// Local implementation of ScoreRepository using ScoreDataSource.
class LocalScoreRepository implements ScoreRepository {
  final ScoreDataSource _dataSource;

  LocalScoreRepository(this._dataSource);

  @override
  Future<void> saveScores(Score score) async {
    await _dataSource.saveScores(ScoreModel.fromEntity(score));
  }

  @override
  Future<Score> loadScores() async {
    final scoreModel = await _dataSource.loadScores();

    return scoreModel.toEntity();
  }

  @override
  Future<void> resetScores() async {
    return await _dataSource.resetScores();
  }

  @override
  Future<bool> exist() async {
    return await _dataSource.exist();
  }
}
