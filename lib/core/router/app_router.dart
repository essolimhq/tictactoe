import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/game/presentation/screens/game_screen.dart';
import 'package:tictactoe/features/menu/presentation/screens/menu_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: MenuScreen.routeName,
        builder: (context, state) {
          return const MenuScreen();
        },
      ),
      GoRoute(
          path: '/game',
          name: GameScreen.routeName,
          builder: (context, state) {
            return const GameScreen();
          })
    ],
  );
});
