import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/service_offering.dart';
import '../../domain/entities/skill_group.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

/// Implementacao do [PortfolioRepository] apoiada numa fonte de dados local.
///
/// Depende da abstracao [PortfolioLocalDataSource] (nao de uma implementacao
/// concreta), o que permite trocar a origem dos dados sem afetar o dominio.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;

  const PortfolioRepositoryImpl(this.localDataSource);

  @override
  Future<DeveloperProfile> getProfile() async => localDataSource.getProfile();

  @override
  Future<List<Project>> getProjects() async {
    // Remove links sem URL (ainda nao publicados) para a UI nao renderizar
    // botoes "mortos".
    return localDataSource
        .getProjects()
        .map(_sanitizeLinks)
        .toList(growable: false);
  }

  @override
  Future<List<SkillGroup>> getSkillGroups() async =>
      localDataSource.getSkillGroups();

  @override
  Future<List<ServiceOffering>> getServices() async =>
      localDataSource.getServices();

  @override
  Future<List<SocialLink>> getSocialLinks() async =>
      localDataSource.getSocialLinks();

  Project _sanitizeLinks(Project project) {
    final List<ProjectLink> valid = project.links
        .where((ProjectLink link) => link.url.trim().isNotEmpty)
        .toList(growable: false);
    return valid.length == project.links.length
        ? project
        : project.copyWith(links: valid);
  }
}
