abstract interface class Storage {
  /// Writes a value to storage.
  Future<void> write<T>(String key, T value);

  /// Reads a value from storage.
  /// Returns the decoded JSON as a Map, or null if the key doesn't exist.
  Future<Map<String, dynamic>?> read(String key);

  /// Deletes a value from storage.
  Future<void> delete(String key);

  /// Checks if a key exists in storage.
  Future<bool> exists(String key);

  /// Closes the storage connection.
  Future<void> close();
}
