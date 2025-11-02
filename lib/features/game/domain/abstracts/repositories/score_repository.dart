import 'package:tictactoe/features/game/domain/entities/score.dart';

/// Repository interface for score.
abstract class ScoreRepository {
  /// Saves the scores for both players.
  Future<void> saveScores(Score score);

  /// Loads the saved scores.
  Future<Score> loadScores();

  /// Check if score exist
  Future<bool> exist();

  /// Resets scores to zero.
  Future<void> resetScores();
}
