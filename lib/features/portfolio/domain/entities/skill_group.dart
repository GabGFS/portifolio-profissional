import 'localized_text.dart';

/// Categoria de habilidades — mapeada para um icone na apresentacao.
enum SkillCategory { mobile, backend, web, cloud, databases, practices }

/// Grupo de tecnologias/habilidades exibido na secao de stacks.
class SkillGroup {
  final SkillCategory category;
  final LocalizedText title;
  final List<String> items;

  const SkillGroup({
    required this.category,
    required this.title,
    required this.items,
  });
}
