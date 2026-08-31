import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../controllers/portfolio_controller.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/nav_bar.dart';
import '../sections/projects_section.dart';
import '../sections/services_section.dart';
import '../sections/skills_section.dart';
import '../widgets/hover.dart';
import '../widgets/language_toggle.dart';

/// Pagina unica do portfolio: sobrepoe a NavBar ao conteudo rolavel e
/// oferece navegacao por ancoras (com drawer no mobile).
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      endDrawer: const _NavDrawer(),
      body: Obx(() {
        if (c.isLoading.value || c.profile.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return Stack(
          children: <Widget>[
            Positioned.fill(child: _ScrollContent(controller: c)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Builder(
                builder: (BuildContext ctx) => NavBar(
                  onMenuTap: () => Scaffold.of(ctx).openEndDrawer(),
                ),
              ),
            ),
            Positioned(
                right: 22, bottom: 22, child: _BackToTopFab(controller: c)),
          ],
        );
      }),
    );
  }
}

class _ScrollContent extends StatelessWidget {
  final PortfolioController controller;
  const _ScrollContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Publica a rolagem da pagina para os widgets descendentes (RevealOnScroll
    // consome via PrimaryScrollController, sem depender deste controller).
    return PrimaryScrollController(
      controller: controller.scrollController,
      child: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
          children: <Widget>[
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.home],
              child: const HeroSection(),
            ),
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.about],
              child: const AboutSection(),
            ),
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.projects],
              child: const ProjectsSection(),
            ),
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.services],
              child: const ServicesSection(),
            ),
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.skills],
              child: const SkillsSection(),
            ),
            KeyedSubtree(
              key: controller.sectionKeys[PortfolioSection.contact],
              child: const ContactSection(),
            ),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _BackToTopFab extends StatelessWidget {
  final PortfolioController controller;
  const _BackToTopFab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool show = controller.showBackToTop.value;
      return AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: AppDurations.fast,
        child: IgnorePointer(
          ignoring: !show,
          child: Hover(
            builder: (bool hovering) {
              return GestureDetector(
                onTap: controller.scrollToTop,
                child: AnimatedContainer(
                  duration: AppDurations.fast,
                  width: 50,
                  height: 50,
                  transform: Matrix4.translationValues(0, hovering ? -3 : 0, 0),
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: 0.45),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(FontAwesomeIcons.arrowUp,
                        size: 16, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class _NavDrawer extends StatelessWidget {
  const _NavDrawer();

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppConstants.monogram,
                      style: AppText.label.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(AppConstants.displayName,
                      style:
                          AppText.label.copyWith(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const FaIcon(FontAwesomeIcons.xmark,
                        size: 18, color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              for (final (String key, PortfolioSection section) in kNavItems)
                _DrawerItem(
                  labelKey: key,
                  onTap: () {
                    Navigator.of(context).pop();
                    Future<void>.delayed(
                      const Duration(milliseconds: 260),
                      () => c.scrollToSection(section),
                    );
                  },
                ),
              const Spacer(),
              const Align(
                alignment: Alignment.centerLeft,
                child: LanguageToggle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String labelKey;
  final VoidCallback onTap;
  const _DrawerItem({required this.labelKey, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Text(
          labelKey.tr,
          style:
              AppText.h3.copyWith(fontSize: 18, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
