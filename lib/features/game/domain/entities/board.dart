import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'board.freezed.dart';

@freezed
abstract class Board with _$Board {
  const Board._();

  const factory Board({
    required List<Player> cells,
    @Default([]) List<Move> moves,
    @Default(GameStatus.playing) GameStatus status,
    @Default([]) List<int> winningLine,
  }) = _Board;

  factory Board.empty() {
    return Board(
      cells: List.filled(9, Player.none()),
    );
  }

  Player at(int index) => cells[index];

  bool isEmpty(int index) => cells[index].isEmpty;

  List<int> get emptyIndices =>
      cells.asMap().entries.where((e) => e.value.isEmpty).map((e) => e.key).toList();
}
