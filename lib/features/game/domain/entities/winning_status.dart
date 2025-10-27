import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'winning_status.freezed.dart';

@freezed
abstract class WinnerStatus with _$WinnerStatus {
  const WinnerStatus._();

  const factory WinnerStatus.winner(Player player) = Winner;
  const factory WinnerStatus.draw() = Draw;
  const factory WinnerStatus.none() = None;

  bool get hasWinner => this is Winner;
}
