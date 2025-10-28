import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/check_winner_usecase.dart';
import 'package:tictactoe/features/game/presentation/providers/winner_detection_service_provider.dart';

part 'check_winner_usecase_provider.g.dart';

@riverpod
CheckWinnerUseCase checkWinnerUseCase(Ref ref) {
  final winnerDetectionService = ref.watch(winnerDetectionServiceProvider);
  return CheckWinnerUseCase(winnerDetectionService);
}
