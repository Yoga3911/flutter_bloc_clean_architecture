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
import '../bloc/auth_login_form/auth_login_form_bloc.dart';
import '../widgets/auth_login_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<AuthLoginFormBloc>().state;
    context.read<AuthBloc>().add(
          AuthLoginEvent(
            authForm.email.trim(),
            authForm.password.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthLoginFormBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AuthLoginInput(),
                  20.hS,
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (_, state) {
                      if (state is AuthLoginFailureState) {
                        appSnackBar(context, Colors.red, state.message);
                      } else if (state is AuthLoginSuccessState) {
                        final user = state.data;
                        context.goNamed(
                          AppRoute.home.name,
                          pathParameters: {
                            "user_id": user.userId ?? "",
                            "email": user.email ?? "",
                            "username": user.username ?? "",
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoginLoadingState) {
                        return const AppLoadingWidget();
                      }

                      return AppButtonWidget(
                        label: "masuk".tr(),
                        callback:
                            context.watch<AuthLoginFormBloc>().state.isValid
                                ? () {
                                    _login(context);
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
                      context.pushReplacementNamed(AppRoute.register.name);
                    },
                    child: Text("daftar".tr()),
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
