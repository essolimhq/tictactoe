import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';

part 'is_saved_game_exist_usecase.g.dart';

@riverpod
IsSavedGameExistUseCase isSavedGameExistUseCase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return IsSavedGameExistUseCase(gameRepository: gameRepository);
}

class IsSavedGameExistUseCase {
  final GameRepository gameRepository;

  const IsSavedGameExistUseCase({required this.gameRepository});

  Future<bool> call() async {
    return await gameRepository.gameStateExist();
  }
}
