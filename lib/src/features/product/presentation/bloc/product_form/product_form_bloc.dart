import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ca/src/core/utils/logger.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc() : super(const ProductFormInitialState()) {
    on<LoadDataEvent>(_loadData);
    on<ProductNameChangedEvent>(_nameChanged);
    on<ProductPriceChangedEvent>(_priceChanged);
  }

  Future _loadData(LoadDataEvent event, Emitter emit) async {
    emit(ProductFormDataState(
      inputName: event.name,
      inputPrice: event.price,
      inputIsValid: inputValidator(event.name, event.price),
    ));
  }

  Future _nameChanged(ProductNameChangedEvent event, Emitter emit) async {
    emit(ProductFormDataState(
      inputName: event.name,
      inputPrice: state.price,
      inputIsValid: inputValidator(event.name, state.price),
    ));
  }

  Future _priceChanged(ProductPriceChangedEvent event, Emitter emit) async {
    emit(ProductFormDataState(
      inputName: state.name,
      inputPrice: event.price,
      inputIsValid: inputValidator(state.name, event.price),
    ));
  }

  bool inputValidator(String name, String price) {
    if (name.length > 3 && price.length > 3) {
      return true;
    }

    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE ProductFormBloc =====");
    return super.close();
  }
}
