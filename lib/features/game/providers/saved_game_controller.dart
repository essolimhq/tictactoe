import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/delete_saved_game_usecase.dart';
import 'package:tictactoe/features/game/domain/usecases/load_saved_game_usecase.dart';
import 'package:tictactoe/features/game/presentation/states/saved_game_state.dart';

part 'saved_game_controller.g.dart';

@riverpod
class SavedGameController extends _$SavedGameController {
  @override
  SavedGameState build() {
    return SavedGameState(gameState: null);
  }

  void loadSaveGame() async {
    try {
      final loadSavedGameUseCase = ref.read(loadSavedGameUseCaseProvider);
      final savedState = await loadSavedGameUseCase();

      if (savedState != null) {
        state = state.copyWith(gameState: savedState);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> removeSavedGame() async {
    final deleteSavedGameUseCase = ref.read(deleteSavedGameUseCaseProvider);
    await deleteSavedGameUseCase();
  }
}
