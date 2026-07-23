import '../entities/developer_profile.dart';
import '../entities/project.dart';
import '../entities/service_offering.dart';
import '../entities/skill_group.dart';
import '../entities/social_link.dart';

/// Contrato do repositorio de portfolio (definido no dominio).
///
/// A camada de dados fornece a implementacao concreta. A apresentacao depende
/// apenas desta abstracao (Dependency Inversion Principle).
abstract class PortfolioRepository {
  Future<DeveloperProfile> getProfile();
  Future<List<Project>> getProjects();
  Future<List<SkillGroup>> getSkillGroups();
  Future<List<ServiceOffering>> getServices();
  Future<List<SocialLink>> getSocialLinks();
}
