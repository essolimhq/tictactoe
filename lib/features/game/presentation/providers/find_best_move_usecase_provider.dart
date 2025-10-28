import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/find_best_move_usecase.dart';
import 'package:tictactoe/features/game/presentation/providers/minimax_strategy_provider.dart';

part 'find_best_move_usecase_provider.g.dart';

/// Provider for FindBestMoveUseCase.
///
/// By default uses MinimaxStrategy (impossible difficulty).
/// GameController can create its own instance with different strategy
/// based on the selected AI difficulty level.
@riverpod
FindBestMoveUseCase findBestMoveUseCase(Ref ref) {
  final strategy = ref.watch(minimaxStrategyProvider);
  return FindBestMoveUseCase(strategy);
}
