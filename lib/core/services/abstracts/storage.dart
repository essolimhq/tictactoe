import 'package:fpdart/fpdart.dart';

/// Abstract storage interface for key-value persistence.
abstract interface class Storage {
  /// Writes a value to storage.
  Future<Either<Exception, Unit>> write<T>(String key, T value);

  /// Reads a value from storage.
  Future<Either<Exception, Option<T>>> read<T>(String key);

  /// Deletes a value from storage.
  Future<Either<Exception, Unit>> delete(String key);

  /// Checks if a key exists in storage.
  Future<bool> exists(String key);

  /// Clears all data from storage.
  Future<Either<Exception, Unit>> clear();

  /// Closes the storage connection.
  Future<void> close();
}
