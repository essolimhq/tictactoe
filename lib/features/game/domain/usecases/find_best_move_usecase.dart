import 'package:fpdart/fpdart.dart';
import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/errors/game_errors.dart';
import 'package:tictactoe/features/game/domain/strategies/abstracts/ai_strategy.dart';

/// Use case for finding the best move for an AI player.
///
/// This use case delegates to an AIStrategy implementation.
/// The strategy can be swapped based on difficulty level.
class FindBestMoveUseCase {
  final AIStrategy _strategy;

  FindBestMoveUseCase(this._strategy);

  /// Finds the best move for the AI player.
  ///
  /// Parameters:
  /// - [board]: Current board state
  /// - [aiPlayer]: The player the AI is playing for
  ///
  /// Returns:
  /// - Left(GameError) if no valid moves available
  /// - Right(Position) with the best move position
  Either<GameError, Position> call(Board board, Player aiPlayer) {
    return _strategy.findBestMove(board, aiPlayer);
  }
}
