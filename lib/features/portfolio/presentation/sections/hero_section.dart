import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../domain/entities/developer_profile.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/app_buttons.dart';
import 'nav_bar.dart';

/// Hero centralizado (avatar + intro monospace + nome + curriculo).
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PortfolioController c = Get.find<PortfolioController>();
    final DeveloperProfile profile = c.profile.value!;
    final String lang = c.languageCode;
    final bool isMobile = Responsive.isMobile(context);
    final double hPad = Responsive.value<double>(context, mobile: 20, tablet: 32, desktop: 24);
    final double nameSize = Responsive.value<double>(context, mobile: 40, tablet: 52, desktop: 60);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: NavBar.height + (isMobile ? 40 : 64),
        bottom: isMobile ? 64 : 88,
      ),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.7),
          radius: 1.1,
          colors: <Color>[Color(0xFF1B2030), AppColors.background],
          stops: <double>[0, 0.7],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Column(
              children: <Widget>[
                _Avatar(imagePath: profile.imagePath),
                const SizedBox(height: 30),
                _MonoIntro(text: 'hero.greeting'.tr),
                const SizedBox(height: 8),
                Text(
                  profile.displayName,
                  textAlign: TextAlign.center,
                  style: AppText.display.copyWith(fontSize: nameSize),
                ),
                const SizedBox(height: 14),
                Text(
                  profile.role.resolve(lang),
                  textAlign: TextAlign.center,
                  style: AppText.h3.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 660),
                  child: Text(
                    profile.tagline.resolve(lang),
                    textAlign: TextAlign.center,
                    style: AppText.bodyLarge,
                  ),
                ),
                const SizedBox(height: 32),
                GhostButton(
                  label: 'hero.ctaCv'.tr,
                  icon: FontAwesomeIcons.download,
                  onTap: c.downloadCv,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String imagePath;
  const _Avatar({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    const double size = 140;
    return SizedBox(
      width: size + 12,
      height: size + 12,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          // anel gradiente
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: <Color>[AppColors.purple, AppColors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.purple.withOpacity(0.28),
                  blurRadius: 40,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // badge </> verde
          Positioned(
            right: 0,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                '</>',
                style: AppText.monoLine.copyWith(
                  color: AppColors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Linha "Hello World! ..." em monospace com cursor piscando.
class _MonoIntro extends StatefulWidget {
  final String text;
  const _MonoIntro({required this.text});

  @override
  State<_MonoIntro> createState() => _MonoIntroState();
}

class _MonoIntroState extends State<_MonoIntro> with SingleTickerProviderStateMixin {
  late final AnimationController _blink =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))
        ..repeat();

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: AppText.monoLine,
          ),
        ),
        FadeTransition(
          opacity: _blink.drive(_BlinkTween()),
          child: Container(
            width: 9,
            height: 20,
            margin: const EdgeInsets.only(left: 3),
            color: AppColors.green,
          ),
        ),
      ],
    );
  }
}

/// Tween que alterna 1/0 para o efeito de piscar.
class _BlinkTween extends Animatable<double> {
  @override
  double transform(double t) => t < 0.5 ? 1 : 0;
}
