import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';
import 'package:tictactoe/features/game/domain/services/standard_winner_detection.dart';

part 'winner_detection_service_provider.g.dart';

@riverpod
WinnerDetectionService winnerDetectionService(Ref ref) {
  return StandardWinnerDetection();
}
