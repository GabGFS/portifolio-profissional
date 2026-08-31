import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/portfolio/domain/entities/developer_profile.dart';
import 'package:portfolio/features/portfolio/domain/entities/localized_text.dart';
import 'package:portfolio/features/portfolio/domain/entities/project.dart';

Project _project({List<ProjectLink> links = const <ProjectLink>[]}) {
  return Project(
    id: 'id',
    name: 'Nome',
    type: const LocalizedText.all('Tipo'),
    description: const LocalizedText.all('Descricao'),
    techs: const <String>['Dart'],
    links: links,
    category: ProjectCategory.mobile,
    year: '2025',
    featured: true,
    videoAsset: 'assets/videos/x.mp4',
    privateRepo: true,
  );
}

void main() {
  group('Project.copyWith', () {
    test('troca apenas os links e preserva todos os demais campos', () {
      final Project original =
          _project(links: <ProjectLink>[const ProjectLink.code('a')]);
      final Project copy =
          original.copyWith(links: <ProjectLink>[const ProjectLink.live('b')]);

      expect(copy.links.single.url, 'b');
      expect(copy.id, original.id);
      expect(copy.name, original.name);
      expect(copy.techs, original.techs);
      expect(copy.category, original.category);
      expect(copy.year, original.year);
      expect(copy.featured, original.featured);
      expect(copy.videoAsset, original.videoAsset);
      expect(copy.privateRepo, original.privateRepo);
    });

    test('sem argumento, mantem os links', () {
      final Project original =
          _project(links: <ProjectLink>[const ProjectLink.code('a')]);
      expect(original.copyWith().links, original.links);
    });
  });

  group('Project.hasVideo / hasLinks', () {
    test('refletem a presenca de video e de links', () {
      expect(_project().hasVideo, isTrue);
      expect(_project().hasLinks, isFalse);
      expect(
          _project(links: <ProjectLink>[const ProjectLink.code('a')]).hasLinks,
          isTrue);
    });
  });

  group('DeveloperProfile.cvUrlFor', () {
    const DeveloperProfile profile = DeveloperProfile(
      name: 'N',
      displayName: 'N',
      role: LocalizedText.all('R'),
      tagline: LocalizedText.all('T'),
      bio: <LocalizedText>[LocalizedText.all('B')],
      location: LocalizedText.all('L'),
      imagePath: 'p.webp',
      cvPtUrl: 'cv/pt.pdf',
      cvEnUrl: 'cv/en.pdf',
      highlights: <ProfileHighlight>[],
    );

    test('escolhe o PDF pelo idioma, com pt como padrao', () {
      expect(profile.cvUrlFor('pt'), 'cv/pt.pdf');
      expect(profile.cvUrlFor('en'), 'cv/en.pdf');
      expect(profile.cvUrlFor('xx'), 'cv/pt.pdf');
    });
  });
}
