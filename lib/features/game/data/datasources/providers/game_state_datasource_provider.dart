import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/services/providers/storage_provider.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/data/datasources/local_game_saving_datasource.dart';

part 'game_state_datasource_provider.g.dart';

@riverpod
GameStateDataSource gameStateDataSource(Ref ref) {
  final storage = ref.watch(storageProvider);
  return LocalGameSavingDataSource(storage);
}
