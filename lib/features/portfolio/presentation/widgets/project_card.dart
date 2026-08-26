import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/project.dart';
import 'hover.dart';
import 'portfolio_visuals.dart';
import 'tech_icons.dart';

/// Card de projeto no estilo da referencia: capa branded, titulo, descricao e
/// botoes de contorno (Code / View / App Store).
class ProjectCard extends StatelessWidget {
  final Project project;
  final String languageCode;
  final void Function(ProjectLink link) onLinkTap;

  const ProjectCard({
    super.key,
    required this.project,
    required this.languageCode,
    required this.onLinkTap,
  });

  TechIcon? get _mainTech {
    for (final String t in project.techs) {
      final TechIcon? i = kTechIcons[t];
      if (i != null) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color accent = PortfolioVisuals.categoryColor(project.category);
    return Hover(
      cursor: MouseCursor.defer,
      builder: (bool hovering) {
        return AnimatedContainer(
          duration: AppDurations.medium,
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, hovering ? -6 : 0, 0),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hovering
                  ? accent.withValues(alpha: 0.7)
                  : (project.featured ? accent.withValues(alpha: 0.4) : AppColors.border),
            ),
            boxShadow: hovering
                ? <BoxShadow>[
                    BoxShadow(
                      color: accent.withValues(alpha: 0.16),
                      blurRadius: 26,
                      offset: const Offset(0, 14),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _cover(accent),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      project.type.resolve(languageCode),
                      style: AppText.kicker.copyWith(color: accent, fontSize: 13.5),
                    ),
                    const SizedBox(height: 8),
                    Text(project.name, style: AppText.h3),
                    const SizedBox(height: 10),
                    Text(
                      project.description.resolve(languageCode),
                      style: AppText.body,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 18),
                    _links(accent),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _cover(Color accent) {
    final TechIcon? tech = _mainTech;
    return SizedBox(
      height: 132,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    accent.withValues(alpha: 0.28),
                    AppColors.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // marca d'agua
          Positioned(
            right: -8,
            bottom: -14,
            child: Opacity(
              opacity: 0.14,
              child: tech != null
                  ? SvgPicture.asset(tech.asset, width: 108, height: 108,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn))
                  : FaIcon(PortfolioVisuals.categoryIcon(project.category),
                      size: 100, color: Colors.white),
            ),
          ),
          // logo principal + badge destaque
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: tech != null
                        ? SvgPicture.asset(tech.asset, width: 22, height: 22,
                            colorFilter: ColorFilter.mode(tech.color, BlendMode.srcIn))
                        : FaIcon(PortfolioVisuals.categoryIcon(project.category),
                            size: 18, color: accent),
                  ),
                ),
                const Spacer(),
                if (project.featured) _featuredBadge(accent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuredBadge(Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaIcon(FontAwesomeIcons.solidStar, size: 10, color: accent),
          const SizedBox(width: 6),
          Text(
            'projects.featured'.tr,
            style: AppText.small.copyWith(color: accent, fontWeight: FontWeight.w600, fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _links(Color accent) {
    if (!project.hasLinks) {
      return Row(
        children: <Widget>[
          const FaIcon(FontAwesomeIcons.lock, size: 12, color: AppColors.textMuted),
          const SizedBox(width: 8),
          Text('action.private'.tr, style: AppText.small),
        ],
      );
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: project.links
          .map((ProjectLink link) => _LinkButton(
                icon: PortfolioVisuals.linkIcon(link.type),
                label: _linkLabelKey(link.type).tr,
                accent: accent,
                onTap: () => onLinkTap(link),
              ))
          .toList(),
    );
  }

  String _linkLabelKey(ProjectLinkType type) {
    switch (type) {
      case ProjectLinkType.code:
        return 'action.code';
      case ProjectLinkType.live:
        return 'action.live';
      case ProjectLinkType.appStore:
        return 'action.appstore';
    }
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color accent;
  final VoidCallback onTap;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      builder: (bool hovering) {
        final Color fg = hovering ? accent : AppColors.textSecondary;
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: hovering ? AppColors.surfaceHover : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: hovering ? accent : AppColors.borderStrong),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(label, style: AppText.label.copyWith(color: fg, fontSize: 14)),
                const SizedBox(width: 8),
                FaIcon(icon, size: 13, color: fg),
              ],
            ),
          ),
        );
      },
    );
  }
}
