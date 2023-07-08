abstract class LocalStorage {
  Future<void> save({
    required String key,
    required dynamic value,
    String? boxName,
  });

  Future<dynamic> load({
    required String key,
    String? boxName,
  });

  Future<void> delete({
    required String key,
    String? boxName,
  });
}