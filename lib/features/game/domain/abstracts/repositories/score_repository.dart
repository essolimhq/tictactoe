import 'package:fpdart/fpdart.dart';

/// Repository interface for score.
abstract class ScoreRepository {
  /// Saves the scores for both players.
  Future<Either<Exception, Unit>> saveScores({
    required int xScore,
    required int oScore,
  });

  /// Loads the saved scores.
  Future<Either<Exception, Option<({int xScore, int oScore})>>> loadScores();

  /// Resets scores to zero.
  Future<Either<Exception, Unit>> resetScores();
}
