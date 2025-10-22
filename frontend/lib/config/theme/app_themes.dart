import 'package:flutter/material.dart';

/// Paleta básica para que se parezca al Figma
class AppColors {
  static const purple = Color(0xFF7C4DFF);
  static const purpleDark = Color(0xFF5E35B1);
  static const bg = Color(0xFFF6F7FB);
  static const card = Colors.white;
  static const text = Color(0xFF111111);
  static const textMuted = Color(0xFF6B7280);
}

/// Devuelve el ThemeData de toda la app.
ThemeData buildAppTheme() {
  final base = ThemeData.light(useMaterial3: true);

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.purple,
      secondary: AppColors.purple,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.purple,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: AppColors.card,
      surfaceTintColor: Colors.transparent, // evita tinte gris en Material 3
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purple,
      foregroundColor: Colors.white,
    ),
    textTheme: base.textTheme.copyWith(
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      ),
      bodyMedium: const TextStyle(
        fontSize: 13,
        color: AppColors.textMuted,
        height: 1.35,
      ),
    ),
  );
}
