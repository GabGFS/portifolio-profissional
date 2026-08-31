/// Canais de contato/redes sociais.
enum SocialType { github, linkedin, email, whatsapp }

/// Link social/contato exibido no hero, contato e rodape.
class SocialLink {
  final SocialType type;

  /// Destino do canal — nem sempre uma URL: para [SocialType.email] e um
  /// endereco de e-mail e para [SocialType.whatsapp] e um numero. Quem sabe
  /// transformar isso em acao e a camada de apresentacao.
  final String target;

  final String handle;

  const SocialLink({
    required this.type,
    required this.target,
    required this.handle,
  });
}
