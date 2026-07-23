import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_launcher.dart';
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
enum PortfolioSection { home, about, skills, projects, services, contact }

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
  });

  final GetProfile getProfile;
  final GetProjects getProjects;
  final GetSkillGroups getSkillGroups;
  final GetServices getServices;
  final GetSocialLinks getSocialLinks;
  final AppLauncher launcher;

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

  LocaleController get _locale => Get.find<LocaleController>();
  String get languageCode => _locale.languageCode;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    final List<Object> results = await Future.wait(<Future<Object>>[
      getProfile(const NoParams()),
      getProjects(const NoParams()),
      getSkillGroups(const NoParams()),
      getServices(const NoParams()),
      getSocialLinks(const NoParams()),
    ]);
    profile.value = results[0] as DeveloperProfile;
    projects.assignAll(results[1] as List<Project>);
    skillGroups.assignAll(results[2] as List<SkillGroup>);
    services.assignAll(results[3] as List<ServiceOffering>);
    socialLinks.assignAll(results[4] as List<SocialLink>);
    isLoading.value = false;
  }

  void _onScroll() {
    final bool show =
        scrollController.hasClients && scrollController.offset > 620;
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
        return launcher.openEmail(link.url, subject: 'Contato via portfólio');
      case SocialType.whatsapp:
        return launcher.openWhatsApp(
          link.url,
          message: 'Olá, Gabrielle! Vi o seu portfólio.',
        );
      case SocialType.github:
      case SocialType.linkedin:
        return launcher.openUrl(link.url);
    }
  }

  Future<void> downloadCv() async {
    final DeveloperProfile? p = profile.value;
    if (p == null) return;
    await launcher.openUrl(p.cvUrlFor(languageCode));
  }

  void toggleLanguage() => _locale.toggle();

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
