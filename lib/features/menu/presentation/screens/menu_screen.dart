import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/presentation/providers/game_controller_provider.dart';
import 'package:tictactoe/features/game/presentation/screens/game_screen.dart';
import 'package:tictactoe/features/menu/presentation/widgets/select_game_mode_button.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = 'MenuScreen';

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer(
        builder: (context, ref, _) {
          ref.listen(gameControllerProvider.select((provider) => provider.status), (_, status) {
            if (status.isPlaying) {
              context.goNamed(GameScreen.routeName);
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
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                AppSpacing.hXl,
                SelectGameModeButton(
                  "Play vs IA",
                  color: Colors.blue,
                  isPrimary: true,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  onPressed: () {
                    ref.read(gameControllerProvider.notifier).start(GameMode.vsAI);
                  },
                ),
                AppSpacing.hSm,
                SelectGameModeButton(
                  "Play vs player",
                  color: Colors.teal,
                  margin: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  isPrimary: false,
                  onPressed: () {
                    ref.read(gameControllerProvider.notifier).start(GameMode.vsHuman);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
