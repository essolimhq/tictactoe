import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';

/// Use case for checking if there's a winner after a move.
class CheckWinnerUseCase {
  final WinnerDetectionService _winnerDetectionService;

  CheckWinnerUseCase(this._winnerDetectionService);

  WinnerStatus call(
    Board board,
    Position lastMovePosition,
    Player currentPlayer,
  ) {
    return _winnerDetectionService.checkWinner(
      board,
      lastMovePosition,
      currentPlayer,
    );
  }
}
