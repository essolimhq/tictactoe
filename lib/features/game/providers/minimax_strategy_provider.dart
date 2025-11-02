import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/strategies/abstracts/ai_strategy.dart';
import 'package:tictactoe/features/game/domain/strategies/minimax_strategy.dart';
import 'package:tictactoe/features/game/providers/winner_detection_service_provider.dart';

part 'minimax_strategy_provider.g.dart';

@riverpod
AIStrategy minimaxStrategy(Ref ref) {
  final winnerDetectionService = ref.watch(winnerDetectionServiceProvider);
  return MinimaxStrategy(winnerDetectionService);
}
