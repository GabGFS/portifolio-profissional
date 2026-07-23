/// Value Object para textos com versoes em portugues e ingles.
///
/// Mantem o conteudo bilingue no dominio, resolvido pelo idioma atual na
/// apresentacao. Imutavel e sem dependencia de framework.
class LocalizedText {
  final String pt;
  final String en;

  const LocalizedText({required this.pt, required this.en});

  /// Atalho para quando o texto e identico nos dois idiomas.
  const LocalizedText.all(String value)
      : pt = value,
        en = value;

  /// Resolve o texto para o `languageCode` informado ('pt' ou 'en').
  String resolve(String languageCode) => languageCode == 'en' ? en : pt;

  @override
  bool operator ==(Object other) =>
      other is LocalizedText && other.pt == pt && other.en == en;

  @override
  int get hashCode => Object.hash(pt, en);
}
