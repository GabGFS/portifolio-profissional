import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/developer_profile.dart';
import '../../domain/entities/localized_text.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/service_offering.dart';
import '../../domain/entities/skill_group.dart';
import '../../domain/entities/social_link.dart';

// =============================================================================
//  LINKS PARA CONFIRMAR / AJUSTAR
//  Troque os valores abaixo pelos links definitivos quando quiser.
//  - Deixe uma string vazia ('') para NAO exibir aquele botao no card.
// =============================================================================
class PortfolioLinks {
  const PortfolioLinks._();

  // Confirmados:
  static const String bibliaGameApp = 'https://github.com/GabGFS/biblia-game-app';
  static const String bibliaAppStore =
      'https://apps.apple.com/br/app/b%C3%ADblia-game/id6758924593';
  static const String plenaVittaCode = 'https://github.com/GabGFS/PlenaVittaTs';
  static const String plenaVittaLive = 'https://plenavitta.vercel.app';
  static const String realleadApp = 'https://github.com/brunomat480/reallead-app';
  static const String lazarosCode = 'https://github.com/GabGFS/testelazaros';
  static const String agendamentoCode =
      'https://github.com/GabGFS/TesteSiteGestaodeAgendamento';
  static const String golemsCode =
      'https://github.com/GabGFS/SitePrimeiroJogoLowCode';

  // A CONFIRMAR (preencha quando tiver o link exato; deixe '' para esconder o botao):
  static const String bibliaGameApi = 'https://github.com/GabGFS/biblia-game-api';
  static const String creditProposalsCode = ''; // <-- repo do desafio .NET
  static const String golemsLive = ''; // <-- GitHub Pages, se ativado
}

/// Fonte de dados local (em memoria) do portfolio.
///
/// Para um portfolio, os dados sao estaticos e versionados junto ao codigo.
/// Caso um dia venham de uma API/JSON, bastaria criar outra implementacao
/// desta mesma interface — o restante do app nao muda (Open/Closed + DIP).
abstract class PortfolioLocalDataSource {
  DeveloperProfile getProfile();
  List<Project> getProjects();
  List<SkillGroup> getSkillGroups();
  List<ServiceOffering> getServices();
  List<SocialLink> getSocialLinks();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  const PortfolioLocalDataSourceImpl();

  @override
  DeveloperProfile getProfile() {
    return const DeveloperProfile(
      name: AppConstants.fullName,
      displayName: AppConstants.displayName,
      role: LocalizedText(
        pt: 'Desenvolvedora de Software · Mobile & Backend',
        en: 'Software Developer · Mobile & Backend',
      ),
      tagline: LocalizedText(
        pt: 'Transformo ideias em aplicações reais — do mobile ao backend — '
            'com arquitetura limpa, testes e foco em qualidade.',
        en: 'I turn ideas into real applications — from mobile to backend — '
            'with clean architecture, testing and a focus on quality.',
      ),
      bio: <LocalizedText>[
        LocalizedText(
          pt: 'Sou desenvolvedora de software com foco em mobile (Flutter) e '
              'backend (Kotlin/Spring Boot, Node.js e .NET). Publiquei um app '
              'na Apple App Store com arquitetura distribuída e monitoramento '
              'de métricas de produto.',
          en: 'I am a software developer focused on mobile (Flutter) and '
              'backend (Kotlin/Spring Boot, Node.js and .NET). I published an '
              'app on the Apple App Store with a distributed architecture and '
              'product metrics monitoring.',
        ),
        LocalizedText(
          pt: 'Tenho background em Psicologia e Gestão de Pessoas, o que me dá '
              'uma visão de produto centrada no usuário. Estruturo cada projeto '
              'com Clean Architecture, SOLID e POO, sempre com testes '
              'automatizados. Inglês avançado (C1).',
          en: 'With a background in Psychology and People Management, I bring a '
              'user-centered product mindset. I structure every project with '
              'Clean Architecture, SOLID and OOP, always with automated tests. '
              'Advanced English (C1).',
        ),
      ],
      location: LocalizedText(
        pt: 'Campo Mourão, PR · Brasil · Remoto',
        en: 'Campo Mourão, PR · Brazil · Remote',
      ),
      imagePath: AppConstants.profileImage,
      cvPtUrl: 'cv/GabrielleSoratto_CV_PT.pdf',
      cvEnUrl: 'cv/GabrielleSoratto_CV_EN.pdf',
      highlights: <ProfileHighlight>[
        ProfileHighlight(
          value: 'App Store',
          label: LocalizedText(pt: 'app mobile publicado', en: 'published mobile app'),
        ),
        ProfileHighlight(
          value: '~44%',
          label: LocalizedText(
            pt: 'retenção de usuários ativos',
            en: 'active-user retention',
          ),
        ),
        ProfileHighlight(
          value: '8+',
          label: LocalizedText(pt: 'projetos ponta a ponta', en: 'end-to-end projects'),
        ),
        ProfileHighlight(
          value: 'C1',
          label: LocalizedText(pt: 'inglês avançado', en: 'advanced English'),
        ),
      ],
    );
  }

