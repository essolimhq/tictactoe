import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/design_system/tokens/app_colors.dart';
import 'package:tictactoe/core/design_system/tokens/app_sizes.dart';
import 'package:tictactoe/core/design_system/tokens/app_spacing.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';

class GameResultDialog extends StatelessWidget {
  final GameStatus gameStatus;
  final Player winner;

  const GameResultDialog({
    required this.gameStatus,
    required this.winner,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final text = gameStatus.isWin
        ? winner.isX
            ? "Victoire du Joueur X"
            : "Victoire du joueur O"
        : "Match nul";
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Consumer(builder: (context, ref, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text, style: const TextStyle(fontSize: AppSizes.xl, color: AppColors.primary)),
                AppSpacing.hMd,
                ElevatedButton(
                  onPressed: () {
                    final gameController = ref.read(gameControllerProvider.notifier);
                    gameController.reStart();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shadowColor: Colors.transparent,
                    minimumSize: Size.fromHeight(AppSpacing.xxl),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.redo,
                        color: Colors.white,
                        size: AppSizes.lg,
                      ),
                      AppSpacing.horizontalSm,
                      Text(
                        "Rejouer",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.hMd,
                ElevatedButton(
                  onPressed: () {
                    final gameController = ref.read(gameControllerProvider.notifier);
                    gameController.quit();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gray,
                    shadowColor: Colors.transparent,
                    minimumSize: Size.fromHeight(AppSpacing.xxl),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: AppSizes.lg,
                      ),
                      AppSpacing.horizontalSm,
                      Text(
                        "Page d'accueil",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
