import 'package:tictactoe/features/game/data/datasources/abstracts/game_state_datasource.dart';
import 'package:tictactoe/features/game/data/models/game_state_model.dart';
import 'package:tictactoe/features/game/domain/abstracts/repositories/game_repository.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';

/// Local implementation of GameRepository using GameStateDataSource.
class LocalGameRepository implements GameRepository {
  final GameStateDataSource _dataSource;

  LocalGameRepository(this._dataSource);

  @override
  Future<void> saveGameState(GameState state) async {
    final model = GameStateModel.fromEntity(state);
    await _dataSource.saveGameState(model);
  }

  @override
  Future<GameState> loadGameState() async {
    final gameStateModel = await _dataSource.loadGameState();

    return gameStateModel.toEntity();
  }

  @override
  Future<void> deleteGameState() async {
    return await _dataSource.deleteGameState();
  }

  @override
  Future<bool> gameStateExist() async {
    return await _dataSource.isSavedGameExist();
  }
}
