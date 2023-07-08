part of 'auth_register_form_bloc.dart';

sealed class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object?> get props => [];
}

class RegisterFormEmailChangedEvent extends RegisterFormEvent {
  final String email;

  const RegisterFormEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class RegisterFormUsernameChangedEvent extends RegisterFormEvent {
  final String username;

  const RegisterFormUsernameChangedEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class RegisterFormPasswordChangedEvent extends RegisterFormEvent {
  final String password;

  const RegisterFormPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterFormConfirmPasswordChangedEvent extends RegisterFormEvent {
  final String confirmPassword;

  const RegisterFormConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}
