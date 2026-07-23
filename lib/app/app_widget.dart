import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../core/localization/app_translations.dart';
import '../core/localization/locale_controller.dart';
import '../core/theme/app_theme.dart';
import '../features/portfolio/presentation/pages/home_page.dart';
import 'bindings/initial_binding.dart';

/// Widget raiz da aplicacao.
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gabrielle Soratto — Software Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      translations: AppTranslations(),
      locale: LocaleController.ptBR,
      fallbackLocale: LocaleController.ptBR,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        LocaleController.ptBR,
        LocaleController.enUS,
      ],
      initialBinding: InitialBinding(),
      home: const HomePage(),
    );
  }
}
