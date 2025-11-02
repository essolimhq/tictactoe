import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/reset_game_usecase.dart';

part 'reset_game_usecase_provider.g.dart';

@riverpod
ResetGameUseCase resetGameUseCase(Ref ref) {
  return ResetGameUseCase();
}
