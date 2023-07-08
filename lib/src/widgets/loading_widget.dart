import 'package:flutter/material.dart';
import 'package:flutter_bloc_ca/src/core/themes/app_color.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.purple,
      ),
    );
  }
}
