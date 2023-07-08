import '../../domain/entities/product_entity.dart';

class CreateProductModel extends ProductEntity {
  const CreateProductModel({
    required String name,
    required int price,
  }) : super(name: name, price: price);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
    };
  }

  CreateProductModel copyWith({String? name, int? price}) {
    return CreateProductModel(
      name: name ?? (this.name ?? ""),
      price: price ?? (this.price ?? 0),
    );
  }
}
