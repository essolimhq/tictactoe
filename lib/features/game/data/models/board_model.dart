import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
abstract class BoardModel with _$BoardModel {
  const BoardModel._();

  const factory BoardModel({
    required List<Map<String, dynamic>> cells,
    @Default(3) int size,
    @Default(3) int winningLength,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) => _$BoardModelFromJson(json);

  Board toEntity() => Board(
        cells: cells.map((json) => Player.fromJson(json)).toList(),
        size: size,
        winningLength: winningLength,
      );

  factory BoardModel.fromEntity(Board board) => BoardModel(
        cells: board.cells.map((player) => player.toJson()).toList(),
        size: board.size,
        winningLength: board.winningLength,
      );
}
