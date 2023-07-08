import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_color.dart';

class ProductTextField extends StatelessWidget {
  final String hinText;
  final String label;
  final String? initialValue;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  const ProductTextField({
    super.key,
    required this.hinText,
    required this.label,
    this.initialValue,
    this.inputType,
    this.inputFormat,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 10.h,
      ),
      child: TextFormField(
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColor.purple,
        onChanged: onChanged,
        keyboardType: inputType,
        inputFormatters: inputFormat,
        validator: (val) {
          if (val!.length < 4) {
            return "validasi_produk".tr(args: [label]);
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: hinText,
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
