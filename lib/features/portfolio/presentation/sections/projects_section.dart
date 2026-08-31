import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/project_card.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/uniform_grid.dart';

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
              center: false,
              kickerKey: 'projects.kicker',
              subtitleKey: 'projects.subtitle',
              accent: AppColors.red,
            ),
          ),
          const SizedBox(height: 48),
          UniformGrid(
            itemCount: c.projects.length,
            gap: 22,
            columnsFor: (double maxWidth) => maxWidth >= 1040
                ? 3
                : maxWidth >= 680
                    ? 2
                    : 1,
            itemBuilder: (int index, int columns) => RevealOnScroll(
              delay: Duration(milliseconds: 60 * (index % columns)),
              child: ProjectCard(
                project: c.projects[index],
                languageCode: lang,
                onLinkTap: c.openProjectLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
