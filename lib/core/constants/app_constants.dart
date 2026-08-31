/// Constantes globais e imutaveis da aplicacao.
///
/// Centraliza dados de contato, links e caminhos de assets num unico ponto,
/// evitando strings magicas espalhadas pela UI (Single Source of Truth).
class AppConstants {
  const AppConstants._();

  // Identidade
  static const String fullName = 'Gabrielle Gobira Felsky Soratto';
  static const String displayName = 'Gabrielle Soratto';

  /// Assinatura usada no rodape (mais formal que o displayName).
  static const String footerName = 'Gabrielle G. F. Soratto';
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
  // A foto e enquadrada com BoxFit.cover — nao precisa recortar antes.
  // Os PDFs do CV sao servidos de `web/cv/` (ver DeveloperProfile.cvPtUrl).
  static const String profileImage = 'assets/images/perfil.webp';

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
