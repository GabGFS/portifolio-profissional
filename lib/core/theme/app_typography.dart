import 'package:flutter/widgets.dart';
import 'app_colors.dart';

/// Tipografia portada do design system de referencia:
/// Asap (titulos/corpo) + Inconsolata (kickers/labels monospace).
class AppText {
  const AppText._();

  static const String fontFamily = 'Asap';
  static const String mono = 'Inconsolata';

  // Display / nome no hero
  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 56,
    height: 1.1,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 34,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  // Titulo de secao
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 26,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  // Titulo de card
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 17,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 15.5,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  static const TextStyle small = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 13.5,
    height: 1.5,
    color: AppColors.textMuted,
  );

  // Labels de botao / nav (Asap bold, como na referencia)
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle chip = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 13.5,
    color: AppColors.textSecondary,
  );

  // Kicker monospace (Inconsolata) — a cor e definida por secao.
  static const TextStyle kicker = TextStyle(
    fontFamily: mono,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.2,
    letterSpacing: 0.2,
    color: AppColors.primary,
  );

  // Linha monospace do hero ("Hello World! ...")
  static const TextStyle monoLine = TextStyle(
    fontFamily: mono,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.3,
    color: AppColors.textMuted,
  );
}
