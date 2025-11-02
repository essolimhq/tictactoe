import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/usecases/save_game_usecase.dart';

part 'save_game_usecase_provider.g.dart';

@riverpod
SaveGameUseCase saveGameUseCase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return SaveGameUseCase(gameRepository: gameRepository);
}
