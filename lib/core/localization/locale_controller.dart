import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Controla o idioma atual (PT-BR / EN-US) de forma reativa.
///
/// A UI observa `locale`; ao alternar, `Get.updateLocale` reconstroi as
/// traducoes e o conteudo `LocalizedText` (que le [languageCode]).
class LocaleController extends GetxController {
  static const Locale ptBR = Locale('pt', 'BR');
  static const Locale enUS = Locale('en', 'US');

  /// Privado de proposito: mutar o valor direto pularia [Get.updateLocale],
  /// dessincronizando as chaves `.tr` do conteudo `LocalizedText`.
  final Rx<Locale> _locale = ptBR.obs;

  Locale get locale => _locale.value;
  bool get isPortuguese => _locale.value.languageCode == 'pt';
  String get languageCode => _locale.value.languageCode;

  void toggle() => setLocale(isPortuguese ? enUS : ptBR);

  void setLocale(Locale value) {
    _locale.value = value;
    Get.updateLocale(value);
  }
}
