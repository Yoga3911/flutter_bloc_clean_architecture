import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

class CreateProductUseCase implements UseCase<void, Params> {
  final ProductRepository _repository;
  const CreateProductUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await _repository.create(params);
  }
}

class Params extends Equatable {
  final String name;
  final int price;

  const Params({
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [name, price];
}
