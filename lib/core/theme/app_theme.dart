import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Tema dark portado do design system de referencia.
class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Color(0xFF0D0E11),
        secondary: AppColors.purple,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: AppText.fontFamily,
        bodyColor: AppColors.textSecondary,
        displayColor: AppColors.textPrimary,
      ),
      dividerColor: AppColors.border,
      splashColor: AppColors.primarySoft,
      highlightColor: AppColors.primarySoft,
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        textStyle: AppText.small,
      ),
    );
  }
}
