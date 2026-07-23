import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Controla o idioma atual (PT-BR / EN-US) de forma reativa.
///
/// A UI observa `locale`; ao alternar, `Get.updateLocale` reconstroi as
/// traducoes e o conteudo `LocalizedText` (que le [languageCode]).
class LocaleController extends GetxController {
  static const Locale ptBR = Locale('pt', 'BR');
  static const Locale enUS = Locale('en', 'US');

  final Rx<Locale> locale = ptBR.obs;

  bool get isPortuguese => locale.value.languageCode == 'pt';
  String get languageCode => locale.value.languageCode;

  void toggle() => setLocale(isPortuguese ? enUS : ptBR);

  void setLocale(Locale value) {
    locale.value = value;
    Get.updateLocale(value);
  }
}
