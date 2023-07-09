part of 'product_form_bloc.dart';

sealed class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object> get props => [];
}

class ProductLoadDataEvent extends ProductFormEvent {
  final String name;
  final String price;
  const ProductLoadDataEvent(this.name, this.price);

  @override
  List<Object> get props => [name, price];
}

class ProductNameChangedEvent extends ProductFormEvent {
  final String name;
  const ProductNameChangedEvent(this.name);

  @override
  List<Object> get props => [name];
}

class ProductPriceChangedEvent extends ProductFormEvent {
  final String price;
  const ProductPriceChangedEvent(this.price);

  @override
  List<Object> get props => [price];
}
