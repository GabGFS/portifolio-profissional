import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/utils/url_app_launcher.dart';

void main() {
  group('UrlAppLauncher.emailUri', () {
    test('monta mailto sem query quando nao ha assunto', () {
      final Uri uri = UrlAppLauncher.emailUri('a@b.com');
      expect(uri.scheme, 'mailto');
      expect(uri.path, 'a@b.com');
      expect(uri.query, isEmpty);
    });

    test('codifica acentos e espacos do assunto', () {
      final Uri uri =
          UrlAppLauncher.emailUri('a@b.com', subject: 'Contato via portfólio');
      expect(uri.query, 'subject=Contato%20via%20portf%C3%B3lio');
    });
  });

  group('UrlAppLauncher.whatsAppUri', () {
    test('monta o link do wa.me com o numero no caminho', () {
      final Uri uri = UrlAppLauncher.whatsAppUri('5544997418687');
      expect(uri.toString(), 'https://wa.me/5544997418687');
    });

    test('inclui a mensagem como parametro text', () {
      final Uri uri =
          UrlAppLauncher.whatsAppUri('5544997418687', message: 'Olá!');
      expect(uri.queryParameters['text'], 'Olá!');
    });
  });
}
