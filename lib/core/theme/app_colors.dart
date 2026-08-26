import 'package:flutter/widgets.dart';

/// Paleta portada do design system de referencia (brunomatias.dev.br):
/// escala de cinzas escura + acentos multicoloridos, tudo em tons chapados.
class AppColors {
  const AppColors._();

  // Escala de cinza (base do tema)
  static const Color gray100 = Color(0xFFE2E4E9); // titulos
  static const Color gray200 = Color(0xFFC0C4CE); // texto
  static const Color gray300 = Color(0xFF878EA1); // texto suave
  static const Color gray400 = Color(0xFF292C34); // bordas / superficies
  static const Color gray500 = Color(0xFF16181D); // fundo
  static const Color gray600 = Color(0xFF0D0E11); // fundo profundo

  // Fundos
  static const Color background = gray500;
  static const Color backgroundDeep = gray600;
  static const Color surface = Color(0xFF1C1F27); // card
  static const Color surfaceHover = Color(0xFF23262E);
  static const Color surfaceElevated = Color(0xFF23262E);

  // Bordas
  static const Color border = gray400;
  static const Color borderStrong = Color(0xFF3A3F4A);

  // Texto
  static const Color textPrimary = gray100;
  static const Color textSecondary = gray200;
  static const Color textMuted = gray300;

  // Acentos (usados em kickers, categorias e detalhes)
  static const Color green = Color(0xFF82BC4F);
  static const Color blue = Color(0xFF3996DB);
  static const Color purple = Color(0xFFBB72E9);
  static const Color red = Color(0xFFE3646E);
  static const Color yellow = Color(0xFFEABD5F);

  // Compat: "primary" = verde (acento principal do tema)
  static const Color primary = green;
  static const Color primarySoft = Color(0x2282BC4F);

  // Semanticas
  static const Color success = green;
  static const Color warning = yellow;

  // Mantido para compatibilidade (o tema de referencia usa cores chapadas)
  static const List<Color> accentGradient = <Color>[green, Color(0xFF6FA83F)];
  static const LinearGradient primaryGradient = LinearGradient(
    colors: accentGradient,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Cor translucida (para nav pill e overlays).
  static Color glass(double opacity) => gray600.withValues(alpha: opacity);
}
