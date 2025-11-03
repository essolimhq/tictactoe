import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/design_system/tokens/app_colors.dart';
import 'package:tictactoe/core/design_system/tokens/app_spacing.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';
import 'package:tictactoe/features/game/providers/saved_game_controller.dart';
import 'package:tictactoe/shared/widgets/app_dialog.dart';

class ResumeGameDialog extends StatelessWidget {
  final GameState gameState;

  const ResumeGameDialog({
    required this.gameState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Resume your previous game ?"),
            SizedBox(height: 24),
            ElevatedButton.icon(
              key: const Key('resume-yes-button'),
              onPressed: () {
                final gameController = ref.read(gameControllerProvider.notifier);
                gameController.resumeGame(gameState);

                if (context.mounted) context.pop();
              },
              label: Text(
                "Yes",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shadowColor: Colors.transparent,
                minimumSize: Size.fromHeight(AppSpacing.xxl),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              key: const Key('resume-no-button'),
              onPressed: () async {
                final savedGameController = ref.read(savedGameControllerProvider.notifier);
                await savedGameController.removeSavedGame();

                if (context.mounted) context.pop();
              },
              label: Text(
                "No",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shadowColor: Colors.transparent,
                minimumSize: Size.fromHeight(AppSpacing.xxl),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
