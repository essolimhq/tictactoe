import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/score.dart';

part 'score_model.freezed.dart';
part 'score_model.g.dart';

@freezed
abstract class ScoreModel with _$ScoreModel {
  const ScoreModel._();

  const factory ScoreModel({
    required int x,
    required int o,
    required int draw,
    @Default(3) int boardSize,
  }) = _ScoreModel;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => _$ScoreModelFromJson(json);

  factory ScoreModel.fromEntity(Score score, {int boardSize = 3}) {
    return ScoreModel(
      x: score.x,
      o: score.o,
      draw: score.draw,
      boardSize: boardSize,
    );
  }

  Score toEntity() {
    return Score(
      x: x,
      o: o,
      draw: draw,
    );
  }
}
