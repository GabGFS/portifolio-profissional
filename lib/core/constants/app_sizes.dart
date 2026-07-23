/// Escala de espacamentos, raios e duracoes.
///
/// Um sistema de espacamento consistente mantem o layout coeso e facil de
/// manter (evita numeros arbitrarios espalhados pelos widgets).
class AppSizes {
  const AppSizes._();

  // Espacamento (multiplos de 4)
  static const double x2 = 2;
  static const double x4 = 4;
  static const double x8 = 8;
  static const double x12 = 12;
  static const double x16 = 16;
  static const double x20 = 20;
  static const double x24 = 24;
  static const double x32 = 32;
  static const double x40 = 40;
  static const double x48 = 48;
  static const double x64 = 64;
  static const double x80 = 80;
  static const double x120 = 120;

  // Raios
  static const double radiusSm = 10;
  static const double radiusMd = 16;
  static const double radiusLg = 22;
  static const double radiusXl = 28;
  static const double radiusPill = 999;

  // Espacamento vertical entre secoes
  static const double sectionGapDesktop = 140;
  static const double sectionGapMobile = 88;
}

/// Duracoes padrao para animacoes e transicoes.
class AppDurations {
  const AppDurations._();
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 650);
  static const Duration reveal = Duration(milliseconds: 700);
}
