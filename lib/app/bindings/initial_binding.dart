import 'package:get/get.dart';

import '../../core/localization/locale_controller.dart';
import '../../core/ports/app_launcher.dart';
import '../../core/utils/url_app_launcher.dart';
import '../../features/portfolio/data/datasources/portfolio_local_data_source.dart';
import '../../features/portfolio/data/repositories/portfolio_repository_impl.dart';
import '../../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../features/portfolio/domain/usecases/get_profile.dart';
import '../../features/portfolio/domain/usecases/get_projects.dart';
import '../../features/portfolio/domain/usecases/get_services.dart';
import '../../features/portfolio/domain/usecases/get_skill_groups.dart';
import '../../features/portfolio/domain/usecases/get_social_links.dart';
import '../../features/portfolio/presentation/controllers/portfolio_controller.dart';

/// Composicao de dependencias da aplicacao (Composition Root).
///
/// Amarra implementacoes concretas as abstracoes num unico lugar. Trocar a
/// fonte de dados ou o launcher aqui nao exige alterar o dominio nem a UI.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Servicos globais.
    Get.put<LocaleController>(LocaleController(), permanent: true);
    Get.put<AppLauncher>(const UrlAppLauncher(), permanent: true);

    // Data + dominio.
    const PortfolioLocalDataSource dataSource = PortfolioLocalDataSourceImpl();
    const PortfolioRepository repository = PortfolioRepositoryImpl(dataSource);

    // ViewModel com casos de uso injetados.
    Get.put<PortfolioController>(
      PortfolioController(
        getProfile: const GetProfile(repository),
        getProjects: const GetProjects(repository),
        getSkillGroups: const GetSkillGroups(repository),
        getServices: const GetServices(repository),
        getSocialLinks: const GetSocialLinks(repository),
        launcher: Get.find<AppLauncher>(),
        localeController: Get.find<LocaleController>(),
      ),
    );
  }
}
