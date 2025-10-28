import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_errors.freezed.dart';

/// Base class for all game-related errors
@freezed
sealed class GameError with _$GameError {
  /// Thrown when trying to play on an invalid position
  const factory GameError.invalidPosition({
    required int row,
    required int col,
    required int boardSize,
  }) = InvalidPositionError;

  /// Thrown when trying to play on an already occupied cell
  const factory GameError.cellOccupied({
    required int row,
    required int col,
  }) = CellOccupiedError;

  /// Thrown when trying to play while the game is not in playing state
  const factory GameError.gameNotActive({
    required String currentStatus,
  }) = GameNotActiveError;

  /// Thrown when trying to perform an action that requires the game to be over
  const factory GameError.gameNotOver() = GameNotOverError;

  /// Thrown when board size is invalid
  const factory GameError.invalidBoardSize({
    required int size,
    required List<int> allowedSizes,
  }) = InvalidBoardSizeError;

  /// Thrown when no valid moves are available
  const factory GameError.noValidMoves() = NoValidMovesError;
}
