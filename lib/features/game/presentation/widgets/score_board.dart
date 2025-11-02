import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/presentation/widgets/score_item.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  const Color(0xFFA00000).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Consumer(builder: (context, ref, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ScoreItem(label: 'PLAYER X', score: ref.watch(gameControllerProvider).score.x),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white24,
                  ),
                  ScoreItem(label: 'DRAWS', score: ref.watch(gameControllerProvider).score.draw),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white24,
                  ),
                  ScoreItem(label: 'PLAYER O', score: ref.watch(gameControllerProvider).score.o),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
