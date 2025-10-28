import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
abstract class Position with _$Position {
  const Position._();

  const factory Position({
    required int row,
    required int col,
    @Default(3) int boardSize,
  }) = _Position;

  factory Position.fromIndex(int index, {int boardSize = 3}) {
    assert(index >= 0 && index < boardSize * boardSize,
        'Index must be between 0 and ${boardSize * boardSize - 1}');
    return Position(
      row: index ~/ boardSize,
      col: index % boardSize,
      boardSize: boardSize,
    );
  }

  int get index => row * boardSize + col;

  bool get isValid {
    return row >= 0 && row < boardSize && col >= 0 && col < boardSize;
  }

  bool get isCenter {
    final center = boardSize ~/ 2;
    return row == center && col == center;
  }

  bool get isCorner {
    return (row == 0 || row == boardSize - 1) && (col == 0 || col == boardSize - 1);
  }

  bool get isEdge {
    final onBorder = row == 0 || row == boardSize - 1 || col == 0 || col == boardSize - 1;
    return onBorder && !isCorner && !isCenter;
  }

  bool get isDiagonal => row == col;

  bool get isAntiDiagonal => row + col == boardSize - 1;
}
