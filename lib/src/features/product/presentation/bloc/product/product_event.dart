part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductListEvent extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final String name;
  final int price;
  const CreateProductEvent({
    required this.name,
    required this.price,
  });

  @override
  List<Object> get props => [name, price];
}

class UpdateProductEvent extends ProductEvent {
  final String productId;
  final String name;
  final int price;
  const UpdateProductEvent({
    required this.productId,
    required this.name,
    required this.price,
  });

  @override
  List<Object> get props => [
        productId,
        name,
        price,
      ];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  const DeleteProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
