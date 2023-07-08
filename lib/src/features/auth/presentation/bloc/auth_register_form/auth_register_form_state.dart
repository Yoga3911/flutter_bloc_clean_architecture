part of 'auth_register_form_bloc.dart';

sealed class RegisterFormState extends Equatable {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final bool isValid;
  const RegisterFormState({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.isValid,
  });
  @override
  List<Object?> get props => [
        email,
        username,
        password,
        confirmPassword,
        isValid,
      ];
}

class RegisterFormInitialState extends RegisterFormState {
  const RegisterFormInitialState()
      : super(
          email: "",
          username: "",
          password: "",
          confirmPassword: "",
          isValid: false,
        );
}

class RegisterFormDataState extends RegisterFormState {
  final String inputEmail;
  final String inputUsername;
  final String inputPassword;
  final String inputConfirmPassword;
  final bool inputIsValid;
  const RegisterFormDataState({
    required this.inputEmail,
    required this.inputUsername,
    required this.inputPassword,
    required this.inputConfirmPassword,
    required this.inputIsValid,
  }) : super(
          email: inputEmail,
          username: inputUsername,
          password: inputPassword,
          confirmPassword: inputConfirmPassword,
          isValid: inputIsValid,
        );
  @override
  List<Object?> get props => [
        inputEmail,
        inputUsername,
        inputPassword,
        inputConfirmPassword,
        inputIsValid,
      ];
}
