import 'package:tictactoe/features/game/domain/entities/player.dart';

/// Use case for calculating updated scores after a game ends.
class UpdateScoreUseCase {
  ({int xScore, int oScore}) call({
    required int currentXScore,
    required int currentOScore,
    required Player? winner,
  }) {
    if (winner == null || winner.isEmpty) {
      return (xScore: currentXScore, oScore: currentOScore);
    }

    return winner.when(
      x: () => (xScore: currentXScore + 1, oScore: currentOScore),
      o: () => (xScore: currentXScore, oScore: currentOScore + 1),
      none: () => (xScore: currentXScore, oScore: currentOScore),
    );
  }
}
