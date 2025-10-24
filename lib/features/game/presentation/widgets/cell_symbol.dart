import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tictactoe/core/design_system/tokens/app_colors.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

class CellSymbol extends StatelessWidget {
  final Player player;
  final bool isWinningCell;

  const CellSymbol({
    required this.player,
    required this.isWinningCell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (player.isEmpty) return const SizedBox.shrink();

    final color = player.isX ? AppColors.primary : AppColors.secondary;

    var symbol = Text(
      player.symbol,
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: color,
        shadows: [
          Shadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 10,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 200.ms).scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.easeOutBack,
        );

    if (isWinningCell) {
      symbol = symbol
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 2.seconds)
          .shake(hz: 2, offset: const Offset(2, 0));
    }

    return symbol;
  }
}
