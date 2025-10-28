import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';

/// Hive implementation of Storage.
class HiveStorage implements Storage {
  static const String _boxName = 'app_storage';

  Box? _box;

  /// Gets or opens the Hive box.
  Future<Either<Exception, Box>> _getBox() async {
    try {
      final box = _box;
      if (box != null && box.isOpen) {
        return right(box);
      }

      final openedBox = await Hive.openBox(_boxName);
      _box = openedBox;
      return right(openedBox);
    } catch (e) {
      return left(Exception('Failed to open Hive box: $e'));
    }
  }

  @override
  Future<Either<Exception, Unit>> write<T>(String key, T value) async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) async {
        try {
          await box.put(key, value);
          return right(unit);
        } catch (e) {
          return left(Exception('Failed to write key "$key": $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Option<T>>> read<T>(String key) async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) {
        try {
          final value = box.get(key);

          if (value == null) {
            return right(none<T>());
          }

          if (value is! T) {
            return left(Exception('Value for key "$key" is not of type $T'));
          }

          return right(some(value));
        } catch (e) {
          return left(Exception('Failed to read key "$key": $e'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> delete(String key) async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) async {
        try {
          await box.delete(key);
          return right(unit);
        } catch (e) {
          return left(Exception('Failed to delete key "$key": $e'));
        }
      },
    );
  }

  @override
  Future<bool> exists(String key) async {
    return (await _getBox()).fold(
      (_) => false,
      (box) => box.containsKey(key),
    );
  }

  @override
  Future<Either<Exception, Unit>> clear() async {
    return (await _getBox()).fold(
      (error) => left(error),
      (box) async {
        try {
          await box.clear();
          return right(unit);
        } catch (e) {
          return left(Exception('Failed to clear storage: $e'));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _box?.close();
    _box = null;
  }
}
