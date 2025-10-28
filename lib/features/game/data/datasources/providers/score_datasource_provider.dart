import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/services/providers/storage_provider.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';
import 'package:tictactoe/features/game/data/datasources/score_local_datasource.dart';

part 'score_datasource_provider.g.dart';

@riverpod
ScoreDataSource scoreDataSource(Ref ref) {
  final storage = ref.watch(storageProvider);
  return LocalStatsSavingDataSource(storage);
}
