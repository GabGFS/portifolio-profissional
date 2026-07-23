import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/skill_group.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/portfolio_visuals.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/tech_chip.dart';

/// Stacks como nuvem de chips (com logos de marca), agrupadas por area.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final String lang = c.languageCode;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const RevealOnScroll(
            child: SectionHeader(
              kickerKey: 'skills.kicker',
              titleKey: 'skills.title',
              subtitleKey: 'skills.subtitle',
              accent: AppColors.green,
            ),
          ),
          const SizedBox(height: 44),
          for (final SkillGroup group in c.skillGroups)
            RevealOnScroll(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      group.title.resolve(lang),
                      style: AppText.kicker.copyWith(
                        color: PortfolioVisuals.skillColor(group.category),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: group.items
                          .map((String i) => TechChip(i))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
