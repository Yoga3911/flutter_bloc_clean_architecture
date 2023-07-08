import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/failure_converter.dart';
import '../../../../../core/utils/logger.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/create_product_usecase.dart';
import '../../../domain/usecases/delete_product_usecase.dart';
import '../../../domain/usecases/get_product_list_usecase.dart';
import '../../../domain/usecases/update_product_usecase.dart';
import '../../../domain/usecases/usecase_params.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CreateProductUseCase _createProduct;
  final DeleteProductUseCase _deleteProduct;
  final GetProductListUseCase _getProductList;
  final UpdateProductUseCase _updateProduct;
  ProductBloc(
    this._createProduct,
    this._deleteProduct,
    this._getProductList,
    this._updateProduct,
  ) : super(ProductInitialState()) {
    on<CreateProductEvent>(_create);
    on<DeleteProductEvent>(_delete);
    on<GetProductListEvent>(_getAll);
    on<UpdateProductEvent>(_update);
  }

  Future _create(CreateProductEvent event, Emitter emit) async {
    emit(CreateProductLoadingState());

    final result = await _createProduct.call(
      CreateProductParams(
        name: event.name,
        price: event.price,
      ),
    );

    result.fold(
      (l) => emit(CreateProductFailureState(mapFailureToMessage(l))),
      (r) => emit(CreateProductSuccessState()),
    );
  }

  Future _delete(DeleteProductEvent event, Emitter emit) async {
    emit(DeleteProductLoadingState());

    final result = await _deleteProduct.call(
      DeleteProductParams(
        productId: event.productId,
      ),
    );

    result.fold(
      (l) => emit(DeleteProductFailureState(mapFailureToMessage(l))),
      (r) => emit(DeleteProductSuccessState()),
    );
  }

  Future _getAll(GetProductListEvent event, Emitter emit) async {
    emit(GetProductListLoadingState());

    final result = await _getProductList.call(NoParams());

    result.fold(
      (l) => emit(GetProductListFailureState(mapFailureToMessage(l))),
      (r) => emit(GetProductListSuccessState(r)),
    );
  }

  Future _update(UpdateProductEvent event, Emitter emit) async {
    emit(UpdateProductLoadingState());

    final result = await _updateProduct.call(
      UpdateProductParams(
        productId: event.productId,
        name: event.name,
        price: event.price,
      ),
    );

    result.fold(
      (l) => emit(UpdateProductFailureState(mapFailureToMessage(l))),
      (r) => emit(UpdateProductSuccessState()),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE ProductBloc =====");
    return super.close();
  }
}
