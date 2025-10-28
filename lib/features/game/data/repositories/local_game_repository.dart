import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/data/models/game_state_model.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

/// Local implementation of GameRepository using GameStateDataSource.
class LocalGameRepository implements GameRepository {
  final GameStateDataSource _dataSource;

  LocalGameRepository(this._dataSource);

  @override
  Future<Either<Exception, Unit>> saveGameState(GameState state) async {
    try {
      final model = GameStateModel.fromEntity(state);
      return await _dataSource.saveGameState(model);
    } catch (e) {
      return left(Exception('Failed to save game state in repository: $e'));
    }
  }

  @override
  Future<Either<Exception, Option<GameState>>> loadGameState() async {
    return (await _dataSource.loadGameState()).fold(
      (error) => left(error),
      (optionModel) => right(
        optionModel.map((model) => model.toEntity()),
      ),
    );
  }

  @override
  Future<Either<Exception, Unit>> deleteGameState() async {
    return await _dataSource.deleteGameState();
  }
}
