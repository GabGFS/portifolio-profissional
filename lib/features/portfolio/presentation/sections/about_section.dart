import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/app_buttons.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';
import '../widgets/section_wrapper.dart';
import '../widgets/uniform_grid.dart';

/// Secao "Sobre mim": bio justificada em bloco central + numeros de destaque.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const List<Color> _accents = <Color>[
    AppColors.green,
    AppColors.blue,
    AppColors.purple,
    AppColors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final DeveloperProfile profile = c.profile.value!;
    final String lang = c.languageCode;

    return SectionWrapper(
      background: AppColors.backgroundAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const RevealOnScroll(
            child: SectionHeader(
              center: false,
              kickerKey: 'about.kicker',
              accent: AppColors.blue,
            ),
          ),
          const SizedBox(height: 36),
          RevealOnScroll(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (final _LocalizedBio b
                      in _bio(profile, lang)) ...<Widget>[
                    // O Flutter nao tem text-indent: o recuo da primeira linha
                    // vem de um espacador inline antes do texto.
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          const WidgetSpan(child: SizedBox(width: 34)),
                          TextSpan(text: b.text),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                      style: AppText.bodyLarge,
                    ),
                    if (!b.last) const SizedBox(height: 16),
                  ],
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const FaIcon(FontAwesomeIcons.locationDot,
                          size: 14, color: AppColors.green),
                      const SizedBox(width: 10),
                      Text(profile.location.resolve(lang), style: AppText.body),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: GhostButton(
                      label: 'hero.ctaCv'.tr,
                      icon: FontAwesomeIcons.download,
                      onTap: c.downloadCv,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(child: _stats(profile, lang)),
        ],
      ),
    );
  }

  List<_LocalizedBio> _bio(DeveloperProfile p, String lang) {
    return <_LocalizedBio>[
      for (int i = 0; i < p.bio.length; i++)
        _LocalizedBio(p.bio[i].resolve(lang), i == p.bio.length - 1),
    ];
  }

  Widget _stats(DeveloperProfile profile, String lang) {
    return UniformGrid(
      itemCount: profile.highlights.length,
      gap: 16,
      columnsFor: (double maxWidth) => maxWidth >= 760 ? 4 : 2,
      itemBuilder: (int index, int columns) => _StatCard(
        value: profile.highlights[index].value,
        label: profile.highlights[index].label.resolve(lang),
        accent: _accents[index % _accents.length],
      ),
    );
  }
}

class _LocalizedBio {
  final String text;
  final bool last;
  const _LocalizedBio(this.text, this.last);
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color accent;
  const _StatCard(
      {required this.value, required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(value, style: AppText.h2.copyWith(color: accent, fontSize: 24)),
          const SizedBox(height: 8),
          Text(label, style: AppText.small),
        ],
      ),
    );
  }
}
