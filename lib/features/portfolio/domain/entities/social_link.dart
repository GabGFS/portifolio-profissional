/// Canais de contato/redes sociais.
enum SocialType { github, linkedin, email, whatsapp }

/// Link social/contato exibido no hero, contato e rodape.
class SocialLink {
  final SocialType type;
  final String url;
  final String handle;

  const SocialLink({
    required this.type,
    required this.url,
    required this.handle,
  });
}
