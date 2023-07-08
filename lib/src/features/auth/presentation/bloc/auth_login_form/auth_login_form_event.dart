part of 'auth_login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object?> get props => [];
}

class LoginFormEmailChangedEvent extends LoginFormEvent {
  final String email;

  const LoginFormEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginFormUsernameChangedEvent extends LoginFormEvent {
  final String username;

  const LoginFormUsernameChangedEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class LoginFormPasswordChangedEvent extends LoginFormEvent {
  final String password;

  const LoginFormPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginFormConfirmPasswordChangedEvent extends LoginFormEvent {
  final String confirmPassword;

  const LoginFormConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}
