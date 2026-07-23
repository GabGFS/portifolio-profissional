import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/project.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/project_card.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';

/// Secao de projetos (grade responsiva de cards).
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              kickerKey: 'projects.kicker',
              titleKey: 'projects.title',
              subtitleKey: 'projects.subtitle',
              accent: AppColors.red,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double gap = 22;
              final int cols = constraints.maxWidth >= 1040
                  ? 3
                  : constraints.maxWidth >= 680
                      ? 2
                      : 1;
              final double width = (constraints.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: c.projects
                    .asMap()
                    .entries
                    .map((MapEntry<int, Project> e) => SizedBox(
                          width: width,
                          child: RevealOnScroll(
                            delay: Duration(milliseconds: 60 * (e.key % cols)),
                            child: ProjectCard(
                              project: e.value,
                              languageCode: lang,
                              onLinkTap: c.openProjectLink,
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
