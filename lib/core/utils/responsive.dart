import 'package:flutter/widgets.dart';
import '../constants/app_constants.dart';

/// Utilitario de responsividade baseado na largura da viewport.
class Responsive {
  const Responsive._();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) =>
      width(context) < Breakpoints.mobile;

  static bool isTablet(BuildContext context) {
    final double w = width(context);
    return w >= Breakpoints.mobile && w < Breakpoints.desktop;
  }

  static bool isDesktop(BuildContext context) =>
      width(context) >= Breakpoints.desktop;

  /// Retorna o valor adequado ao tamanho atual da tela.
  /// `tablet` cai para `desktop` quando nao informado.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }
}
