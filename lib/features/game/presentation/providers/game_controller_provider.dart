import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

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

  void play(int index) {
    if (index < 0 || index > 9) return;

    final cell = state.board[index];
    if (!cell.isEmpty || state.status != GameStatus.playing) return;

    HapticFeedback.lightImpact();

    _updateBoard(index);
    _switchPlayer();
  }

  bool isWinnerCell() {
    return false;
  }

  Player? getPlayer(int index) {
    if (index < 0 || index > 9) return null;

    return state.board[index];
  }

  void _updateBoard(int index) {
    final updatedBoard = state.board.indexed.map((i) {
      return index == i.$1 ? state.currentPlayer : i.$2;
    }).toList();
    state = state.copyWith(board: updatedBoard);
  }

  void _switchPlayer() {
    state = state.copyWith(currentPlayer: state.currentPlayer.opposite);
  }
}
