import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _inputBorder([Color borderColor = AppPallete.borderColor]) =>
      OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(10));

  static final darkThemeMode = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
      ),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(AppPallete.gradient2),
      ));
}
