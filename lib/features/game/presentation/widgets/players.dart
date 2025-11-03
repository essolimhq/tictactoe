import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/presentation/widgets/player_section.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';

class Players extends StatelessWidget {
  const Players({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(gameControllerProvider);
      final isXTurn = state.currentPlayer.isX;

      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            PlayerSection(
              symbol: 'X',
              label: state.playerXLabel,
              isActive: isXTurn,
            ),
            const Text("VS", style: TextStyle(fontSize: 24)),
            PlayerSection(
              symbol: 'O',
              label: state.playerOLabel,
              isActive: !isXTurn,
            ),
          ],
        ),
      );
    });
  }
}
