import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/score.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required Board board,
    required Player currentPlayer,
    required GameStatus status,
    Player? winner,
    List<Position>? winningLine,
    required Score score,
    String? error,
    required GameMode gameMode,
    @Default(AIDifficulty.easy) AIDifficulty aiDifficulty,
    @Default([]) List<Move> moveHistory,
  }) = _GameState;

  factory GameState.initial() => GameState(
        board: Board.empty(),
        currentPlayer: Player.x(),
        status: Menu(),
        score: Score(x: 0, o: 0, draw: 0),
        gameMode: GameMode.vsAI,
      );

  String get playerXLabel => gameMode == GameMode.vsAI ? 'You' : 'Player X';
  String get playerOLabel => gameMode == GameMode.vsAI ? 'AI' : 'Player O';
}
