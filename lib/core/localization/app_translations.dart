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
    'hero.role': 'Desenvolvedora de Software · Mobile & Backend',
    'hero.ctaCv': 'Meu Currículo',
    'hero.ctaProjects': 'Ver projetos',
    'hero.ctaContact': 'Fale comigo',
    'hero.available': 'Disponível para novos projetos',
    'hero.scroll': 'Role para explorar',

    // Sobre
    'about.kicker': 'Sobre mim',
    'about.title': 'Do mobile ao backend, com arquitetura limpa',
    'stat.appstore': 'app mobile publicado',
    'stat.retention': 'retenção de usuários ativos',
    'stat.projects': 'projetos ponta a ponta',
    'stat.english': 'inglês avançado',

    // Skills
    'skills.kicker': 'Stacks',
    'skills.title': 'Tecnologias que eu uso',
    'skills.subtitle':
        'Foco em Flutter e backend, com base sólida em arquitetura e testes.',

    // Projetos
    'projects.kicker': 'Meu trabalho',
    'projects.title': 'Veja os projetos em destaque',
    'projects.subtitle': 'Uma seleção de projetos que desenvolvi de ponta a ponta.',
    'projects.featured': 'Destaque',
    'action.code': 'Code',
    'action.live': 'View',
    'action.appstore': 'App Store',
    'action.private': 'Repositório privado',
    'action.details': 'Detalhes',

    // Servicos
    'services.kicker': 'Serviços',
    'services.title': 'Meus serviços',

    // Contato
    'contact.kicker': 'Contato',
    'contact.title': 'Gostou do meu trabalho?',
    'contact.subtitle': 'Entre em contato ou acompanhe as minhas redes sociais!',
    'contact.emailBtn': 'Enviar e-mail',
    'contact.whatsappBtn': 'WhatsApp',
    'contact.copied': 'E-mail copiado!',

    // Rodape
    'footer.built': 'Feito em Flutter, com Clean Architecture, SOLID e POO.',
    'footer.rights': 'Todos os direitos reservados.',
    'footer.backToTop': 'Voltar ao topo',

    'lang.switchTo': 'EN',
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
    'hero.role': 'Software Developer · Mobile & Backend',
    'hero.ctaCv': 'My Resume',
    'hero.ctaProjects': 'View projects',
    'hero.ctaContact': 'Get in touch',
    'hero.available': 'Available for new projects',
    'hero.scroll': 'Scroll to explore',

    // About
    'about.kicker': 'About me',
    'about.title': 'From mobile to backend, with clean architecture',
    'stat.appstore': 'published mobile app',
    'stat.retention': 'active-user retention',
    'stat.projects': 'end-to-end projects',
    'stat.english': 'advanced English',

    // Skills
    'skills.kicker': 'Stack',
    'skills.title': 'Technologies I work with',
    'skills.subtitle':
        'Focused on Flutter and backend, grounded in architecture and testing.',

    // Projects
    'projects.kicker': 'My work',
    'projects.title': 'Featured projects',
    'projects.subtitle': 'A selection of projects I built end-to-end.',
    'projects.featured': 'Featured',
    'action.code': 'Code',
    'action.live': 'View',
    'action.appstore': 'App Store',
    'action.private': 'Private repo',
    'action.details': 'Details',

    // Services
    'services.kicker': 'Services',
    'services.title': 'My services',

    // Contact
    'contact.kicker': 'Contact',
    'contact.title': 'Liked my work?',
    'contact.subtitle': 'Get in touch or follow me on social media!',
    'contact.emailBtn': 'Send e-mail',
    'contact.whatsappBtn': 'WhatsApp',
    'contact.copied': 'E-mail copied!',

    // Footer
    'footer.built': 'Built with Flutter — Clean Architecture, SOLID and OOP.',
    'footer.rights': 'All rights reserved.',
    'footer.backToTop': 'Back to top',

    'lang.switchTo': 'PT',
  };
}
