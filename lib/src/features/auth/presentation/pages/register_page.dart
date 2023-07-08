import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_ca/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../routes/app_route_path.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth_register_form/auth_register_form_bloc.dart';
import '../widgets/auth_register_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _register(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<AuthRegisterFormBloc>().state;
    context.read<AuthBloc>().add(
          AuthRegisterEvent(
            authForm.username.trim(),
            authForm.email.trim(),
            authForm.password.trim(),
            authForm.confirmPassword.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthRegisterFormBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthRegisterInput(),
                  20.hS,
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (_, state) {
                      if (state is AuthRegisterSuccessState) {
                        appSnackBar(context, Colors.green, state.message);
                        context.goNamed(AppRoute.login.name);
                      } else if (state is AuthRegisterFailureState) {
                        appSnackBar(context, Colors.red, state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthRegisterLoadingState) {
                        return const AppLoadingWidget();
                      }

                      return AppButtonWidget(
                        label: "daftar".tr(),
                        callback:
                            context.watch<AuthRegisterFormBloc>().state.isValid
                                ? () {
                                    _register(context);
                                  }
                                : null,
                        paddingHorizontal: 30.w,
                        paddingVertical: 10.h,
                      );
                    },
                  ),
                  10.hS,
                  TextButton(
                    onPressed: () {
                      context.pushReplacementNamed(AppRoute.login.name);
                    },
                    child: Text("masuk".tr()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
