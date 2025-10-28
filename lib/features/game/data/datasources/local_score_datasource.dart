import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tictactoe/features/game/data/datasources/abstracts/score_datasource.dart';

/// Local implementation using Hive for score persistence.
class LocalScoreDataSource implements ScoreDataSource {
  static const String _boxName = 'scores_box';
  static const String _xScoreKey = 'x_score';
  static const String _oScoreKey = 'o_score';

  Box<int>? _box;

  Future<Either<Exception, Box<int>>> _getBox() async {
    try {
      final box = _box;
      if (box != null && box.isOpen) {
        return right(box);
      }

      final openedBox = await Hive.openBox<int>(_boxName);
      _box = openedBox;
      return right(openedBox);
    } catch (e) {
      return left(Exception('Failed to open Hive box: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveScores({
    required int xScore,
    required int oScore,
  }) async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) async {
        try {
          await box.put(_xScoreKey, xScore);
          await box.put(_oScoreKey, oScore);
          return right(unit);
        } catch (e) {
          return left(Exception('Failed to save scores: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Option<({int xScore, int oScore})>>> loadScores() async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) {
        try {
          final xScore = box.get(_xScoreKey);
          final oScore = box.get(_oScoreKey);

          if (xScore == null || oScore == null) {
            return right(none());
          }

          return right(some((xScore: xScore, oScore: oScore)));
        } catch (e) {
          return left(Exception('Failed to load scores: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> resetScores() async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) async {
        try {
          await box.put(_xScoreKey, 0);
          await box.put(_oScoreKey, 0);
          return right(unit);
        } catch (e) {
          return left(Exception('Failed to reset scores: $e'));
        }
      },
    );
  }

  /// Closes the Hive box.
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}
