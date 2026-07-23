import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/service_offering.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/service_card.dart';

/// Secao "Meus servicos".
class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final String lang = c.languageCode;

    return SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const RevealOnScroll(
            child: SectionHeader(
              kickerKey: 'services.kicker',
              titleKey: 'services.title',
              accent: AppColors.yellow,
            ),
          ),
          const SizedBox(height: 44),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const double gap = 20;
              final int cols = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 600
                      ? 2
                      : 1;
              final double width =
                  (constraints.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: c.services
                    .asMap()
                    .entries
                    .map((MapEntry<int, ServiceOffering> e) => SizedBox(
                          width: width,
                          child: RevealOnScroll(
                            delay: Duration(milliseconds: 70 * (e.key % cols)),
                            child: ServiceCard(
                                service: e.value, languageCode: lang),
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
