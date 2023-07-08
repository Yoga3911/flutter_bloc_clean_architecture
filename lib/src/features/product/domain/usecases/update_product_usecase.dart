import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase implements UseCase<void, Params> {
  final ProductRepository _repository;
  const UpdateProductUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (params.productId == "") {
      return Left(EmptyFailure());
    }

    return await _repository.update(params);
  }
}

class Params extends Equatable {
  final String productId;
  final String name;
  final int price;

  const Params({
    required this.productId,
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [productId, name, price];
}
