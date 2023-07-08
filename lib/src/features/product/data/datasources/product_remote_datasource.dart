import 'dart:developer';

import 'package:flutter_bloc_ca/src/features/product/data/models/models.dart';

import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';

sealed class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProduct();
  Future<void> createProduct(CreateProductModel model);
  Future<void> updateProduct(UpdateProductModel model);
  Future<void> deleteProduct(DeleteProductModel model);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiHelper _helper;

  const ProductRemoteDataSourceImpl(this._helper);

  @override
  Future<List<ProductModel>> fetchProduct() => fetchProductFromUrl("");

  Future<List<ProductModel>> fetchProductFromUrl(String url) async {
    try {
      // final response = await _helper.execute(method: Method.get, url: url);
      log(_helper.toString());
      final response = await ApiUrl.products.get();

      return ProductModel.fromJsonList(response.docs
          .map((e) => {
                "product_id": e.id,
                "name": e.data()["name"],
                "price": e.data()["price"],
              })
          .toList());
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> createProduct(CreateProductModel model) async {
    try {
      // await _helper.execute(
      //   method: Method.post,
      //   url: "ApiUrl.products",
      //   data: {},
      // );
      await ApiUrl.products.add(model.toMap());
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(DeleteProductModel model) async {
    try {
      await ApiUrl.products.doc(model.productId).delete();
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(UpdateProductModel model) async {
    try {
      await ApiUrl.products.doc(model.productId).update(model.toMap());
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }
}
