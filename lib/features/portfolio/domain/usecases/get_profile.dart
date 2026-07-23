import '../../../../core/usecases/usecase.dart';
import '../entities/developer_profile.dart';
import '../repositories/portfolio_repository.dart';

/// Recupera o perfil da desenvolvedora.
class GetProfile implements UseCase<DeveloperProfile, NoParams> {
  final PortfolioRepository repository;

  const GetProfile(this.repository);

  @override
  Future<DeveloperProfile> call(NoParams params) => repository.getProfile();
}
