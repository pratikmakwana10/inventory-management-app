import 'package:hive/hive.dart';

class HiveHelper {
  /// Manages the lifecycle of a Hive box and performs a task on it.
  Future<T> _performTaskOnBox<T>(
    String boxName,
    Future<T> Function(Box<dynamic> box) task,
  ) async {
    final box = await Hive.openBox<dynamic>(boxName);
    try {
      return await task(box);
    } finally {
      await box.close();
    }
  }

  /// Saves data into a Hive box.
  /// The data type is inferred from the value provided.
  Future<void> saveData<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    await _performTaskOnBox<void>(
      boxName,
      (box) async {
        await box.put(key, value);
      },
    );
  }

  /// Retrieves data from a Hive box with the specified key.
  /// The expected return type is T.
  Future<Map<String, dynamic>?> getData({
    required String boxName,
    required String key,
  }) async {
    return _performTaskOnBox<Map<String, dynamic>?>(
      boxName,
      (box) async {
        final result = await box.get(key);
        return result != null ? Map<String, dynamic>.from(result as Map) : null;
      },
    );
  }

  /// Updates a value in the specified Hive box.
  /// The data type is inferred from the value provided.
  Future<void> updateValue<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    await _performTaskOnBox<void>(
      boxName,
      (box) async {
        await box.put(key, value);
      },
    );
  }

  /// Deletes a value from the specified Hive box.
  Future<void> deleteValue({
    required String boxName,
    required String key,
  }) async {
    await _performTaskOnBox<void>(
      boxName,
      (box) async {
        await box.delete(key);
      },
    );
  }

  /// Clears all data from all Hive boxes.
  Future<void> clearPreferencesData() async {
    // TODO : Add all the keys here also to clear preference
    final boxKeys = <String>[
      // HiveConstants.userBox,
      // HiveConstants.userData,
    ];
    for (final key in boxKeys) {
      await _performTaskOnBox<void>(
        key,
        (box) async {
          await box.clear();
        },
      );
    }
  }
}
