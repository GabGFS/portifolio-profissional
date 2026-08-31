import '../../../../core/usecases/usecase.dart';
import '../entities/social_link.dart';
import '../repositories/portfolio_repository.dart';

/// Recupera os links de contato/redes sociais.
class GetSocialLinks implements UseCase<List<SocialLink>, NoParams> {
  final PortfolioRepository repository;

  const GetSocialLinks(this.repository);

  @override
  Future<List<SocialLink>> call(NoParams params) => repository.getSocialLinks();
}
