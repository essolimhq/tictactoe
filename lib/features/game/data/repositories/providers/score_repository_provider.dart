import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/datasources/providers/score_datasource_provider.dart';
import 'package:tictactoe/features/game/data/repositories/local_score_repository.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/score_repository.dart';

part 'score_repository_provider.g.dart';

@riverpod
ScoreRepository scoreRepository(Ref ref) {
  final dataSource = ref.watch(scoreDataSourceProvider);
  return LocalScoreRepository(dataSource);
}
