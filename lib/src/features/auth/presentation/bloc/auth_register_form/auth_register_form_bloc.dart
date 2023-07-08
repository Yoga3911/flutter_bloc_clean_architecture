import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ca/src/core/extensions/string_validator_extension.dart';

import '../../../../../core/utils/logger.dart';

part 'auth_register_form_event.dart';
part 'auth_register_form_state.dart';

class AuthRegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  AuthRegisterFormBloc() : super(const RegisterFormInitialState()) {
    on<RegisterFormEmailChangedEvent>(_emailChanged);
    on<RegisterFormUsernameChangedEvent>(_usernameChanged);
    on<RegisterFormPasswordChangedEvent>(_passwordChanged);
    on<RegisterFormConfirmPasswordChangedEvent>(_confirmPasswordChanged);
  }

  Future _emailChanged(
      RegisterFormEmailChangedEvent event, Emitter emit) async {
    emit(
      RegisterFormDataState(
        inputEmail: event.email,
        inputUsername: state.username,
        inputPassword: state.password,
        inputConfirmPassword: state.confirmPassword,
        inputIsValid: inputValidator(
          state.username,
          event.email,
          state.password,
          state.confirmPassword,
        ),
      ),
    );
  }

  Future _usernameChanged(
      RegisterFormUsernameChangedEvent event, Emitter emit) async {
    emit(
      RegisterFormDataState(
        inputEmail: state.email,
        inputUsername: event.username,
        inputPassword: state.password,
        inputConfirmPassword: state.confirmPassword,
        inputIsValid: inputValidator(
          event.username,
          state.email,
          state.password,
          state.confirmPassword,
        ),
      ),
    );
  }

  Future _passwordChanged(
      RegisterFormPasswordChangedEvent event, Emitter emit) async {
    emit(
      RegisterFormDataState(
        inputEmail: state.email,
        inputUsername: state.username,
        inputPassword: event.password,
        inputConfirmPassword: state.confirmPassword,
        inputIsValid: inputValidator(
          state.username,
          state.email,
          event.password,
          state.confirmPassword,
        ),
      ),
    );
  }

  Future _confirmPasswordChanged(
      RegisterFormConfirmPasswordChangedEvent event, Emitter emit) async {
    emit(RegisterFormDataState(
      inputUsername: state.username,
      inputEmail: state.email,
      inputPassword: state.password,
      inputConfirmPassword: event.confirmPassword,
      inputIsValid: inputValidator(
        state.username,
        state.email,
        state.password,
        event.confirmPassword,
      ),
    ));
  }

  bool inputValidator(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) {
    if (username.isEmpty) {
      return false;
    }

    if (!email.isEmailValid) {
      return false;
    }

    if (password.length < 6 && confirmPassword.length < 6) {
      return false;
    }

    if (!password.isPasswordValid || !confirmPassword.isPasswordValid) {
      return false;
    }

    if (password != confirmPassword) {
      return false;
    }

    return true;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthRegisterFormBloc =====");
    return super.close();
  }
}
