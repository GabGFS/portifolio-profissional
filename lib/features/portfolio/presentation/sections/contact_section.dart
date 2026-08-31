import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/social_link.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/hover.dart';
import '../widgets/portfolio_visuals.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';

/// Secao de contato: lista de canais (LinkedIn, GitHub, E-mail, WhatsApp).
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const List<SocialType> _order = <SocialType>[
    SocialType.linkedin,
    SocialType.github,
    SocialType.email,
    SocialType.whatsapp,
  ];

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final List<SocialLink> links = <SocialLink>[
      for (final SocialType t in _order)
        ...c.socialLinks.where((SocialLink l) => l.type == t),
    ];

    return SectionWrapper(
      background: AppColors.backgroundAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const RevealOnScroll(
            child: SectionHeader(
              kickerKey: 'contact.kicker',
              titleKey: 'contact.title',
              subtitleKey: 'contact.subtitle',
              accent: AppColors.purple,
            ),
          ),
          const SizedBox(height: 40),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              children: <Widget>[
                for (final SocialLink link in links)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: RevealOnScroll(
                      offsetY: 18,
                      child: _ContactRow(
                        link: link,
                        onTap: () => c.openSocial(link),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final SocialLink link;
  final VoidCallback onTap;
  const _ContactRow({required this.link, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color accent = PortfolioVisuals.socialColor(link.type);
    return Hover(
      builder: (bool hovering) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: hovering ? AppColors.surfaceHover : AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: hovering
                      ? accent.withValues(alpha: 0.6)
                      : AppColors.border),
            ),
            child: Row(
              children: <Widget>[
                FaIcon(PortfolioVisuals.socialIcon(link.type),
                    size: 20, color: accent),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(PortfolioVisuals.socialLabel(link.type),
                      style:
                          AppText.label.copyWith(color: AppColors.textPrimary)),
                ),
                FaIcon(
                  FontAwesomeIcons.arrowUpRightFromSquare,
                  size: 14,
                  color: hovering ? accent : AppColors.textMuted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
