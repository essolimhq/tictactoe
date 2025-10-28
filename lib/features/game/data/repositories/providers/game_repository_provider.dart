import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/datasources/providers/game_state_datasource_provider.dart';
import 'package:tictactoe/features/game/data/repositories/local_game_repository.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';

part 'game_repository_provider.g.dart';

@riverpod
GameRepository gameRepository(Ref ref) {
  final dataSource = ref.watch(gameStateDataSourceProvider);
  return LocalGameRepository(dataSource);
}
