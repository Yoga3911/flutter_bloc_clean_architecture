import '../errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server Failure";
    case CacheFailure:
      return "Cache Failure";
    case EmptyFailure:
      return "Empty Failure";
    case CredentialFailure:
      return "Wrong Email or Password";
    case DuplicateEmailFailure:
      return "Email already taken";
    case PasswordNotMatchFailure:
      return "Password not match";
    case InvalidEmailFailure:
      return "Invalid email format";
    case InvalidPasswordFailure:
      return "Invalid password format";
    default:
      return "Unexpected error";
  }
}
