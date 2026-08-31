import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/social_link.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/portfolio_visuals.dart';
import '../widgets/social_button.dart';

/// Rodape: identidade, redes e creditos.
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
        Text(AppConstants.footerName,
            style: AppText.label.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('© $year ${AppConstants.footerName}. ${'footer.rights'.tr}',
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
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: isMobile
              ? Column(children: <Widget>[
                  identity,
                  const SizedBox(height: 28),
                  actions
                ])
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
