import 'local_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _storage;
  const SecureLocalStorage(this._storage);

  @override
  Future<String> load({required String key, String? boxName}) async {
    final result = await _storage.read(key: key);

    return result ?? "";
  }

  @override
  Future<void> save({
    required String key,
    required value,
    String? boxName,
  }) async {
    final result = await _storage.write(key: key, value: value);

    return result;
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    await _storage.delete(key: key);

    return;
  }
}
