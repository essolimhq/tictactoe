import 'package:flutter/material.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';
import 'package:tictactoe/features/game/presentation/widgets/gameboard.dart';
import 'package:tictactoe/features/game/presentation/widgets/score_board.dart';

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ScoreBoard(),
            Spacer(),
            const Gameboard(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
