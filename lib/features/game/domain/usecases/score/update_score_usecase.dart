import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/score_repository_provider.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/score_repository.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/score.dart';

part 'update_score_usecase.g.dart';

@riverpod
UpdateScoreUseCase updateScoreUseCase(Ref ref) {
  final scoreRepository = ref.watch(scoreRepositoryProvider);
  return UpdateScoreUseCase(scoreRepository: scoreRepository);
}

/// Use case for calculating updated scores after a game ends.
class UpdateScoreUseCase {
  final ScoreRepository scoreRepository;

  const UpdateScoreUseCase({required this.scoreRepository});
  Future<void> call(Player winner) async {
    if (await scoreRepository.exist()) {
      final savedScore = await scoreRepository.loadScores();
      switch (winner) {
        case PlayerX():
          final updatedScore = savedScore.copyWith(x: savedScore.x + 1);
          await scoreRepository.saveScores(updatedScore);
        case PlayerO():
          final updatedScore = savedScore.copyWith(x: savedScore.x + 1);
          await scoreRepository.saveScores(updatedScore);
        case EmptyCell():
          final updatedScore = savedScore.copyWith(draw: savedScore.draw + 1);
          await scoreRepository.saveScores(updatedScore);
      }
    } else {
      scoreRepository.saveScores(Score(x: 0, o: 0, draw: 0));
    }
  }
}
