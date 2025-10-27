import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/presentation/providers/game_controller_provider.dart';
import 'package:tictactoe/features/game/presentation/widgets/animated_winning_line.dart';
import 'package:tictactoe/features/game/presentation/widgets/board_cell.dart';

class Gameboard extends StatelessWidget {
  const Gameboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 320,
      margin: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Consumer(builder: (context, ref, _) {
              return AnimatedWinningLine(
                winningLine: ref
                    .watch(gameControllerProvider.select((p) => p.winningLine))
                    ?.map((e) => e.index)
                    .toList(),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final delay = (index * 50).ms;

                    return BoardCell(index: index)
                        .animate()
                        .fadeIn(duration: 300.ms, delay: delay)
                        .scale(begin: const Offset(0.8, 0.8), delay: delay);
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
