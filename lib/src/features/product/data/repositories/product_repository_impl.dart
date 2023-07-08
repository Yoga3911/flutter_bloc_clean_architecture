import 'package:fpdart/fpdart.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_checker.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/usecase_params.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/models.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final LocalStorage _localStorage;
  const ProductRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
    this._localStorage,
  );

  @override
  Future<Either<Failure, void>> create(CreateProductParams params) async {
    try {
      final model = CreateProductModel(
        name: params.name,
        price: params.price,
      );

      final result = await _remoteDataSource.createProduct(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAll() {
    return _networkInfo.check<List<ProductEntity>>(
      connected: () async {
        try {
          final listProduct = await _remoteDataSource.fetchProduct();

          await _localStorage.save(
            key: "products",
            value: ProductModel.toMapList(listProduct),
            boxName: "cache",
          );

          return Right(listProduct);
        } on ServerException {
          return Left(ServerFailure());
        }
      },
      notConnected: () async {
        try {
          final listProduct = await _localDataSource.getAllProduct();

          return Right(listProduct);
        } on CacheException {
          return Left(CacheFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> delete(DeleteProductParams params) async {
    try {
      final model = DeleteProductModel(
        productId: params.productId,
      );

      final result = await _remoteDataSource.deleteProduct(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(UpdateProductParams params) async {
    try {
      final model = UpdateProductModel(
        productId: params.productId,
        name: params.name,
        price: params.price,
      );

      final result = await _remoteDataSource.updateProduct(model);

      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
