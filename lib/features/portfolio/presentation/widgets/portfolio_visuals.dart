import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/service_offering.dart';
import '../../domain/entities/skill_group.dart';
import '../../domain/entities/social_link.dart';

/// Mapeia enums do dominio para recursos visuais (icones e cores de acento).
class PortfolioVisuals {
  const PortfolioVisuals._();

  // Icones de contato/redes (Font Awesome — cobre GitHub/LinkedIn/WhatsApp/e-mail).
  static IconData socialIcon(SocialType type) {
    switch (type) {
      case SocialType.github:
        return FontAwesomeIcons.github;
      case SocialType.linkedin:
        return FontAwesomeIcons.linkedinIn;
      case SocialType.email:
        return FontAwesomeIcons.solidEnvelope;
      case SocialType.whatsapp:
        return FontAwesomeIcons.whatsapp;
    }
  }

  static Color socialColor(SocialType type) {
    switch (type) {
      case SocialType.github:
        return AppColors.textSecondary;
      case SocialType.linkedin:
        return const Color(0xFF3996DB);
      case SocialType.email:
        return AppColors.red;
      case SocialType.whatsapp:
        return const Color(0xFF25D366);
    }
  }

  static IconData serviceIcon(ServiceType type) {
    switch (type) {
      case ServiceType.mobile:
        return FontAwesomeIcons.mobileScreenButton;
      case ServiceType.backend:
        return FontAwesomeIcons.server;
      case ServiceType.web:
        return FontAwesomeIcons.globe;
    }
  }

  static IconData categoryIcon(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return FontAwesomeIcons.mobileScreenButton;
      case ProjectCategory.backend:
        return FontAwesomeIcons.server;
      case ProjectCategory.fullstack:
        return FontAwesomeIcons.layerGroup;
      case ProjectCategory.web:
        return FontAwesomeIcons.globe;
      case ProjectCategory.game:
        return FontAwesomeIcons.gamepad;
    }
  }

  static IconData linkIcon(ProjectLinkType type) {
    switch (type) {
      case ProjectLinkType.code:
        return FontAwesomeIcons.code;
      case ProjectLinkType.live:
        return FontAwesomeIcons.globe;
      case ProjectLinkType.appStore:
        return FontAwesomeIcons.appStoreIos;
    }
  }

  /// Cor de acento por categoria (paleta multicolor da referencia).
  static Color categoryColor(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.mobile:
        return AppColors.green;
      case ProjectCategory.backend:
        return AppColors.blue;
      case ProjectCategory.fullstack:
        return AppColors.purple;
      case ProjectCategory.web:
        return AppColors.yellow;
      case ProjectCategory.game:
        return AppColors.red;
    }
  }

  /// Cor de acento por grupo de skills.
  static Color skillColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.mobile:
        return AppColors.green;
      case SkillCategory.backend:
        return AppColors.blue;
      case SkillCategory.web:
        return AppColors.yellow;
      case SkillCategory.cloud:
        return AppColors.purple;
      case SkillCategory.databases:
        return AppColors.red;
      case SkillCategory.practices:
        return AppColors.green;
    }
  }
}
