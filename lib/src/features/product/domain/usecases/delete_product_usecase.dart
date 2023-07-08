import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase implements UseCase<void, Params> {
  final ProductRepository _repository;
  const DeleteProductUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.productId == "") {
      return Left(EmptyFailure());
    }

    return await _repository.delete(params);
  }
}

class Params extends Equatable {
  final String productId;

  const Params({
    required this.productId,
  });

  @override
  List<Object?> get props => [productId];
}
