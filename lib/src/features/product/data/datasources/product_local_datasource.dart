import 'package:flutter_bloc_ca/src/core/utils/logger.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/get_product_model.dart';

sealed class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProduct();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final LocalStorage _localStorage;
  const ProductLocalDataSourceImpl(this._localStorage);

  @override
  Future<List<ProductModel>> getAllProduct() => _getProductFromCache();

  Future<List<ProductModel>> _getProductFromCache() async {
    try {
      final response = await _localStorage.load(
        key: "products",
        boxName: "cache",
      );

      return ProductModel.fromMapList(response);
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}
