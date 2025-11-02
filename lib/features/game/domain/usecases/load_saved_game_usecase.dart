import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/repositories/providers/game_repository_provider.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

part 'load_saved_game_usecase.g.dart';

@riverpod
LoadSavedGameUseCase loadSavedGameUseCase(Ref ref) {
  final gameRepository = ref.watch(gameRepositoryProvider);
  return LoadSavedGameUseCase(gameRepository: gameRepository);
}

class LoadSavedGameUseCase {
  final GameRepository gameRepository;

  const LoadSavedGameUseCase({required this.gameRepository});

  Future<GameState?> call() async {
    try {
      return await gameRepository.loadGameState();
    } catch (e) {
      return null;
    }
  }
}
