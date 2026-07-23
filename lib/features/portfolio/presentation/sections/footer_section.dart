import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/social_link.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/hover.dart';
import '../widgets/portfolio_visuals.dart';
import '../widgets/social_button.dart';

/// Rodape: identidade, creditos e voltar ao topo.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final bool isMobile = Responsive.isMobile(context);
    final int year = DateTime.now().year;
    final double hPad =
        Responsive.value<double>(context, mobile: 20, tablet: 32, desktop: 24);

    final Widget identity = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                AppConstants.monogram,
                style: AppText.small.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
            const SizedBox(width: 10),
            Text(AppConstants.displayName,
                style: AppText.label.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'footer.built'.tr,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: AppText.small,
        ),
        const SizedBox(height: 4),
        Text('© $year ${AppConstants.displayName}. ${'footer.rights'.tr}',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: AppText.small),
      ],
    );

    final Widget actions = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: <Widget>[
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.end,
          children: c.socialLinks
              .map((SocialLink link) => SocialButton(
                    icon: PortfolioVisuals.socialIcon(link.type),
                    tooltip: link.handle,
                    size: 42,
                    onTap: () => c.openSocial(link),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        _BackToTop(onTap: c.scrollToTop),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDeep,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: hPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: isMobile
              ? Column(children: <Widget>[identity, const SizedBox(height: 28), actions])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(child: identity),
                    const SizedBox(width: 24),
                    actions,
                  ],
                ),
        ),
      ),
    );
  }
}

class _BackToTop extends StatelessWidget {
  final VoidCallback onTap;
  const _BackToTop({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hover(
      builder: (bool hovering) {
        return GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: hovering ? AppColors.surfaceHover : AppColors.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                  color: hovering ? AppColors.primary : AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('footer.backToTop'.tr,
                    style: AppText.small.copyWith(
                        color: hovering
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                FaIcon(FontAwesomeIcons.arrowUp,
                    size: 12,
                    color: hovering ? AppColors.primary : AppColors.textSecondary),
              ],
            ),
          ),
        );
      },
    );
  }
}
