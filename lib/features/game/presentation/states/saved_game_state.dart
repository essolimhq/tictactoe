import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

part 'saved_game_state.freezed.dart';

@freezed
abstract class SavedGameState with _$SavedGameState {
  const factory SavedGameState({
    required GameState? gameState,
    String? error,
  }) = _SavedGameState;
}
