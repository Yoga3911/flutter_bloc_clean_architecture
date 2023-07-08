import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'injector.dart';

final getIt = GetIt.I;

void configureDepedencies() {
  AuthDepedency.init();
  ProductDependency.init();

  getIt.registerLazySingleton(
    () => ThemeBloc(),
  );

  getIt.registerLazySingleton(
    () => TranslateBloc(),
  );

  getIt.registerLazySingleton(
    () => AppRouteConf(),
  );

  getIt.registerLazySingleton(
    () => ApiHelper(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton(
    () => Dio()
      ..interceptors.add(
        getIt<ApiInterceptor>(),
      ),
  );

  getIt.registerLazySingleton(
    () => ApiInterceptor(),
  );

  getIt.registerLazySingleton(
    () => SecureLocalStorage(
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton(
    () => HiveLocalStorage(),
  );

  getIt.registerLazySingleton(
    () => NetworkInfo(
      getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerLazySingleton(
    () => InternetConnectionChecker(),
  );

  getIt.registerLazySingleton(
    () => const FlutterSecureStorage(),
  );
}
