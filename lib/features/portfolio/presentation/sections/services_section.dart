import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/uniform_grid.dart';
import '../widgets/service_card.dart';

/// Secao "Meus servicos".
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final String lang = c.languageCode;

    return SectionWrapper(
      background: AppColors.backgroundAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const RevealOnScroll(
            child: SectionHeader(
              center: false,
              kickerKey: 'services.kicker',
              accent: AppColors.yellow,
            ),
          ),
          const SizedBox(height: 44),
          UniformGrid(
            itemCount: c.services.length,
            columnsFor: (double maxWidth) => maxWidth >= 900
                ? 3
                : maxWidth >= 600
                    ? 2
                    : 1,
            itemBuilder: (int index, int columns) => RevealOnScroll(
              delay: Duration(milliseconds: 70 * (index % columns)),
              child: ServiceCard(service: c.services[index], languageCode: lang),
            ),
          ),
        ],
      ),
    );
  }
}
