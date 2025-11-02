import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/presentation/screens/game_screen.dart';
import 'package:tictactoe/features/game/presentation/widgets/resume_game_dialog.dart';
import 'package:tictactoe/features/game/presentation/widgets/select_game_mode_button.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';
import 'package:tictactoe/features/game/providers/saved_game_controller.dart';

class MenuScreen extends ConsumerStatefulWidget {
  static const routeName = 'MenuScreen';

  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savedGameControllerProvider.notifier).loadSaveGame();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (context, ref, _) {
          ref.listen(gameControllerProvider.select((provider) => provider.status), (_, status) {
            if (status.isPlaying) {
              context.goNamed(GameScreen.routeName);
            }
          });

          ref.listen(savedGameControllerProvider, (_, state) {
            final gameState = state.gameState;

            if (gameState != null) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return ResumeGameDialog(
                    gameState: gameState,
                  );
                },
              );
            }

            if (state.error != null) {
              final snackBar = SnackBar(content: Text(state.error ?? ""));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });

          return Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                AppSpacing.h2xl,
                Image.asset("assets/images/menu_logo.png", width: 200, height: 200),
                AppSpacing.hXl,
                Text(
                  "Welcome to Tic Tac Toe",
                  style:
                      TextStyle(fontSize: 24, color: AppColors.gray, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SelectGameModeButton(
                  "Play vs IA",
                  color: Colors.blue,
                  isPrimary: true,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  onPressed: () {
                    ref.read(gameControllerProvider.notifier).start(GameMode.vsAI);
                  },
                ),
                AppSpacing.hXl,
                SelectGameModeButton(
                  "Play vs player",
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  isPrimary: false,
                  onPressed: () {
                    ref.read(gameControllerProvider.notifier).start(GameMode.vsHuman);
                  },
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
