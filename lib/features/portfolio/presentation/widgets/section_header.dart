import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Cabecalho de secao: kicker monospace colorido e, quando houver, subtitulo.
///
/// Com [center] falso o bloco ocupa a largura toda, para que o texto encoste
/// de fato na margem esquerda em vez de ficar centralizado como um bloco.
class SectionHeader extends StatelessWidget {
  final String kickerKey;
  final String? subtitleKey;
  final Color accent;
  final bool center;

  const SectionHeader({
    super.key,
    required this.kickerKey,
    this.subtitleKey,
    this.accent = AppColors.primary,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment cross =
        center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final TextAlign textAlign = center ? TextAlign.center : TextAlign.start;
    return SizedBox(
      width: center ? null : double.infinity,
      child: Column(
        crossAxisAlignment: cross,
        children: <Widget>[
          Text(kickerKey.tr,
              // Dobro do tamanho base do kicker (16): aqui ele e o unico
              // titulo da secao, entao carrega sozinho a hierarquia.
              style: AppText.kicker.copyWith(color: accent, fontSize: 32),
              textAlign: textAlign),
          if (subtitleKey != null) ...<Widget>[
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(subtitleKey!.tr,
                  textAlign: textAlign, style: AppText.body),
            ),
          ],
        ],
      ),
    );
  }
}
