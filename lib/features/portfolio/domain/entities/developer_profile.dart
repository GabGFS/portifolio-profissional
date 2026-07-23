import 'localized_text.dart';

/// Entidade que representa o perfil da desenvolvedora (dados do hero/sobre).
class DeveloperProfile {
  final String name;
  final String displayName;
  final LocalizedText role;
  final LocalizedText tagline;
  final List<LocalizedText> bio;
  final LocalizedText location;
  final String imagePath;
  final String cvPtUrl;
  final String cvEnUrl;
  final List<ProfileHighlight> highlights;

  const DeveloperProfile({
    required this.name,
    required this.displayName,
    required this.role,
    required this.tagline,
    required this.bio,
    required this.location,
    required this.imagePath,
    required this.cvPtUrl,
    required this.cvEnUrl,
    required this.highlights,
  });

  /// Retorna a URL do CV adequada ao idioma atual.
  String cvUrlFor(String languageCode) =>
      languageCode == 'en' ? cvEnUrl : cvPtUrl;
}

/// Numero de destaque exibido na secao "Sobre" (ex.: "~44%" + rotulo).
class ProfileHighlight {
  final String value;
  final LocalizedText label;

  const ProfileHighlight({required this.value, required this.label});
}
