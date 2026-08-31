import 'package:get/get.dart';

/// Chaves de traducao (rotulos de UI) para PT-BR e EN-US.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'pt_BR': _pt,
        'en_US': _en,
      };

  static const Map<String, String> _pt = <String, String>{
    // Navegacao
    'nav.home': 'Início',
    'nav.about': 'Sobre',
    'nav.skills': 'Stacks',
    'nav.projects': 'Projetos',
    'nav.services': 'Serviços',
    'nav.contact': 'Contato',

    // Hero
    'hero.greeting': 'Hello World! Meu nome é',
    'hero.ctaCv': 'Meu Currículo',

    // Sobre
    'about.kicker': 'Sobre mim',

    // Skills
    'skills.kicker': 'Stacks',
    'skills.subtitle':
        'Foco em Flutter e backend, com base sólida em arquitetura e testes.',

    // Projetos
    'projects.kicker': 'Meu trabalho',
    'projects.subtitle':
        'Uma seleção de projetos que desenvolvi de ponta a ponta.',
    'projects.featured': 'Destaque',
    'action.code': 'Code',
    'action.live': 'View',
    'action.appstore': 'App Store',
    'action.private': 'Repositório privado',
    'action.watch': 'Ver vídeo',
    'action.play': 'Reproduzir',
    'action.pause': 'Pausar',
    'action.mute': 'Desativar som',
    'action.unmute': 'Ativar som',
    'action.close': 'Fechar',
    'action.videoError': 'Não foi possível carregar o vídeo.',
    'contact.emailSubject': 'Contato via portfólio',
    'contact.whatsappMessage': 'Olá, Gabrielle! Vi o seu portfólio.',

    // Servicos
    'services.kicker': 'Serviços',

    // Contato
    'contact.kicker': 'Contato',
    'contact.subtitle':
        'Entre em contato ou acompanhe as minhas redes sociais!',

    // Rodape
    'footer.rights': 'Todos os direitos reservados.',
  };

  static const Map<String, String> _en = <String, String>{
    // Navigation
    'nav.home': 'Home',
    'nav.about': 'About',
    'nav.skills': 'Stack',
    'nav.projects': 'Projects',
    'nav.services': 'Services',
    'nav.contact': 'Contact',

    // Hero
    'hero.greeting': 'Hello World! My name is',
    'hero.ctaCv': 'My Resume',

    // About
    'about.kicker': 'About me',

    // Skills
    'skills.kicker': 'Stack',
    'skills.subtitle':
        'Focused on Flutter and backend, grounded in architecture and testing.',

    // Projects
    'projects.kicker': 'My work',
    'projects.subtitle': 'A selection of projects I built end-to-end.',
    'projects.featured': 'Featured',
    'action.code': 'Code',
    'action.live': 'View',
    'action.appstore': 'App Store',
    'action.private': 'Private repo',
    'action.watch': 'Watch video',
    'action.play': 'Play',
    'action.pause': 'Pause',
    'action.mute': 'Mute',
    'action.unmute': 'Unmute',
    'action.close': 'Close',
    'action.videoError': 'The video could not be loaded.',
    'contact.emailSubject': 'Contact via portfolio',
    'contact.whatsappMessage': 'Hi, Gabrielle! I saw your portfolio.',

    // Services
    'services.kicker': 'Services',

    // Contact
    'contact.kicker': 'Contact',
    'contact.subtitle': 'Get in touch or follow me on social media!',

    // Footer
    'footer.rights': 'All rights reserved.',
  };
}
