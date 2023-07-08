import '../../../configs/injector/injector.dart';
import '../../../configs/injector/injector_conf.dart';
import '../data/datasources/product_local_datasource.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/usecases/create_product_usecase.dart';
import '../domain/usecases/delete_product_usecase.dart';
import '../domain/usecases/get_product_list_usecase.dart';
import '../domain/usecases/update_product_usecase.dart';
import '../presentation/bloc/product/product_bloc.dart';
import '../presentation/bloc/product_form/product_form_bloc.dart';

class ProductDependency {
  ProductDependency._();

  static void init() {
    getIt.registerFactory(
      () => ProductBloc(
        getIt<CreateProductUseCase>(),
        getIt<DeleteProductUseCase>(),
        getIt<GetProductListUseCase>(),
        getIt<UpdateProductUseCase>(),
      ),
    );

    getIt.registerFactory(
      () => ProductFormBloc(),
    );

    getIt.registerLazySingleton(
      () => GetProductListUseCase(
        getIt<ProductRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => CreateProductUseCase(
        getIt<ProductRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => DeleteProductUseCase(
        getIt<ProductRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => UpdateProductUseCase(
        getIt<ProductRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(
      () => ProductRepositoryImpl(
        getIt<ProductRemoteDataSourceImpl>(),
        getIt<ProductLocalDataSourceImpl>(),
        getIt<NetworkInfo>(),
        getIt<HiveLocalStorage>(),
      ),
    );

    getIt.registerLazySingleton(
      () => ProductRemoteDataSourceImpl(
        getIt<ApiHelper>(),
      ),
    );

    getIt.registerLazySingleton(
      () => ProductLocalDataSourceImpl(
        getIt<HiveLocalStorage>(),
      ),
    );
  }
}
