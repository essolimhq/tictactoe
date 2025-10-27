import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
abstract class Position with _$Position {
  const Position._();

  const factory Position({
    required int row,
    required int col,
  }) = _Position;

  factory Position.fromIndex(int index) {
    assert(index >= 0 && index < 9, 'Index must be between 0 and 8');
    return Position(
      row: index ~/ 3,
      col: index % 3,
    );
  }

  int get index => row * 3 + col;

  bool get isValid => index >= 0 && index < 9;

  bool get isCenter => index == 4;

  bool get isCorner => [0, 2, 6, 8].contains(index);

  bool get isEdge => [1, 3, 5, 7].contains(index);

  bool get isDiagonal => row == col;

  bool get isAntiDiagonal => row + col == 3 - 1;

  Position get nextCell => Position.fromIndex(index + 1);

  Position get previousCell => Position.fromIndex(index - 1);

  Position get nextColumn => Position.fromIndex(index + 3);

  Position get previousColumn => Position.fromIndex(index + 6);
}
