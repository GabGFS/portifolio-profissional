import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/portfolio/data/datasources/portfolio_local_data_source.dart';
import 'package:portfolio/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/features/portfolio/domain/entities/project.dart';

void main() {
  final PortfolioRepositoryImpl repository =
      PortfolioRepositoryImpl(const PortfolioLocalDataSourceImpl());

  group('PortfolioRepositoryImpl', () {
    test('expoe os 8 projetos do portfolio', () async {
      final List<Project> projects = await repository.getProjects();
      expect(projects.length, 8);
    });

    test('remove links vazios (sem URL) dos projetos', () async {
      final List<Project> projects = await repository.getProjects();
      final bool everyLinkHasUrl = projects.every(
        (Project p) => p.links.every((ProjectLink l) => l.url.trim().isNotEmpty),
      );
      expect(everyLinkHasUrl, isTrue);
    });

    test('o primeiro projeto e o destaque (Bíblia Game)', () async {
      final List<Project> projects = await repository.getProjects();
      expect(projects.first.featured, isTrue);
      expect(projects.first.name, 'Bíblia Game');
    });

    test('perfil possui bio e destaques', () async {
      final profile = await repository.getProfile();
      expect(profile.bio, isNotEmpty);
      expect(profile.highlights.length, 4);
    });
  });
}
