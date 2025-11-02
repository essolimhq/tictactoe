import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

class SaveGameUseCase {
  final GameRepository gameRepository;

  const SaveGameUseCase({required this.gameRepository});

  Future<void> call(GameState state) async {
    await gameRepository.saveGameState(state);
  }
}
