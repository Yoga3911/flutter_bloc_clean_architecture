part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {}

class GetProductListLoadingState extends ProductState {}

class GetProductListSuccessState extends ProductState {
  final List<ProductEntity> data;
  const GetProductListSuccessState(this.data);

  @override
  List<Object> get props => [data];
}

class GetProductListFailureState extends ProductState {
  final String message;
  const GetProductListFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class CreateProductLoadingState extends ProductState {}

class CreateProductSuccessState extends ProductState {}

class CreateProductFailureState extends ProductState {
  final String message;
  const CreateProductFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProductLoadingState extends ProductState {}

class UpdateProductSuccessState extends ProductState {}

class UpdateProductFailureState extends ProductState {
  final String message;
  const UpdateProductFailureState(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteProductLoadingState extends ProductState {}

class DeleteProductSuccessState extends ProductState {}

class DeleteProductFailureState extends ProductState {
  final String message;
  const DeleteProductFailureState(this.message);

  @override
  List<Object> get props => [message];
}
