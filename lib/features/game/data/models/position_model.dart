import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

part 'position_model.freezed.dart';
part 'position_model.g.dart';

@freezed
abstract class PositionModel with _$PositionModel {
  const PositionModel._();

  const factory PositionModel({
    required int row,
    required int col,
    @Default(3) int boardSize,
  }) = _PositionModel;

  factory PositionModel.fromJson(Map<String, dynamic> json) => _$PositionModelFromJson(json);

  Position toEntity() => Position(
        row: row,
        col: col,
        boardSize: boardSize,
      );

  factory PositionModel.fromEntity(Position position) => PositionModel(
        row: position.row,
        col: position.col,
        boardSize: position.boardSize,
      );
}
