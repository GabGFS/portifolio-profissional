import 'localized_text.dart';

/// Natureza tecnica do projeto — usada para icone/cor na apresentacao.
enum ProjectCategory { mobile, backend, fullstack, web, game }

/// Tipo de link associado a um projeto.
enum ProjectLinkType { code, live, appStore }

/// Link externo de um projeto (repositorio, deploy ou loja).
class ProjectLink {
  final ProjectLinkType type;
  final String url;

  const ProjectLink({required this.type, required this.url});

  const ProjectLink.code(this.url) : type = ProjectLinkType.code;
  const ProjectLink.live(this.url) : type = ProjectLinkType.live;
  const ProjectLink.appStore(this.url) : type = ProjectLinkType.appStore;
}

/// Entidade de projeto do portfolio.
class Project {
  final String id;
  final String name;
  final LocalizedText type;
  final LocalizedText description;
  final List<String> techs;
  final List<ProjectLink> links;
  final ProjectCategory category;
  final String year;
  final bool featured;

  const Project({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.techs,
    required this.links,
    required this.category,
    required this.year,
    this.featured = false,
  });

  /// Indica se o projeto possui algum link publico exibivel.
  bool get hasLinks => links.isNotEmpty;

  Project copyWith({List<ProjectLink>? links}) {
    return Project(
      id: id,
      name: name,
      type: type,
      description: description,
      techs: techs,
      links: links ?? this.links,
      category: category,
      year: year,
      featured: featured,
    );
  }
}
