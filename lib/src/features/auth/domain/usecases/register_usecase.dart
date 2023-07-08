import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_ca/src/core/extensions/string_validator_extension.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class AuthRegisterUseCase implements UseCase<void, Params> {
  final AuthRepository _authRepository;
  const AuthRegisterUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    if (!params.email.isEmailValid) {
      return Left(InvalidEmailFailure());
    }

    if (!params.password.isPasswordValid ||
        !params.confirmPassword.isPasswordValid) {
      return Left(InvalidPasswordFailure());
    }

    if (params.password != params.confirmPassword) {
      return Left(PasswordNotMatchFailure());
    }

    return await _authRepository.register(params);
  }
}

class Params extends Equatable {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  const Params({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        confirmPassword,
      ];
}
