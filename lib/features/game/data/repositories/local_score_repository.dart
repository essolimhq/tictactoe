import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/score_repository.dart';

/// Local implementation of ScoreRepository using ScoreDataSource.
class LocalScoreRepository implements ScoreRepository {
  final ScoreDataSource _dataSource;

  LocalScoreRepository(this._dataSource);

  @override
  Future<Either<Exception, Unit>> saveScores({
    required int xScore,
    required int oScore,
  }) async {
    return await _dataSource.saveScores(xScore: xScore, oScore: oScore);
  }

  @override
  Future<Either<Exception, Option<({int xScore, int oScore})>>> loadScores() async {
    return await _dataSource.loadScores();
  }

  @override
  Future<Either<Exception, Unit>> resetScores() async {
    return await _dataSource.resetScores();
  }
}
