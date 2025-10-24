import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

part 'game_controller_provider.g.dart';

@riverpod
class GameController extends _$GameController {
  @override
  GameState build() {
    return GameState.initial();
  }

  void setGameMode(GameMode mode) {
    state = state.copyWith(gameMode: mode);
  }

  void start(GameMode mode) {
    state = state.copyWith(
      gameMode: mode,
      status: GameStatus.playing,
    );
  }
}
