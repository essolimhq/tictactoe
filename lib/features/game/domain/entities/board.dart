import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/move.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

part 'board.freezed.dart';

@freezed
abstract class Board with _$Board {
  const Board._();

  const factory Board({
    required List<Player> cells,
    @Default(3) int size,
    @Default(3) int winningLength,
    @Default([]) List<Move> moves,
    @Default(GameStatus.menu()) GameStatus status,
    @Default([]) List<int> winningLine,
  }) = _Board;

  factory Board.empty() {
    return Board(
      cells: List.filled(9, const Player.none()),
      size: 3,
      winningLength: 3,
    );
  }

  factory Board.withSize({
    required int size,
    int? winningLength,
  }) {
    return Board(
      cells: List.filled(size * size, const Player.none()),
      size: size,
      winningLength: winningLength ?? size,
    );
  }

  int get totalCells => size * size;

  Player at(Position pos) => cells[pos.index];

  bool isEmpty(Position pos) => at(pos).isEmpty;

  bool isOccupied(Position pos) => !isEmpty(pos);

  List<int> get emptyIndices =>
      cells.asMap().entries.where((e) => e.value.isEmpty).map((e) => e.key).toList();

  List<Player> get emptyPositions => cells.where((cell) => cell.isEmpty).toList();

  bool get isFull => emptyIndices.isEmpty;
}
