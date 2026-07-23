import '../../../../core/usecases/usecase.dart';
import '../entities/service_offering.dart';
import '../repositories/portfolio_repository.dart';

/// Recupera os servicos oferecidos.
class GetServices implements UseCase<List<ServiceOffering>, NoParams> {
  final PortfolioRepository repository;

  const GetServices(this.repository);

  @override
  Future<List<ServiceOffering>> call(NoParams params) =>
      repository.getServices();
}
