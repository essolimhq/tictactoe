import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/presentation/screens/menu_screen.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_result_dialog.dart';
import 'package:tictactoe/features/game/presentation/widgets/gameboard.dart';
import 'package:tictactoe/features/game/presentation/widgets/score_board.dart';
import 'package:tictactoe/features/game/providers/game_controller_provider.dart';

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        ref.listen(
          gameControllerProvider.select((provider) => (provider.status, provider.winner)),
          (_, state) {
            final (gameStatus, winner) = state;
            if (gameStatus is Win || gameStatus is IsDraw) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return GameResultDialog(
                    gameStatus: gameStatus,
                    winner: winner ?? Player.none(),
                  );
                },
              );
            }

            if (gameStatus.isInMenu) {
              context.goNamed(MenuScreen.routeName);
            }
          },
        );

        return Scaffold(
          backgroundColor: Colors.white,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              ref.read(gameControllerProvider.notifier).quit();
                            },
                            icon: Icon(Icons.home)),
                        Text("Home"),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              ref.read(gameControllerProvider.notifier).reStart();
                            },
                            icon: Icon(Icons.refresh)),
                        Text("Reset"),
                      ],
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
