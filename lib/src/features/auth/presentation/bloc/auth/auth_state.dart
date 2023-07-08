part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  final String message;

  const AuthRegisterSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthRegisterFailureState extends AuthState {
  final String message;

  const AuthRegisterFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final UserEntity data;

  const AuthLoginSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthLoginFailureState extends AuthState {
  final String message;

  const AuthLoginFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLogoutLoadingState extends AuthState {}

class AuthLogoutSuccessState extends AuthState {
  final String message;

  const AuthLogoutSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLogoutFailureState extends AuthState {
  final String message;

  const AuthLogoutFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthCheckSignInStatusLoadingState extends AuthState {}

class AuthCheckSignInStatusSuccessState extends AuthState {
  final UserEntity data;

  const AuthCheckSignInStatusSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthCheckSignInStatusFailureState extends AuthState {
  final String message;

  const AuthCheckSignInStatusFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
