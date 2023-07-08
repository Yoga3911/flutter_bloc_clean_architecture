import '../../../core/cache/hive_local_storage.dart';
import '../../../core/cache/secure_local_storage.dart';
import '../../../configs/injector/injector_conf.dart';
import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/usecases/check_signin_status_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../presentation/bloc/auth/auth_bloc.dart';
import '../presentation/bloc/auth_login_form/auth_login_form_bloc.dart';
import '../presentation/bloc/auth_register_form/auth_register_form_bloc.dart';

class AuthDepedency {
  AuthDepedency._();

  static void init() {
    getIt.registerFactory(
      () => AuthBloc(
        getIt<AuthLoginUseCase>(),
        getIt<AuthLogoutUseCase>(),
        getIt<AuthRegisterUseCase>(),
        getIt<AuthCheckSignInStatusUseCase>(),
      ),
    );

    getIt.registerFactory(
      () => AuthLoginFormBloc(),
    );

    getIt.registerFactory(
      () => AuthRegisterFormBloc(),
    );

    getIt.registerLazySingleton(
      () => AuthLoginUseCase(
        getIt<AuthRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => AuthLogoutUseCase(
        getIt<AuthRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => AuthRegisterUseCase(
        getIt<AuthRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => AuthCheckSignInStatusUseCase(
        getIt<AuthRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => AuthRepositoryImpl(
        getIt<AuthRemoteDataSourceImpl>(),
        getIt<AuthLocalDataSourceImpl>(),
        getIt<SecureLocalStorage>(),
        getIt<HiveLocalStorage>(),
      ),
    );

    getIt.registerLazySingleton(
      () => AuthRemoteDataSourceImpl(),
    );

    getIt.registerLazySingleton(
      () => AuthLocalDataSourceImpl(
        getIt<SecureLocalStorage>(),
        getIt<HiveLocalStorage>(),
      ),
    );
  }
}
