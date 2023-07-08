import '../../../../core/errors/exceptions.dart';
import '../../../../core/cache/hive_local_storage.dart';
import '../../../../core/cache/secure_local_storage.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user_entity.dart';

sealed class AuthLocalDataSource {
  Future<UserEntity> checkSignInStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _localStorage;
  const AuthLocalDataSourceImpl(
    this._secureLocalStorage,
    this._localStorage,
  );

  @override
  Future<UserEntity> checkSignInStatus() async {
    try {
      final userId = await _secureLocalStorage.load(key: "user_id");
      final result = await _localStorage.load(key: "user", boxName: "cache");
      if (result != null && userId.isNotEmpty) {
        if (result is UserEntity) {
          return result;
        }
      }

      throw CacheException();
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}
