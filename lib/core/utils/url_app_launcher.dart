import 'package:url_launcher/url_launcher.dart';

import '../ports/app_launcher.dart';

/// Adaptador concreto da porta [AppLauncher], baseado no `url_launcher`.
class UrlAppLauncher implements AppLauncher {
  const UrlAppLauncher();

  @override
  Future<void> openUrl(String url) => _launch(Uri.parse(url));

  @override
  Future<void> openEmail(String address, {String? subject}) =>
      _launch(emailUri(address, subject: subject));

  @override
  Future<void> openWhatsApp(String number, {String? message}) =>
      _launch(whatsAppUri(number, message: message));

  /// Montagem da URI exposta para teste — e a parte com regra de verdade.
  static Uri emailUri(String address, {String? subject}) {
    return Uri(
      scheme: 'mailto',
      path: address,
      query: subject == null ? null : 'subject=${Uri.encodeComponent(subject)}',
    );
  }

  static Uri whatsAppUri(String number, {String? message}) {
    // Um mapa vazio faz o Uri.https anexar um '?' solto no fim da URL; passar
    // null evita isso.
    return Uri.https(
      'wa.me',
      '/$number',
      message == null ? null : <String, String>{'text': message},
    );
  }

  Future<void> _launch(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw Exception('Nao foi possivel abrir: $uri');
    }
  }
}
