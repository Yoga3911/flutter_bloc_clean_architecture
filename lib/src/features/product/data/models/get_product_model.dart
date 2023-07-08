import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String productId,
    required String name,
    required int price,
  }) : super(productId: productId, name: name, price: price);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["product_id"],
      name: json["name"],
      price: json["price"],
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      productId: map["product_id"],
      name: map["name"],
      price: map["price"],
    );
  }

  static List<ProductModel> fromMapList(List<dynamic> mapList) {
    return mapList.map((json) => ProductModel.fromMap(json)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "name": name,
      "price": price,
    };
  }

  static List<Map<String, dynamic>> toMapList(List<ProductModel> productList) {
    return productList.map((e) => e.toMap()).toList();
  }
}
