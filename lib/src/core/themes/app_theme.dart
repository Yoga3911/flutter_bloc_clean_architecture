import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';
import 'app_font.dart';

class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColor.navy : AppColor.purple,
        centerTitle: true,
        elevation: 2.h,
        titleTextStyle: AppFont.bold.s16,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDark ? AppColor.blue : AppColor.lightPurple,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 2.h,
        extendedTextStyle: AppFont.normal.s14,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColor.blue : AppColor.lightPurple,
          elevation: 2.h,
          textStyle: AppFont.normal.s14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextTheme(
        bodySmall: AppFont.normal.s12,
        bodyMedium: AppFont.normal.s14,
        bodyLarge: AppFont.normal.s16,
      ),
    );
  }
}
