import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required List<Player> board,
    required Player currentPlayer,
    required GameStatus status,
    Player? winner,
    @Default([]) List<int> winningCells,
    required int xScore,
    required int oScore,
    required GameMode gameMode,
    @Default(AIDifficulty.easy) AIDifficulty aiDifficulty,
    @Default([]) List<Move> moveHistory,
  }) = _GameState;

  factory GameState.initial() => const GameState(
        board: [
          Player.none(), Player.none(), Player.none(), // prevent break
          Player.none(), Player.none(), Player.none(),
          Player.none(), Player.none(), Player.none(),
        ],
        currentPlayer: Player.x(),
        status: GameStatus.menu,
        xScore: 0,
        oScore: 0,
        gameMode: GameMode.vsAI,
      );
}

// enum Player {
//   x('X'),
//   o('O'),
//   none()('');
//
//   final String mark;
//   const Player(this.mark);
// }

const List<List<int>> winningCombinations = [
  [0, 1, 2], // Top row
  [3, 4, 5], // Middle row
  [6, 7, 8], // Bottom row
  [0, 3, 6], // Left column
  [1, 4, 7], // Middle column
  [2, 5, 8], // Right column
  [0, 4, 8], // Diagonal \
  [2, 4, 6], // Diagonal /
];
