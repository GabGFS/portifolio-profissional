import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'hover.dart';

/// Botao de contorno (estilo da referencia): borda 1px, raio 12, sombra sutil.
class GhostButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool iconRight;
  final Color? accent;

  const GhostButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.iconRight = false,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final Color hoverColor = accent ?? AppColors.primary;
    return Hover(
      builder: (bool hovering) {
        final Color fg = hovering ? hoverColor : AppColors.textSecondary;
        final List<Widget> row = <Widget>[
          Text(
            label,
            style: AppText.label.copyWith(color: fg, fontWeight: FontWeight.w700),
          ),
          if (icon != null) ...<Widget>[
            const SizedBox(width: 10),
            FaIcon(icon, size: 14, color: fg),
          ],
        ];
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: hovering ? AppColors.surface : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: hovering ? hoverColor : AppColors.borderStrong),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: iconRight ? row : row.reversed.toList(),
            ),
          ),
        );
      },
    );
  }
}

/// Botao preenchido (acento) — uso pontual.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Hover(
      builder: (bool hovering) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            transform: Matrix4.translationValues(0, hovering ? -2 : 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  FaIcon(icon, size: 14, color: const Color(0xFF0D0E11)),
                  const SizedBox(width: 10),
                ],
                Text(
                  label,
                  style: AppText.label.copyWith(color: const Color(0xFF0D0E11)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
