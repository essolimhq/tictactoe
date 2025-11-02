import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.freezed.dart';

@freezed
abstract class Score with _$Score {
  const Score._();

  const factory Score({
    required int x,
    required int o,
    required int draw,
  }) = _Score;
}
