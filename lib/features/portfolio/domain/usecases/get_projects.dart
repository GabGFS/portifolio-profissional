import '../../../../core/usecases/usecase.dart';
import '../entities/project.dart';
import '../repositories/portfolio_repository.dart';

/// Recupera a lista de projetos do portfolio.
class GetProjects implements UseCase<List<Project>, NoParams> {
  final PortfolioRepository repository;

  const GetProjects(this.repository);

  @override
  Future<List<Project>> call(NoParams params) => repository.getProjects();
}
