import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/presentation/providers/game_controller_provider.dart';
import 'package:tictactoe/features/game/presentation/widgets/gameboard.dart';
import 'package:tictactoe/features/game/presentation/widgets/score_board.dart';

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      ref.listen(
        gameControllerProvider.select((provider) => provider.status),
        (_, GameStatus gameStatus) {
          // if (gameStatus is Win) {
          //   showModalBottomSheet(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return SizedBox(
          //         height: 200,
          //         child: Center(
          //           child: Text('This is a Modal Bottom Sheet'),
          //         ),
          //       );
          //     },
          //   );
          // }
        },
      );

      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              ScoreBoard(),
              Consumer(builder: (context, ref, _) {
                return Text(
                  ref.watch(gameControllerProvider).winner?.symbol ?? "",
                  style: TextStyle(fontSize: 40, color: Colors.amber),
                );
              }),
              Spacer(),
              const Gameboard(),
              Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
