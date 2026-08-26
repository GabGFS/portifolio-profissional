/// Constantes globais e imutaveis da aplicacao.
///
/// Centraliza dados de contato, links e caminhos de assets num unico ponto,
/// evitando strings magicas espalhadas pela UI (Single Source of Truth).
class AppConstants {
  const AppConstants._();

  // Identidade
  static const String fullName = 'Gabrielle Gobira Felsky Soratto';
  static const String displayName = 'Gabrielle Soratto';
  static const String monogram = 'GS';

  // Contato
  static const String email = 'devgabriellesoratto@gmail.com';
  static const String phoneDisplay = '+55 44 99741-8687';
  static const String whatsappNumber = '5544997418687';

  // Redes / perfis
  static const String githubUrl = 'https://github.com/GabGFS';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/gabrielle-felsky-soratto';

  // Assets
  // Troque assets/images/profile.png pela sua foto (mantendo o nome).
  // O layout ja enquadra a imagem (BoxFit.cover) — nao precisa recortar.
  static const String profileImage = 'assets/images/perfil.webp';
  static const String cvPtAsset = 'assets/cv/GabrielleSoratto_CV_PT.pdf';
  static const String cvEnAsset = 'assets/cv/GabrielleSoratto_CV_EN.pdf';

  // Layout
  static const double maxContentWidth = 1180;
}

/// Breakpoints de responsividade (em logical pixels).
class Breakpoints {
  const Breakpoints._();
  static const double mobile = 640;
  static const double tablet = 900;
  static const double desktop = 1200;
}
