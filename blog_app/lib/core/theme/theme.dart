import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.circular(10));

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppPallete.backgroundColor,
          shadowColor: AppPallete.transparentColor),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: _border(),
        contentPadding: const EdgeInsets.all(27),
        focusedBorder: _border(AppPallete.gradient2),
        errorBorder: _border(AppPallete.errorColor),
        border: _border(),
        focusedErrorBorder: _border(AppPallete.errorColor),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppPallete.backgroundColor,
        side: BorderSide.none,
      ));
}
