import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';

/// Cabecalho de secao centralizado: kicker monospace colorido + titulo Asap.
class SectionHeader extends StatelessWidget {
  final String kickerKey;
  final String titleKey;
  final String? subtitleKey;
  final Color accent;
  final bool center;

  const SectionHeader({
    super.key,
    required this.kickerKey,
    required this.titleKey,
    this.subtitleKey,
    this.accent = AppColors.primary,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment cross =
        center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final TextAlign textAlign = center ? TextAlign.center : TextAlign.start;
    final double titleSize =
        Responsive.value<double>(context, mobile: 24, desktop: 30);

    return Column(
      crossAxisAlignment: cross,
      children: <Widget>[
        Text(kickerKey.tr,
            style: AppText.kicker.copyWith(color: accent),
            textAlign: textAlign),
        const SizedBox(height: 10),
        Text(
          titleKey.tr,
          textAlign: textAlign,
          style: AppText.h2.copyWith(fontSize: titleSize),
        ),
        if (subtitleKey != null) ...<Widget>[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(subtitleKey!.tr,
                textAlign: textAlign, style: AppText.body),
          ),
        ],
      ],
    );
  }
}
