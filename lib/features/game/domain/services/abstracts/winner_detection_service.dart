import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';

/// Service for detecting winning conditions on a board.
abstract class WinnerDetectionService {
  WinnerStatus checkWinner(
    Board board,
    Position lastMovePosition,
    Player player,
  );
}
