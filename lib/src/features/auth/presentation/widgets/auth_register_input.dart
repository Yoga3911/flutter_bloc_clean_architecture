import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_register_form/auth_register_form_bloc.dart';
import 'auth_text_field.dart';

class AuthRegisterInput extends StatelessWidget {
  const AuthRegisterInput({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthRegisterFormBloc>();
    return Column(
      children: [
        AuthTextField<AuthRegisterFormBloc>(
          label: "input_nama_pengguna".tr(),
          onChanged: (val) {
            authBloc.add(RegisterFormUsernameChangedEvent(val));
          },
        ),
        AuthTextField<AuthRegisterFormBloc>(
          label: "input_email".tr(),
          onChanged: (val) {
            authBloc.add(RegisterFormEmailChangedEvent(val));
          },
        ),
        AuthTextField<AuthRegisterFormBloc>(
          label: "input_kata_sandi".tr(),
          onChanged: (val) {
            authBloc.add(RegisterFormPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
        AuthTextField<AuthRegisterFormBloc>(
          label: "input_konfirmasi_kata_sandi".tr(),
          onChanged: (val) {
            authBloc.add(RegisterFormConfirmPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
      ],
    );
  }
}
