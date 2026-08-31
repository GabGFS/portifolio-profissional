# Portfólio — Gabrielle Soratto

Portfólio pessoal em **Flutter Web**, seguindo **Clean Architecture**, **SOLID** e **POO**. Bilíngue (🇧🇷 PT / 🇺🇸 EN), tema dark com paleta multicolor, seções alternadas e navegação por âncoras com animações de entrada.

🔗 **[gabgfs.github.io/portifolio-profissional](https://gabgfs.github.io/portifolio-profissional/)**

Design system portado de `brunomatias.dev.br` (paleta, tipografia Asap + Inconsolata, chips com logos de marca), com os projetos e as stacks da Gabrielle.

---

## ✨ Destaques

- **Bilíngue PT/EN** com troca instantânea (GetX i18n) — nenhuma dependência de rede.
- **Clean Architecture** de verdade: `domain` puro (sem Flutter, sem GetX, sem pacotes), `data` e `presentation` separados.
- **SOLID + POO**: use cases de responsabilidade única, injeção por construtor, inversão de dependências via interface.
- **Vídeos de demonstração** em quatro projetos: play no hover da capa e player em camada sobre a página, sem sair do site.
- **Responsivo** (mobile / tablet / desktop) com menu drawer no mobile.
- **8 projetos** reais com capa por categoria, chips de stack e links (código / deploy / App Store).
- Fontes **Asap** + **Inconsolata** empacotadas (offline), logos **Simple Icons** (SVG) e ícones **Font Awesome**.
- **Deploy automático** no GitHub Pages a cada push na `main`, com analyze e testes barrando publicação quebrada.

---

## 🏗️ Arquitetura

```
lib/
├── main.dart                      # Entry point
├── app/
│   ├── app_widget.dart            # GetMaterialApp (tema, i18n, rotas, binding)
│   └── bindings/
│       └── initial_binding.dart   # Composition Root (injeção de dependências)
├── core/                          # Infra compartilhada (sem regra de negócio)
│   ├── constants/                 # Constantes, tamanhos, breakpoints
│   ├── theme/                     # Cores, tipografia, ThemeData
│   ├── localization/              # Traduções PT/EN + LocaleController
│   ├── usecases/                  # Contrato base UseCase<T, Params>
│   ├── ports/                     # AppLauncher (interface pura, sem imports)
│   └── utils/                     # UrlAppLauncher (adaptador), Responsive
└── features/
    └── portfolio/
        ├── domain/                # 🧠 Regra de negócio — SEM Flutter
        │   ├── entities/          # DeveloperProfile, Project, SkillGroup, ...
        │   ├── repositories/      # PortfolioRepository (interface)
        │   └── usecases/          # GetProfile, GetProjects, GetSkillGroups, ...
        ├── data/                  # 💾 Implementações
        │   ├── datasources/       # Dados locais (perfil, projetos, skills...)
        │   └── repositories/      # PortfolioRepositoryImpl
        └── presentation/          # 🎨 UI (MVVM com GetX)
            ├── controllers/       # PortfolioController (ViewModel)
            ├── pages/             # HomePage
            ├── sections/          # Nav, Hero, Sobre, Projetos, Serviços, Stacks, Contato, Footer
            └── widgets/           # Cards, grade, player de vídeo, animações
```

**Fluxo de dependências (sempre para dentro):**
`presentation → domain ← data`. O `domain` não conhece Flutter, GetX, `url_launcher` nem a fonte de dados. Trocar os dados locais por uma API REST exigiria apenas uma nova implementação de `PortfolioLocalDataSource` — nada mais muda.

**Porta e adaptador:** `core/ports/app_launcher.dart` declara a interface e não importa nada. O adaptador concreto vive em `core/utils/url_app_launcher.dart` e é o **único arquivo do projeto** que importa `url_launcher` — assim a apresentação não passa a depender do pacote por transitividade.

### SOLID aplicado

| Princípio | Onde |
|-----------|------|
| **S** — Single Responsibility | Cada use case faz uma coisa; cada widget/seção tem um papel. |
| **O** — Open/Closed | `PortfolioVisuals` concentra todo mapeamento enum→visual: uma categoria nova se resolve num arquivo só. |
| **L** — Liskov | `PortfolioRepositoryImpl` e `UrlAppLauncher` são substituíveis por suas interfaces (usado nos testes). |
| **I** — Interface Segregation | `AppLauncher` e `PortfolioRepository` são interfaces focadas num agregado coeso. |
| **D** — Dependency Inversion | O controller recebe use cases, `AppLauncher` e `LocaleController` por construtor — sem service locator interno. |

---

## 🚀 Como rodar

O projeto fixa o SDK no `.fvmrc` (**Flutter 3.38.7**), via [FVM](https://fvm.app):

```bash
fvm flutter pub get
fvm flutter run -d chrome
```

Sem FVM, use um Flutter 3.19+ e troque `fvm flutter` por `flutter`.

Análise, testes e formatação:

```bash
fvm flutter analyze
fvm flutter test
fvm dart format lib test
```

---

## 🌐 Deploy

Publicado no **GitHub Pages** por `.github/workflows/deploy.yml`, disparado a cada push na `main`. O workflow instala o Flutter 3.38.7, roda `analyze` e `test`, compila e publica — se algo falhar, nada vai ao ar.

O build usa `--base-href /portifolio-profissional/`, a subpasta do Pages. **Sem isso a página sobe em branco**, porque procura o `main.dart.js` na raiz do domínio. Ao migrar para domínio próprio, esse valor vira `/`.

Build local de produção:

```bash
fvm flutter build web --release --base-href /portifolio-profissional/
```

---

## ✏️ Como editar o conteúdo

Todo o conteúdo fica **num único arquivo**:
`lib/features/portfolio/data/datasources/portfolio_local_data_source.dart`

- **Perfil, projetos, skills, serviços** — as listas `const` do arquivo.
- **Links dos projetos** — classe `PortfolioLinks`, no topo. Uma string vazia (`''`) esconde o botão. Para sinalizar código fechado, use `privateRepo: true` no `Project`, o que exibe 🔒 *Repositório privado* ao lado dos demais botões.
- **Vídeo de um projeto** — campo `videoAsset` do `Project`, apontando para um arquivo em `assets/videos/`.

Outros pontos:

- **Textos de interface** (menus, botões, rótulos): `lib/core/localization/app_translations.dart` (mapas `_pt` e `_en`).
- **Cores e faixas de seção:** `lib/core/theme/app_colors.dart`.
- **Ordem das seções:** o enum `PortfolioSection` (ordem das âncoras), a lista `kNavItems` (menu) e a `Column` de `_ScrollContent` em `home_page.dart` (ordem visual) precisam concordar entre si.

### Trocar a foto de perfil

O caminho está em `AppConstants.profileImage` (`lib/core/constants/app_constants.dart`), hoje `assets/images/perfil.webp`. Não precisa recortar: o layout usa `BoxFit.cover`.

### Trocar o currículo

Os PDFs ficam **só** em `web/cv/`, servidos diretamente. Substitua os arquivos mantendo os nomes e nada no código muda — o botão escolhe a versão pelo idioma ativo (`DeveloperProfile.cvUrlFor`).

### Adicionar um vídeo

Comprima antes de commitar — uma gravação de tela bruta passa fácil de 50 MB:

```bash
ffmpeg -i original.mov -vf "scale=1280:-2,fps=30" \
  -c:v libx264 -preset medium -crf 24 -pix_fmt yuv420p \
  -c:a aac -b:a 128k -movflags +faststart \
  assets/videos/nome-do-projeto.mp4
```

Vídeos verticais não precisam de `scale` — mantenha a resolução original. Os arquivos-fonte ficam em `_video_sources/`, que o `.gitignore` mantém fora do repositório e do build.

---

## 🗣️ Idiomas

O site abre em **Português**. O botão `PT | EN` (navbar e menu mobile) alterna instantaneamente via `Get.updateLocale`. Dados usam o value object `LocalizedText`; a UI usa as traduções do GetX.

---

## 🧪 Testes

| Arquivo | Cobre |
|---|---|
| `localized_text_test.dart` | Resolução de idioma, com fallback para PT. |
| `portfolio_repository_impl_test.dart` | Repositório expõe os 8 projetos e remove links vazios. |
| `entities_test.dart` | `Project.copyWith`, `hasVideo`/`hasLinks` e escolha do PDF por idioma. |
| `url_app_launcher_test.dart` | Montagem das URIs de e-mail (encoding do assunto) e de WhatsApp. |

---

## 📦 Stack

Flutter · Dart · GetX (estado, DI, rotas, i18n) · url_launcher · video_player · font_awesome_flutter · flutter_svg · Asap + Inconsolata.

Feito com 💜 em Flutter.
