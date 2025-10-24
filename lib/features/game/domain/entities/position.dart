import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
abstract class Position with _$Position {
  const Position._();

  const factory Position({
    required int index,
  }) = _BoardPosition;

  factory Position.fromRowCol(int row, int col) {
    return Position(index: row * 3 + col);
  }

  int get row => index ~/ 3;
  int get col => index % 3;

  bool get isValid => index >= 0 && index < 9;
  bool get isCenter => index == 4;
  bool get isCorner => [0, 2, 6, 8].contains(index);
  bool get isEdge => [1, 3, 5, 7].contains(index);
}
