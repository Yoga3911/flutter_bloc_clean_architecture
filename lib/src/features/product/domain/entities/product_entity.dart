import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String? name;
  final int? price;
  const ProductEntity({
    this.productId,
    this.name,
    this.price,
  });

  @override
  List<Object?> get props => [productId, name, price];
}
