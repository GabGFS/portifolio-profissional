import 'localized_text.dart';

/// Tipo de servico — mapeado para um icone na apresentacao.
enum ServiceType { mobile, backend, web }

/// Servico oferecido, exibido na secao "Meus servicos".
class ServiceOffering {
  final ServiceType type;
  final LocalizedText title;
  final LocalizedText description;
  final List<String> tags;

  const ServiceOffering({
    required this.type,
    required this.title,
    required this.description,
    required this.tags,
  });
}
