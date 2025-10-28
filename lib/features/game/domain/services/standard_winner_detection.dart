import 'package:tictactoe/features/game/domain/entities/board.dart';
import 'package:tictactoe/features/game/domain/entities/player.dart';
import 'package:tictactoe/features/game/domain/entities/position.dart';
import 'package:tictactoe/features/game/domain/entities/winning_status.dart';
import 'package:tictactoe/features/game/domain/services/abstracts/winner_detection_service.dart';

/// Implementation of winner detection for tic-tac-toe games.
class StandardWinnerDetection implements WinnerDetectionService {
  @override
  WinnerStatus checkWinner(
    Board board,
    Position lastMovePosition,
    Player player,
  ) {
    final size = board.size;
    final winLength = board.winningLength;

    // Check the Row where the move was made
    List<Position>? winningLine = _checkLine(
      board,
      lastMovePosition.copyWith(col: 0),
      player,
      rowIncrement: 0,
      colIncrement: 1,
      requiredLength: winLength,
    );
    if (winningLine != null) {
      return WinnerStatus.winner(player, winningLine);
    }

    // Check the Column where the move was made
    winningLine = _checkLine(
      board,
      lastMovePosition.copyWith(row: 0),
      player,
      rowIncrement: 1,
      colIncrement: 0,
      requiredLength: winLength,
    );
    if (winningLine != null) {
      return WinnerStatus.winner(player, winningLine);
    }

    // Check Main Diagonal (only if the move was on a diagonal)
    if (lastMovePosition.isDiagonal) {
      winningLine = _checkLine(
        board,
        Position(row: 0, col: 0, boardSize: size),
        player,
        rowIncrement: 1,
        colIncrement: 1,
        requiredLength: winLength,
      );
      if (winningLine != null) {
        return WinnerStatus.winner(player, winningLine);
      }
    }

    // Check Anti-diagonal (only if the move was on the anti-diagonal)
    if (lastMovePosition.isAntiDiagonal) {
      winningLine = _checkLine(
        board,
        Position(row: 0, col: size - 1, boardSize: size),
        player,
        rowIncrement: 1,
        colIncrement: -1,
        requiredLength: winLength,
      );
      if (winningLine != null) {
        return WinnerStatus.winner(player, winningLine);
      }
    }

    if (board.isFull) {
      return const WinnerStatus.draw();
    }

    // Game continues
    return const WinnerStatus.none();
  }

  /// Checks if a line has the required number of consecutive positions
  /// with the same player.
  List<Position>? _checkLine(
    Board board,
    Position startPosition,
    Player player, {
    required int rowIncrement,
    required int colIncrement,
    required int requiredLength,
  }) {
    final size = board.size;
    final List<Position> consecutivePositions = [];

    for (int i = 0; i < size; i++) {
      final position = Position(
        row: startPosition.row + i * rowIncrement,
        col: startPosition.col + i * colIncrement,
        boardSize: size,
      );

      if (!position.isValid) break;

      if (board.at(position) == player) {
        consecutivePositions.add(position);

        // Check if we have enough consecutive positions to win
        if (consecutivePositions.length == requiredLength) {
          return consecutivePositions;
        }
      } else {
        consecutivePositions.clear();
      }
    }

    return null;
  }
}
