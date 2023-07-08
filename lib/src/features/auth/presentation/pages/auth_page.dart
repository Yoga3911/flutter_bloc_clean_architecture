import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_ca/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_font.dart';
import '../../../../routes/app_route_path.dart';
import '../../../../widgets/button_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "judul".tr(),
                style: AppFont.bold.s16,
                textAlign: TextAlign.center,
              ),
              60.hS,
              AppButtonWidget(
                label: "masuk".tr(),
                callback: () {
                  context.pushNamed(AppRoute.login.name);
                },
                paddingHorizontal: 40.w,
                paddingVertical: 10.h,
              ),
              20.hS,
              AppButtonWidget(
                label: "daftar".tr(),
                callback: () {
                  context.pushNamed(AppRoute.register.name);
                },
                paddingHorizontal: 40.w,
                paddingVertical: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
