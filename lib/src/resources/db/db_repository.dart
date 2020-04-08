abstract class DbRepository {
  /// Saves the [value] with an auto-increment key.
  Future<int> add(value);

  /// Deletes the given [key] from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> delete(dynamic key);

  /// Deletes the n-th key from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> deleteAt(int index);

  /// Returns the value associated with the given [key]. If the key does not
  /// exist, `null` is returned.
  ///
  /// If [defaultValue] is specified, it is returned in case the key does not
  /// exist.
  get(dynamic key, {defaultValue});

  /// Returns the value associated with the n-th key.
  getAt(int index);

  /// Saves the [key] - [value] pair.
  Future<void> put(dynamic key, value);

  /// Associates the [value] with the n-th key. An exception is raised if the
  /// key does not exist.
  Future<void> putAt(int index, value);
}
