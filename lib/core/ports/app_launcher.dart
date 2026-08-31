/// Abstracao para abertura de recursos externos (links, e-mail, WhatsApp).
///
/// Este arquivo nao importa nenhum pacote de infraestrutura de proposito: quem
/// depende da porta (a camada de apresentacao) nao passa a depender, de forma
/// transitiva, do `url_launcher`. O adaptador vive em `url_app_launcher.dart`.
///
/// Implementacoes podem lancar excecao quando o recurso nao puder ser aberto
/// (pop-up bloqueado, ausencia de handler para `mailto:`) — cabe ao chamador
/// tratar.
abstract class AppLauncher {
  Future<void> openUrl(String url);
  Future<void> openEmail(String address, {String? subject});
  Future<void> openWhatsApp(String number, {String? message});
}
