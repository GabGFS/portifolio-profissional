import 'package:url_launcher/url_launcher.dart';

/// Abstracao para abertura de recursos externos (links, e-mail, WhatsApp).
///
/// A camada de apresentacao depende desta interface, e nao diretamente do
/// pacote `url_launcher` — respeitando o Dependency Inversion Principle e
/// permitindo substituir/mockar a implementacao em testes.
abstract class AppLauncher {
  Future<void> openUrl(String url);
  Future<void> openEmail(String address, {String? subject});
  Future<void> openWhatsApp(String number, {String? message});
}

/// Implementacao concreta baseada no pacote `url_launcher`.
class UrlAppLauncher implements AppLauncher {
  const UrlAppLauncher();

  @override
  Future<void> openUrl(String url) => _launch(Uri.parse(url));

  @override
  Future<void> openEmail(String address, {String? subject}) {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: address,
      query: subject == null ? null : 'subject=${Uri.encodeComponent(subject)}',
    );
    return _launch(uri);
  }

  @override
  Future<void> openWhatsApp(String number, {String? message}) {
    final Uri uri = Uri.https('wa.me', '/$number', <String, String>{
      if (message != null) 'text': message,
    });
    return _launch(uri);
  }

  Future<void> _launch(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw Exception('Nao foi possivel abrir: $uri');
    }
  }
}
