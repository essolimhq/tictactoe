import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tictactoe/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> dismissResumeDialogIfPresent(WidgetTester tester) async {
    await tester.pumpAndSettle();

    final dialogFinder = find.text('Resume your previous game ?');
    if (dialogFinder.evaluate().isNotEmpty) {
      await tester.tap(find.byKey(const Key('resume-no-button')));
      await tester.pumpAndSettle();
    }
  }

  Future<void> tapCell(WidgetTester tester, int index) async {
    final cellFinder = find.byKey(ValueKey('cell-$index'));

    await tester.ensureVisible(cellFinder);
    await tester.pump(const Duration(milliseconds: 50));

    await tester.tap(cellFinder);

    await tester.pump(const Duration(milliseconds: 300));
  }

  group('Complete Game Flow Integration Tests', () {
    testWidgets('Player X wins', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await dismissResumeDialogIfPresent(tester);

      expect(find.text('Welcome to Tic Tac Toe'), findsOneWidget);

      await tester.tap(find.text('Play vs player'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('VS'), findsOneWidget);

      await tapCell(tester, 0);
      await tapCell(tester, 1);
      await tapCell(tester, 4);
      await tapCell(tester, 2);
      await tapCell(tester, 8);

      await tester.pump(const Duration(milliseconds: 500));

      expect(find.textContaining('X'), findsWidgets);
    });

    testWidgets('Game ends in draw', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await dismissResumeDialogIfPresent(tester);

      await tester.tap(find.text('Play vs player'));
      await tester.pump(const Duration(milliseconds: 500));

      await tapCell(tester, 0);
      await tapCell(tester, 1);
      await tapCell(tester, 2);
      await tapCell(tester, 4);
      await tapCell(tester, 3);
      await tapCell(tester, 6);
      await tapCell(tester, 7);
      await tapCell(tester, 5);
      await tapCell(tester, 8);

      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('VS'), findsOneWidget);
    });
  });
}
