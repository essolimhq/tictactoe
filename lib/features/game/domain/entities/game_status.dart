import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_status.freezed.dart';

@freezed
abstract class GameStatus with _$GameStatus {
  const GameStatus._();

  const factory GameStatus.playing() = Playing;
  const factory GameStatus.win() = Win;
  const factory GameStatus.draw() = Draw;
  const factory GameStatus.menu() = Menu;

  bool get isPlaying => this is Playing;
  bool get isWin => this is Win;
  bool get isDraw => this is Draw;
  bool get isInMenu => this is Menu;
}
