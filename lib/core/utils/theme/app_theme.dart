import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = _build(
    scaffold: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimary,
    ),
    fill: const Color(0xFFF5F5F5),
  );

  static ThemeData darkTheme = _build(
    scaffold: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimary,
    ),
    fill: const Color(0xFF2A2A2A),
  );

  static ThemeData _build({
    required Color scaffold,
    required ColorScheme colorScheme,
    required Color fill,
  }) {
    return ThemeData(
      fontFamily: 'Quicksand',
      scaffoldBackgroundColor: scaffold,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
