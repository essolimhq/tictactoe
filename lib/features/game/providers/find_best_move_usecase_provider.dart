import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/find_best_move_usecase.dart';
import 'package:tictactoe/features/game/providers/minimax_strategy_provider.dart';

part 'find_best_move_usecase_provider.g.dart';

@riverpod
FindBestMoveUseCase findBestMoveUseCase(Ref ref) {
  final strategy = ref.watch(minimaxStrategyProvider);
  return FindBestMoveUseCase(strategy);
}
