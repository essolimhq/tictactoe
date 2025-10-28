import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/features/game/data/constants/game_storage_keys.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';

/// Local implementation using Storage abstraction for score persistence.
///
/// This datasource depends on the Storage interface, not on Hive directly,
/// making it fully testable and swappable.
class ScoreLocalDataSource implements ScoreDataSource {
  final Storage _storage;

  ScoreLocalDataSource(this._storage);

  @override
  Future<Either<Exception, Unit>> saveScores({
    required int xScore,
    required int oScore,
  }) async {
    final xResult = await _storage.write(GameStorageKey.xScore.key, xScore);
    if (xResult.isLeft()) return xResult;

    return await _storage.write(GameStorageKey.oScore.key, oScore);
  }

  @override
  Future<Either<Exception, Option<({int xScore, int oScore})>>> loadScores() async {
    final xResult = await _storage.read<int>(GameStorageKey.xScore.key);
    final oResult = await _storage.read<int>(GameStorageKey.oScore.key);

    return xResult.fold(
      (error) => left(error),
      (xOption) => oResult.fold(
        (error) => left(error),
        (oOption) {
          // Both must exist to return scores
          return xOption.fold(
            () => right(none()),
            (xScore) => oOption.fold(
              () => right(none()),
              (oScore) => right(some((xScore: xScore, oScore: oScore))),
            ),
          );
        },
      ),
    );
  }

  @override
  Future<Either<Exception, Unit>> resetScores() async {
    return await saveScores(xScore: 0, oScore: 0);
  }
}
