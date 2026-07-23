import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/portfolio/domain/entities/localized_text.dart';

void main() {
  group('LocalizedText', () {
    test('resolve retorna a versao correta por idioma', () {
      const LocalizedText text = LocalizedText(pt: 'Olá', en: 'Hi');
      expect(text.resolve('pt'), 'Olá');
      expect(text.resolve('en'), 'Hi');
    });

    test('resolve usa portugues como padrao para idioma desconhecido', () {
      const LocalizedText text = LocalizedText(pt: 'Olá', en: 'Hi');
      expect(text.resolve('xx'), 'Olá');
    });

    test('all() usa o mesmo valor nos dois idiomas', () {
      const LocalizedText text = LocalizedText.all('Flutter');
      expect(text.resolve('pt'), 'Flutter');
      expect(text.resolve('en'), 'Flutter');
    });

    test('igualdade por valor', () {
      expect(
        const LocalizedText(pt: 'a', en: 'b'),
        const LocalizedText(pt: 'a', en: 'b'),
      );
    });
  });
}
