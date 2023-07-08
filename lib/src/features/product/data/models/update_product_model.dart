import '../../domain/entities/product_entity.dart';

class UpdateProductModel extends ProductEntity {
  const UpdateProductModel({
    required String productId,
    required String name,
    required int price,
  }) : super(productId: productId, name: name, price: price);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
    };
  }
}
