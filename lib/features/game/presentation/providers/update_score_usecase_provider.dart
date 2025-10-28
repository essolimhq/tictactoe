import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/update_score_usecase.dart';

part 'update_score_usecase_provider.g.dart';

@riverpod
UpdateScoreUseCase updateScoreUseCase(Ref ref) {
  return UpdateScoreUseCase();
}
