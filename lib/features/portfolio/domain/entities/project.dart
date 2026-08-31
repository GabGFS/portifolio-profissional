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

  /// Caminho do video de demonstracao no bundle de assets, quando existir.
  final String? videoAsset;

  /// Marca projetos cujo codigo nao e publico. O aviso aparece no card mesmo
  /// quando ha outros links (loja, deploy), sem substitui-los.
  final bool privateRepo;

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
    this.videoAsset,
    this.privateRepo = false,
  });

  /// Indica se o projeto possui algum link publico exibivel.
  bool get hasLinks => links.isNotEmpty;

  /// Indica se o projeto tem video de demonstracao.
  bool get hasVideo => videoAsset != null;

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
      videoAsset: videoAsset,
      privateRepo: privateRepo,
    );
  }
}
