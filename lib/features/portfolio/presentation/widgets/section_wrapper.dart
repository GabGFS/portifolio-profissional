import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/responsive.dart';

/// Padroniza largura maxima, respiro lateral e espacamento vertical das secoes.
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final Color? background;
  final double? topPadding;
  final double? bottomPadding;

  const SectionWrapper({
    super.key,
    required this.child,
    this.background,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    final double vGap = Responsive.value(
      context,
      mobile: AppSizes.sectionGapMobile,
      desktop: AppSizes.sectionGapDesktop,
    );
    final double hPad = Responsive.value(
      context,
      mobile: AppSizes.x20,
      tablet: AppSizes.x32,
      desktop: AppSizes.x24,
    );

    return Container(
      width: double.infinity,
      color: background,
      padding: EdgeInsets.only(
        // Metade do respiro nos dois lados: a faixa de cor alternada ja separa
        // uma secao da outra, entao o espaco cheio so esticava a pagina.
        top: topPadding ?? vGap / 2,
        bottom: bottomPadding ?? vGap / 2,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: child,
          ),
        ),
      ),
    );
  }
}
