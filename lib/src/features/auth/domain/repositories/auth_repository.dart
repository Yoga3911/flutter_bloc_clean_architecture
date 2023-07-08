import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../usecases/usecase_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> register(RegisterParams params);
  Future<Either<Failure, UserEntity>> checkSignInStatus();
}
