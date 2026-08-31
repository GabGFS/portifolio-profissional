import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/service_offering.dart';
import 'hover.dart';
import 'portfolio_visuals.dart';
import 'tech_chip.dart';

/// Card de servico (estilo da referencia): icone com acento, titulo, descricao.
class ServiceCard extends StatelessWidget {
  final ServiceOffering service;
  final String languageCode;

  const ServiceCard({
    super.key,
    required this.service,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = PortfolioVisuals.serviceColor(service.type);
    return Hover(
      cursor: MouseCursor.defer,
      builder: (bool hovering) {
        return AnimatedContainer(
          duration: AppDurations.medium,
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, hovering ? -6 : 0, 0),
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: hovering
                    ? accent.withValues(alpha: 0.6)
                    : AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Center(
                  child: FaIcon(PortfolioVisuals.serviceIcon(service.type),
                      size: 20, color: accent),
                ),
              ),
              const SizedBox(height: 22),
              Text(service.title.resolve(languageCode), style: AppText.h3),
              const SizedBox(height: 10),
              Text(service.description.resolve(languageCode),
                  style: AppText.body),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: service.tags.map((String t) => TechChip(t)).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
