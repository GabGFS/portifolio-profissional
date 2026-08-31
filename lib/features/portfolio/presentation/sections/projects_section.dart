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
      background: AppColors.backgroundAlt,
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
              final List<Project> items = c.projects;
              final List<Widget> rows = <Widget>[];
              for (int start = 0; start < items.length; start += cols) {
                final List<Widget> cells = <Widget>[];
                for (int col = 0; col < cols; col++) {
                  if (col > 0) cells.add(const SizedBox(width: gap));
                  final int index = start + col;
                  cells.add(
                    Expanded(
                      child: index < items.length
                          ? RevealOnScroll(
                              delay: Duration(milliseconds: 60 * col),
                              child: ProjectCard(
                                project: items[index],
                                languageCode: lang,
                                onLinkTap: c.openProjectLink,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }
                if (rows.isNotEmpty) rows.add(const SizedBox(height: gap));
                // IntrinsicHeight iguala a altura dos cards da mesma linha.
                rows.add(
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: cells,
                    ),
                  ),
                );
              }
              return Column(children: rows);
            },
          ),
        ],
      ),
    );
  }
}
