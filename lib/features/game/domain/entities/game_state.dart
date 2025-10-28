import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required Board board,
    required Player currentPlayer,
    required GameStatus status,
    Player? winner,
    List<Position>? winningLine,
    required int xScore,
    required int oScore,
    String? error,
    required GameMode gameMode,
    @Default(AIDifficulty.easy) AIDifficulty aiDifficulty,
    @Default([]) List<Move> moveHistory,
  }) = _GameState;

  factory GameState.initial() => GameState(
        board: Board.empty(),
        currentPlayer: Player.x(),
        status: GameStatus.menu(),
        xScore: 0,
        oScore: 0,
        gameMode: GameMode.vsAI,
      );
}
