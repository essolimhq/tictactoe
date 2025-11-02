import 'package:tictactoe/features/game/data/models/score_model.dart';

/// Data source interface for score persistence.
abstract class ScoreDataSource {
  /// Saves scores to storage.
  Future<void> saveScores(ScoreModel score);

  /// Loads scores from storage.
  Future<ScoreModel> loadScores();

  /// Check if exist
  Future<bool> exist();

  /// Resets scores to zero.
  Future<void> resetScores();
}
