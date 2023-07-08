part of 'product_form_bloc.dart';

sealed class ProductFormState extends Equatable {
  final String name;
  final String price;
  final bool isValid;

  const ProductFormState({
    required this.name,
    required this.price,
    required this.isValid,
  });

  @override
  List<Object> get props => [
        name,
        price,
        isValid,
      ];
}

class ProductFormInitialState extends ProductFormState {
  const ProductFormInitialState()
      : super(
          name: "",
          price: "0",
          isValid: false,
        );
}

class ProductFormDataState extends ProductFormState {
  final String inputName;
  final String inputPrice;
  final bool inputIsValid;
  const ProductFormDataState({
    required this.inputName,
    required this.inputPrice,
    required this.inputIsValid,
  }) : super(
          name: inputName,
          price: inputPrice,
          isValid: inputIsValid,
        );

  @override
  List<Object> get props => [
        inputName,
        inputPrice,
        inputIsValid,
      ];
}
