import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';

part 'player.freezed.dart';

@freezed
sealed class Player with _$Player {
  const Player._();

  const factory Player.x() = PlayerX;
  const factory Player.o() = PlayerO;
  const factory Player.none() = EmptyCell;

  String get symbol => when(
        x: () => 'X',
        o: () => 'O',
        none: () => '',
      );

  Color get color => when(
        x: () => AppColors.primary,
        o: () => AppColors.secondary,
        none: () => Colors.transparent,
      );

  IconData get icon => when(
        x: () => Icons.close,
        o: () => Icons.circle_outlined,
        none: () => Icons.crop_square,
      );

  Player get opposite => when(
        x: () => const Player.o(),
        o: () => const Player.x(),
        none: () => const Player.none(),
      );

  bool get isValid => this != const Player.none();
  bool get isX => this == const Player.x();
  bool get isO => this == const Player.o();
  bool get isEmpty => this == const Player.none();

  factory Player.fromString(String str) {
    switch (str.toUpperCase()) {
      case 'X':
        return const Player.x();
      case 'O':
        return const Player.o();
      default:
        return const Player.none();
    }
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    switch (type) {
      case 'x':
        return const Player.x();
      case 'o':
        return const Player.o();
      default:
        return const Player.none();
    }
  }

  Map<String, dynamic> toJson() => {
        'type': when(
          x: () => 'x',
          o: () => 'o',
          none: () => 'none',
        ),
      };
}
