import 'package:fpdart/fpdart.dart';

import '../../../../core/cache/hive_local_storage.dart';
import '../../../../core/cache/secure_local_storage.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/usecase_params.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _localStorage;
  const AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._secureLocalStorage,
    this._localStorage,
  );

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    try {
      final model = LoginModel(
        email: params.email,
        password: params.password,
      );

      final result = await _authRemoteDataSource.login(model);
      if (result.password != params.password) {
        return Left(CredentialFailure());
      }

      await _secureLocalStorage.save(key: "user_id", value: result.userId);
      await _localStorage.save(key: "user", value: result, boxName: "cache");

      return Right(result);
    } on AuthException {
      return Left(CredentialFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await _authRemoteDataSource.logout();

      await _secureLocalStorage.delete(key: "user_id");
      await _localStorage.delete(key: "user", boxName: "cache");

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> register(RegisterParams params) async {
    try {
      final model = RegisterModel(
        username: params.username,
        email: params.email,
        password: params.password,
      );

      final result = await _authRemoteDataSource.register(model);
      return Right(result);
    } on DuplicateEmailException {
      return Left(DuplicateEmailFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> checkSignInStatus() async {
    try {
      final result = await _authLocalDataSource.checkSignInStatus();

      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
