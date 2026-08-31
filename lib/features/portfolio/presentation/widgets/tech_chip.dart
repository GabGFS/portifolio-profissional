import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'tech_icons.dart';

/// Pilula de tecnologia com logo de marca colorido (Simple Icons), quando houver.
class TechChip extends StatelessWidget {
  final String label;

  const TechChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final TechIcon? icon = kTechIcons[label];
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? 12 : 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            SvgPicture.asset(
              icon.asset,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(icon.color, BlendMode.srcIn),
            ),
            const SizedBox(width: 9),
          ],
          Text(
            label,
            style: AppText.chip.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
