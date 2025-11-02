import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/score_repository_provider.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/score_repository.dart';
import 'package:tictactoe/features/game/domain/entities/score.dart';

part 'load_score_usecase.g.dart';

@riverpod
LoadScoreUsecase loadScoreUsecase(Ref ref) {
  final scoreRepository = ref.watch(scoreRepositoryProvider);
  return LoadScoreUsecase(scoreRepository: scoreRepository);
}

class LoadScoreUsecase {
  final ScoreRepository scoreRepository;

  const LoadScoreUsecase({required this.scoreRepository});

  Future<Score> call() async {
    if (await scoreRepository.exist()) {
      return await scoreRepository.loadScores();
    }

    return Score(x: 0, o: 0, draw: 0);
  }
}
