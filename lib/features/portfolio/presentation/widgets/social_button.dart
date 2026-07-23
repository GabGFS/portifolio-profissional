import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import 'hover.dart';

/// Botao circular/quadrado para icones de contato/redes sociais.
class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final double size;

  const SocialButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.size = 46,
  });

  @override
  Widget build(BuildContext context) {
    final Widget button = Hover(
      builder: (bool hovering) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: Curves.easeOut,
            width: size,
            height: size,
            transform: Matrix4.translationValues(0, hovering ? -3 : 0, 0),
            decoration: BoxDecoration(
              color: hovering ? AppColors.primarySoft : AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusSm + 2),
              border: Border.all(
                color: hovering ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Center(
              child: FaIcon(
                icon,
                size: size * 0.4,
                color: hovering ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        );
      },
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
