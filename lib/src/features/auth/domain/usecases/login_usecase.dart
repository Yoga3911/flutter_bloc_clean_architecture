import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_ca/src/core/extensions/string_validator_extension.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthLoginUseCase implements UseCase<UserEntity, Params> {
  final AuthRepository _authRepository;
  const AuthLoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Params params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    final result = await _authRepository.login(params);

    return result;
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  const Params({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
