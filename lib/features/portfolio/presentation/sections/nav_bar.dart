import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/hover.dart';
import '../widgets/language_toggle.dart';

/// Itens de navegacao (rotulo -> secao). Reutilizado pelo drawer mobile.
const List<(String, PortfolioSection)> kNavItems = <(String, PortfolioSection)>[
  ('nav.home', PortfolioSection.home),
  ('nav.about', PortfolioSection.about),
  ('nav.skills', PortfolioSection.skills),
  ('nav.projects', PortfolioSection.projects),
  ('nav.services', PortfolioSection.services),
  ('nav.contact', PortfolioSection.contact),
];

/// Barra de navegacao flutuante (pill centralizada, translucida + blur).
class NavBar extends StatelessWidget {
  final VoidCallback onMenuTap;

  const NavBar({super.key, required this.onMenuTap});

  static const double height = 104;

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final bool isMobile = Responsive.isMobile(context);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 26,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.glass(0.55),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppColors.border),
                ),
                child: isMobile ? _mobile(c, context) : _desktop(c),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktop(PortfolioController c) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final (String key, PortfolioSection section) in kNavItems)
          _NavLink(labelKey: key, onTap: () => c.scrollToSection(section)),
        const SizedBox(width: 16),
        const LanguageToggle(),
      ],
    );
  }

  Widget _mobile(PortfolioController c, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _Monogram(onTap: () => c.scrollToSection(PortfolioSection.home)),
        const SizedBox(width: 14),
        const LanguageToggle(),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onMenuTap,
          child: const FaIcon(FontAwesomeIcons.bars,
              size: 18, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _Monogram extends StatelessWidget {
  final VoidCallback onTap;
  const _Monogram({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        AppConstants.monogram,
        style: AppText.label.copyWith(
          fontFamily: AppText.mono,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String labelKey;
  final VoidCallback onTap;
  const _NavLink({required this.labelKey, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hover(
      builder: (bool hovering) {
        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              labelKey.tr,
              style: AppText.label.copyWith(
                color:
                    hovering ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
