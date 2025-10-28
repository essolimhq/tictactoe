import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/core/enums/game_enums.dart';
import 'package:tictactoe/features/game/data/models/board_model.dart';
import 'package:tictactoe/features/game/domain/entities/game_state.dart';
import 'package:tictactoe/features/game/domain/entities/game_status.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';

part 'game_state_model.freezed.dart';
part 'game_state_model.g.dart';

@freezed
abstract class GameStateModel with _$GameStateModel {
  const GameStateModel._();

  const factory GameStateModel({
    required BoardModel board,
    required Map<String, dynamic> currentPlayer,
    required String status,
    Map<String, dynamic>? winner,
    required int xScore,
    required int oScore,
    required String gameMode,
    @Default('easy') String aiDifficulty,
  }) = _GameStateModel;

  factory GameStateModel.fromJson(Map<String, dynamic> json) => _$GameStateModelFromJson(json);

  GameState toEntity() => GameState(
        board: board.toEntity(),
        currentPlayer: Player.fromJson(currentPlayer),
        status: _statusFromString(status),
        winner: winner != null ? Player.fromJson(winner!) : null,
        xScore: xScore,
        oScore: oScore,
        gameMode: _gameModeFromString(gameMode),
        aiDifficulty: _aiDifficultyFromString(aiDifficulty),
      );

  factory GameStateModel.fromEntity(GameState state) => GameStateModel(
        board: BoardModel.fromEntity(state.board),
        currentPlayer: state.currentPlayer.toJson(),
        status: state.status.when(
          menu: () => 'menu',
          playing: () => 'playing',
          win: () => 'win',
          isDraw: () => 'draw',
        ),
        winner: state.winner?.toJson(),
        xScore: state.xScore,
        oScore: state.oScore,
        gameMode: state.gameMode.name,
        aiDifficulty: state.aiDifficulty.name,
      );

  GameStatus _statusFromString(String status) {
    switch (status) {
      case 'menu':
        return const GameStatus.menu();
      case 'playing':
        return const GameStatus.playing();
      case 'win':
        return const GameStatus.win();
      case 'draw':
        return const GameStatus.isDraw();
      default:
        return const GameStatus.menu();
    }
  }

  GameMode _gameModeFromString(String mode) {
    return GameMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => GameMode.vsAI,
    );
  }

  AIDifficulty _aiDifficultyFromString(String difficulty) {
    return AIDifficulty.values.firstWhere(
      (e) => e.name == difficulty,
      orElse: () => AIDifficulty.easy,
    );
  }
}
