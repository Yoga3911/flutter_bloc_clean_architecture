import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ca/src/core/extensions/string_validator_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_color.dart';
import '../bloc/auth_register_form/auth_register_form_bloc.dart';

class AuthTextField<T> extends StatefulWidget {
  final String label;
  final bool? isSecure;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final String? initialValue;
  const AuthTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.isSecure,
    this.inputFormat,
    this.initialValue,
  });

  @override
  State<AuthTextField<T>> createState() => _AuthTextFieldState<T>();
}

class _AuthTextFieldState<T> extends State<AuthTextField<T>> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<T>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: TextFormField(
        initialValue: widget.initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isSecure ?? false ? _isVisible : false,
        cursorColor: AppColor.purple,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormat,
        validator: (val) {
          if (formBloc is AuthRegisterFormBloc) {
            if (widget.label == "input_nama_pengguna".tr() && val == "") {
              return "Username tidak boleh kosong";
            } else if (widget.label == "input_email".tr() &&
                !formBloc.state.email.isEmailValid) {
              return "Email tidak valid";
            } else if ((widget.label == "input_kata_sandi".tr() ||
                    widget.label == "input_konfirmasi_kata_sandi".tr()) &&
                val!.length < 6) {
              return "Password minimal 6 karakter";
            } else if (widget.label == "input_kata_sandi".tr() &&
                !formBloc.state.password.isPasswordValid) {
              return "Password harus kombinasi huruf dan angka";
            } else if (widget.label == "input_konfirmasi_kata_sandi".tr() &&
                !formBloc.state.confirmPassword.isPasswordValid) {
              return "Password harus kombinasi huruf dan angka";
            } else if (widget.label == "input_konfirmasi_kata_sandi".tr() &&
                formBloc.state.password != formBloc.state.confirmPassword) {
              return "Password tidak sama";
            }
          }

          return null;
        },
        decoration: InputDecoration(
          label: Text(widget.label),
          suffixIcon: widget.isSecure ?? false
              ? IconButton(
                  onPressed: () {
                    _toggleVisibility();
                  },
                  icon: Icon(
                    _isVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                  splashRadius: 20.r,
                )
              : null,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.purple,
            ),
          ),
        ),
      ),
    );
  }
}
