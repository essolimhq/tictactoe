import 'package:fpdart/fpdart.dart';

/// Data source interface for score persistence.
abstract class ScoreDataSource {
  /// Saves scores to storage.
  Future<Either<Exception, Unit>> saveScores({
    required int xScore,
    required int oScore,
  });

  /// Loads scores from storage.
  Future<Either<Exception, Option<({int xScore, int oScore})>>> loadScores();

  /// Resets scores to zero.
  Future<Either<Exception, Unit>> resetScores();
}
