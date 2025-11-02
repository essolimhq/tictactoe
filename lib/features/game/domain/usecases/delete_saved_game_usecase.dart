import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';

part 'delete_saved_game_usecase.g.dart';

@riverpod
DeleteSavedGameUseCase deleteSavedGameUseCase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return DeleteSavedGameUseCase(gameRepository: gameRepository);
}

class DeleteSavedGameUseCase {
  final GameRepository gameRepository;

  DeleteSavedGameUseCase({required this.gameRepository});

  Future<void> call() async {
    try {
      return await gameRepository.deleteGameState();
    } catch (e) {
      throw Exception("Error deleting saved game");
    }
  }
}