  @override
  List<Project> getProjects() {
    return const <Project>[
      // 1 — Destaque: app publicado na App Store
      Project(
        id: 'biblia-game',
        name: 'Bíblia Game',
        featured: true,
        year: '2025',
        category: ProjectCategory.mobile,
        type: LocalizedText(
          pt: 'App mobile · Publicado na App Store',
          en: 'Mobile app · Published on the App Store',
        ),
        description: LocalizedText(
          pt: 'Quiz bíblico com arquitetura distribuída, desenvolvido de ponta '
              'a ponta — da concepção à publicação na Apple App Store. Cliente '
              'Flutter + backend Kotlin/Spring Boot + AWS, com ~5% de conversão '
              'e ~44% de retenção de usuários ativos.',
          en: 'Bible quiz with a distributed architecture, built end-to-end — '
              'from concept to Apple App Store release. Flutter client + '
              'Kotlin/Spring Boot backend + AWS, with ~5% conversion and ~44% '
              'active-user retention.',
        ),
        techs: <String>['Flutter', 'Dart', 'GetX', 'Firebase', 'Clean Architecture', 'AWS'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.bibliaGameApp),
          ProjectLink.appStore(PortfolioLinks.bibliaAppStore),
        ],
      ),

      // 2 — Backend do app em destaque
      Project(
        id: 'biblia-game-api',
        name: 'Bíblia Game API',
        year: '2025',
        category: ProjectCategory.backend,
        type: LocalizedText(pt: 'API REST · Backend', en: 'REST API · Backend'),
        description: LocalizedText(
          pt: 'Backend do Bíblia Game em Kotlin + Spring Boot seguindo Clean '
              'Architecture (domain, application, infrastructure, presentation). '
              'PostgreSQL, documentação Swagger/OpenAPI, testes com JUnit 5 e '
              'MockK, containerizado com Docker.',
          en: 'Bíblia Game backend in Kotlin + Spring Boot following Clean '
              'Architecture (domain, application, infrastructure, presentation). '
              'PostgreSQL, Swagger/OpenAPI docs, JUnit 5 + MockK tests, '
              'containerized with Docker.',
        ),
        techs: <String>['Kotlin', 'Spring Boot', 'PostgreSQL', 'Swagger', 'Docker', 'JUnit'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.bibliaGameApi),
        ],
      ),

