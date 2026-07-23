import '../../../../core/usecases/usecase.dart';
import '../entities/skill_group.dart';
import '../repositories/portfolio_repository.dart';

/// Recupera os grupos de habilidades/tecnologias.
class GetSkillGroups implements UseCase<List<SkillGroup>, NoParams> {
  final PortfolioRepository repository;

  const GetSkillGroups(this.repository);

  @override
  Future<List<SkillGroup>> call(NoParams params) =>
      repository.getSkillGroups();
}
