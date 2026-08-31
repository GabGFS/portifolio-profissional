import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/ports/app_launcher.dart';
import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/service_offering.dart';
import '../../domain/entities/skill_group.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_services.dart';
import '../../domain/usecases/get_skill_groups.dart';
import '../../domain/usecases/get_social_links.dart';

/// Secoes navegaveis da pagina (ancoras de rolagem).
enum PortfolioSection { home, about, projects, services, skills, contact }

/// ViewModel da tela de portfolio (camada de apresentacao).
///
/// Orquestra os casos de uso, expoe estado reativo para a UI e concentra as
/// acoes (rolagem, abertura de links, download de CV, troca de idioma).
/// Depende apenas de abstracoes (use cases e [AppLauncher]).
class PortfolioController extends GetxController {
  PortfolioController({
    required this.getProfile,
    required this.getProjects,
    required this.getSkillGroups,
    required this.getServices,
    required this.getSocialLinks,
    required this.launcher,
    required this.localeController,
  });

  final GetProfile getProfile;
  final GetProjects getProjects;
  final GetSkillGroups getSkillGroups;
  final GetServices getServices;
  final GetSocialLinks getSocialLinks;
  final AppLauncher launcher;
  final LocaleController localeController;

  // Rolagem e ancoras de secao.
  final ScrollController scrollController = ScrollController();
  final Map<PortfolioSection, GlobalKey> sectionKeys =
      <PortfolioSection, GlobalKey>{
    for (final PortfolioSection s in PortfolioSection.values) s: GlobalKey(),
  };

  // Estado reativo.
  final RxBool isLoading = true.obs;
  final Rxn<DeveloperProfile> profile = Rxn<DeveloperProfile>();
  final RxList<Project> projects = <Project>[].obs;
  final RxList<SkillGroup> skillGroups = <SkillGroup>[].obs;
  final RxList<ServiceOffering> services = <ServiceOffering>[].obs;
  final RxList<SocialLink> socialLinks = <SocialLink>[].obs;
  final RxBool showBackToTop = false.obs;

  /// Rolagem (em pixels) a partir da qual o botao "voltar ao topo" aparece.
  static const double _backToTopThreshold = 620;

  String get languageCode => localeController.languageCode;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    _load();
  }

  /// Carrega o conteudo via casos de uso. Cada `await` e tipado — sem casts
  /// posicionais — e o `finally` garante que o spinner nunca fique preso.
  Future<void> _load() async {
    isLoading.value = true;
    try {
      profile.value = await getProfile(const NoParams());
      projects.assignAll(await getProjects(const NoParams()));
      skillGroups.assignAll(await getSkillGroups(const NoParams()));
      services.assignAll(await getServices(const NoParams()));
      socialLinks.assignAll(await getSocialLinks(const NoParams()));
    } finally {
      isLoading.value = false;
    }
  }

  void _onScroll() {
    final bool show = scrollController.hasClients &&
        scrollController.offset > _backToTopThreshold;
    if (show != showBackToTop.value) showBackToTop.value = show;
  }

  /// Rola suavemente ate a [section].
  void scrollToSection(PortfolioSection section) {
    final BuildContext? ctx = sectionKeys[section]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: AppDurations.slow,
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: AppDurations.slow,
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> openProjectLink(ProjectLink link) => launcher.openUrl(link.url);

  Future<void> openSocial(SocialLink link) {
    switch (link.type) {
      case SocialType.email:
        return launcher.openEmail(link.target,
            subject: 'contact.emailSubject'.tr);
      case SocialType.whatsapp:
        return launcher.openWhatsApp(
          link.target,
          message: 'contact.whatsappMessage'.tr,
        );
      case SocialType.github:
      case SocialType.linkedin:
        return launcher.openUrl(link.target);
    }
  }

  Future<void> downloadCv() async {
    final DeveloperProfile? p = profile.value;
    if (p == null) return;
    await launcher.openUrl(p.cvUrlFor(languageCode));
  }

  void toggleLanguage() => localeController.toggle();

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