      // 3 — Full-stack, cliente real, no ar
      Project(
        id: 'plena-vitta',
        name: 'Plena Vitta',
        year: '2025',
        category: ProjectCategory.fullstack,
        type: LocalizedText(
          pt: 'Sistema web full-stack · Cliente real',
          en: 'Full-stack web system · Real client',
        ),
        description: LocalizedText(
          pt: 'Sistema completo para uma clínica de psicologia: landing page, '
              'agendamento, portais de usuário e admin, lembretes por WhatsApp '
              'e autenticação JWT com papéis. React + TypeScript no front, '
              'Node.js/Express + TypeScript no back, Clean Architecture + SOLID '
              'e 300+ testes automatizados.',
          en: 'Complete system for a psychology clinic: landing page, '
              'scheduling, user and admin portals, WhatsApp reminders and JWT '
              'auth with roles. React + TypeScript front, Node.js/Express + '
              'TypeScript back, Clean Architecture + SOLID and 300+ automated '
              'tests.',
        ),
        techs: <String>['React', 'TypeScript', 'Node.js', 'Express', 'SQLite / Turso', 'JWT', 'Docker'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.plenaVittaCode),
          ProjectLink.live(PortfolioLinks.plenaVittaLive),
        ],
      ),

      // 4 — App mobile cliente real (Grupo Fazolli / RealLead)
      Project(
        id: 'reallead-app',
        name: 'RealLead App',
        year: '2025',
        category: ProjectCategory.mobile,
        type: LocalizedText(
          pt: 'App mobile · Cliente real',
          en: 'Mobile app · Real client',
        ),
        description: LocalizedText(
          pt: 'App mobile complementar ao dashboard RealLead: métricas de '
              'tráfego (Meta Ads), monitoramento de campanhas e vendas em '
              'marketplace. Clean Architecture + MVVM com GetX, Supabase, Dio e '
              'gráficos com fl_chart, consumindo uma API NestJS.',
          en: 'Mobile companion to the RealLead dashboard: traffic metrics '
              '(Meta Ads), campaign monitoring and marketplace sales. Clean '
              'Architecture + MVVM with GetX, Supabase, Dio and fl_chart charts, '
              'consuming a NestJS API.',
        ),
        techs: <String>['Flutter', 'Dart', 'GetX', 'Supabase', 'Dio', 'fl_chart'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.realleadApp),
        ],
      ),

      // 5 — Backend .NET multi-tenant
      Project(
        id: 'credit-proposals',
        name: 'Credit Proposals API',
        year: '2025',
        category: ProjectCategory.backend,
        type: LocalizedText(
          pt: 'API multi-tenant · Backend',
          en: 'Multi-tenant API · Backend',
        ),
        description: LocalizedText(
          pt: 'API multi-tenant de propostas de crédito em .NET 8 / ASP.NET '
              'Core com Clean Architecture. Processamento assíncrono via AWS '
              'SQS (worker dedicado), webhooks idempotentes, EF Core + '
              'PostgreSQL, JWT com isolamento por tenant e testes com xUnit.',
          en: 'Multi-tenant credit-proposals API in .NET 8 / ASP.NET Core with '
              'Clean Architecture. Async processing via AWS SQS (dedicated '
              'worker), idempotent webhooks, EF Core + PostgreSQL, JWT with '
              'per-tenant isolation and xUnit tests.',
        ),
        techs: <String>['.NET 8', 'C#', 'ASP.NET Core', 'EF Core', 'PostgreSQL', 'AWS SQS'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.creditProposalsCode),
        ],
      ),

      // 6 — Full-stack Java + Angular
      Project(
        id: 'user-profile-manager',
        name: 'User & Profile Manager',
        year: '2025',
        category: ProjectCategory.fullstack,
        type: LocalizedText(
          pt: 'Full-stack · Java + Angular',
          en: 'Full-stack · Java + Angular',
        ),
        description: LocalizedText(
          pt: 'Sistema de gestão de usuários e perfis (relação N:N). Backend '
              'Java 24 + Spring Boot com Clean Architecture (ports & adapters) '
              'e frontend Angular 16 + Angular Material. PostgreSQL, Docker e '
              '200+ testes (JUnit/Mockito + Karma/Jasmine, 100% de cobertura '
              'no front).',
          en: 'User and profile management system (N:N relation). Java 24 + '
              'Spring Boot backend with Clean Architecture (ports & adapters) '
              'and Angular 16 + Angular Material frontend. PostgreSQL, Docker '
              'and 200+ tests (JUnit/Mockito + Karma/Jasmine, 100% front '
              'coverage).',
        ),
        techs: <String>['Java', 'Spring Boot', 'Angular', 'TypeScript', 'PostgreSQL', 'Docker'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.lazarosCode),
        ],
      ),

      // 7 — Web PHP + MVC
      Project(
        id: 'scheduling-mvc',
        name: 'Client & Scheduling System',
        year: '2024',
        category: ProjectCategory.web,
        type: LocalizedText(pt: 'Web · PHP + MVC', en: 'Web · PHP + MVC'),
        description: LocalizedText(
          pt: 'Sistema de gestão de clientes para uma psicóloga: cadastro, '
              'consulta, edição e exclusão, login e área do usuário com '
              'agendamentos. Desenvolvido em PHP + MySQL com padrão MVC, '
              'índices no banco e foco em manutenibilidade.',
          en: 'Client management system for a psychologist: create, read, '
              'update and delete, login and a user area with appointments. '
              'Built in PHP + MySQL with the MVC pattern, database indexes and '
              'a focus on maintainability.',
        ),
        techs: <String>['PHP', 'MySQL', 'MVC', 'JavaScript', 'HTML', 'CSS'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.agendamentoCode),
        ],
      ),

      // 8 — Jogo web low-code
      Project(
        id: 'land-of-golems',
        name: 'Land of Golems',
        year: '2024',
        category: ProjectCategory.game,
        type: LocalizedText(pt: 'Jogo web · Low-code', en: 'Web game · Low-code'),
        description: LocalizedText(
          pt: 'Jogo HTML5 "Land of Golems" criado com Construct 3 (low-code) e '
              'publicado para a web. Explora lógica de jogo, design de fases e '
              'deploy de um jogo rodando no navegador.',
          en: 'HTML5 game "Land of Golems" built with Construct 3 (low-code) '
              'and published for the web. Explores game logic, level design and '
              'deploying a browser-based game.',
        ),
        techs: <String>['Construct 3', 'HTML5', 'JavaScript', 'CSS'],
        links: <ProjectLink>[
          ProjectLink.code(PortfolioLinks.golemsCode),
          ProjectLink.live(PortfolioLinks.golemsLive),
        ],
      ),
    ];
  }

  @override
  List<SkillGroup> getSkillGroups() {
    return const <SkillGroup>[
      SkillGroup(
        category: SkillCategory.mobile,
        title: LocalizedText.all('Mobile'),
        items: <String>['Flutter', 'Dart', 'GetX', 'BLoC', 'Provider', 'get_it', 'SwiftUI'],
      ),
      SkillGroup(
        category: SkillCategory.backend,
        title: LocalizedText.all('Backend'),
        items: <String>[
          'Kotlin',
          'Spring Boot',
          'Node.js',
          'Express',
          'NestJS',
          '.NET / C#',
          'ASP.NET Core',
          'REST APIs',
          'Swagger',
        ],
      ),
      SkillGroup(
        category: SkillCategory.web,
        title: LocalizedText(pt: 'Front-end Web', en: 'Web Front-end'),
        items: <String>['React', 'Angular', 'Vue.js', 'Next.js', 'TypeScript', 'Tailwind CSS', 'SCSS / SASS'],
      ),
      SkillGroup(
        category: SkillCategory.cloud,
        title: LocalizedText.all('Cloud & DevOps'),
        items: <String>['AWS', 'S3', 'SQS', 'SNS', 'Lambda', 'API Gateway', 'ECS', 'Terraform', 'Docker'],
      ),
      SkillGroup(
        category: SkillCategory.databases,
        title: LocalizedText(pt: 'Bancos de dados', en: 'Databases'),
        items: <String>['PostgreSQL', 'MySQL', 'MongoDB', 'SQLite', 'Supabase', 'Turso / libSQL'],
      ),
      SkillGroup(
        category: SkillCategory.practices,
        title: LocalizedText(pt: 'Arquitetura & Testes', en: 'Architecture & Testing'),
        items: <String>[
          'Clean Architecture',
          'SOLID',
          'POO / OOP',
          'Repository Pattern',
          'Dependency Injection',
          'MVVM',
          'TDD',
          'JUnit',
          'MockK',
          'xUnit',
        ],
      ),
    ];
  }

  @override
  List<ServiceOffering> getServices() {
    return const <ServiceOffering>[
      ServiceOffering(
        type: ServiceType.mobile,
        title: LocalizedText(pt: 'Apps mobile', en: 'Mobile apps'),
        description: LocalizedText(
          pt: 'Aplicativos em Flutter, do design à publicação nas lojas, com '
              'arquitetura escalável e testes automatizados.',
          en: 'Flutter apps, from design to store publishing, with scalable '
              'architecture and automated tests.',
        ),
        tags: <String>['Flutter', 'Dart', 'iOS', 'Android'],
      ),
      ServiceOffering(
        type: ServiceType.backend,
        title: LocalizedText(pt: 'APIs & Backend', en: 'APIs & Backend'),
        description: LocalizedText(
          pt: 'APIs REST em Kotlin/Spring, Node.js e .NET, com Clean '
              'Architecture, autenticação, mensageria e banco de dados.',
          en: 'REST APIs in Kotlin/Spring, Node.js and .NET, with Clean '
              'Architecture, authentication, messaging and databases.',
        ),
        tags: <String>['Kotlin', 'Node.js', '.NET', 'PostgreSQL'],
      ),
      ServiceOffering(
        type: ServiceType.web,
        title: LocalizedText(pt: 'Sites & Sistemas web', en: 'Web sites & systems'),
        description: LocalizedText(
          pt: 'Interfaces responsivas em React, Angular e Next.js, integradas '
              'a APIs e prontas para deploy.',
          en: 'Responsive interfaces in React, Angular and Next.js, integrated '
              'with APIs and ready to deploy.',
        ),
        tags: <String>['React', 'Angular', 'Next.js', 'TypeScript'],
      ),
    ];
  }

  @override
  List<SocialLink> getSocialLinks() {
    return const <SocialLink>[
      SocialLink(type: SocialType.github, url: AppConstants.githubUrl, handle: 'GabGFS'),
      SocialLink(
        type: SocialType.linkedin,
        url: AppConstants.linkedinUrl,
        handle: 'gabrielle-felsky-soratto',
      ),
      SocialLink(type: SocialType.email, url: AppConstants.email, handle: AppConstants.email),
      SocialLink(
        type: SocialType.whatsapp,
        url: AppConstants.whatsappNumber,
        handle: AppConstants.phoneDisplay,
      ),
    ];
  }
}
