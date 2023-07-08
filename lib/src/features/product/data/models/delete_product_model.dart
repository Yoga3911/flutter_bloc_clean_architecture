import '../../domain/entities/product_entity.dart';

class DeleteProductModel extends ProductEntity {
  const DeleteProductModel({
    required String productId,
  }) : super(productId: productId);
}
