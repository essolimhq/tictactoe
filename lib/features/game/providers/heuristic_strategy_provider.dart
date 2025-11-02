import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/strategies/abstracts/ai_strategy.dart';
import 'package:tictactoe/features/game/domain/strategies/heuristic_strategy.dart';
import 'package:tictactoe/features/game/providers/winner_detection_service_provider.dart';

part 'heuristic_strategy_provider.g.dart';

@riverpod
AIStrategy heuristicStrategy(Ref ref) {
  final winnerDetectionService = ref.watch(winnerDetectionServiceProvider);
  return HeuristicStrategy(winnerDetectionService);
}
