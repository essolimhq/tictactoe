import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/usecases/play_move_usecase.dart';

part 'play_move_usecase_provider.g.dart';

@riverpod
PlayMoveUseCase playMoveUseCase(Ref ref) {
  return PlayMoveUseCase();
}
