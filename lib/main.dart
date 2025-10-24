import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          final router = ref.read(routerProvider);

          return MaterialApp.router(
            title: 'Tic Tac Toe',
            theme: ThemeData(fontFamily: 'SpaceMono'),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
