import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';

part 'move.freezed.dart';

@freezed
abstract class Move with _$Move {
  const factory Move({
    required Position position,
    required Player player,
    required DateTime timestamp,
  }) = _Move;
}
