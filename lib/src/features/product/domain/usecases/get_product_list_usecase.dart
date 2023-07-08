import 'package:flutter_bloc_ca/src/features/product/domain/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class GetProductListUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository _repository;
  const GetProductListUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await _repository.getAll();
  }
}
