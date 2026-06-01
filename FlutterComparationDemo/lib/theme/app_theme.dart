import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFBF8EF);
  static const accent = Color(0xFF16C47F);
  static const white = Colors.white;
  static const black = Colors.black;
  static const textSecondary = Color(0xFF333333);
  static const delete = Color(0xFFC0392B);
}

class AppSpacing {
  static const xs = 5.0;
  static const sm = 10.0;
  static const md = 15.0;
  static const lg = 20.0;
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          surface: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.black,
          elevation: 0,
        ),
      );
}
