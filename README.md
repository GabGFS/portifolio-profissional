# Portfólio — Gabrielle Soratto

Portfólio pessoal desenvolvido em **Flutter (web)**, seguindo **Clean Architecture**, **SOLID** e **POO**. Bilíngue (🇧🇷 PT / 🇺🇸 EN), tema dark com paleta multicolor e navegação por âncoras com animações de entrada.

Design system portado de `brunomatias.dev.br` (paleta, tipografia Asap + Inconsolata, layout centralizado, chips com logos de marca), com os projetos e as stacks da Gabrielle.

---

## ✨ Destaques

- **Bilíngue PT/EN** com troca instantânea (GetX i18n) — nenhuma dependência de rede.
- **Clean Architecture** de verdade: `domain` puro (sem Flutter), `data` e `presentation` separados.
- **SOLID + POO**: use cases de responsabilidade única, injeção de dependências, inversão de dependências (repositório via interface).
- **Responsivo** (mobile / tablet / desktop) com menu drawer no mobile.
- **8 projetos** reais com capa por categoria, chips de stack e links (código / deploy / App Store).
- Fontes **Asap** + **Inconsolata** empacotadas (offline), logos de marca **Simple Icons** (SVG) e ícones **Font Awesome**.
- **Testes unitários** cobrindo domínio e repositório.

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
│   ├── usecases/                  # Contrato base UseCase<Type, Params>
│   └── utils/                     # AppLauncher (abstração de url_launcher), Responsive
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
            ├── sections/          # Nav, Hero, Sobre, Skills, Projetos, Serviços, Contato, Footer
            └── widgets/           # Cards, botões, chips, animações reutilizáveis
```

**Fluxo de dependências (sempre para dentro):**
`presentation → domain ← data`. O `domain` não conhece Flutter, GetX, url_launcher nem a fonte de dados. Trocar os dados locais por uma API REST, por exemplo, exigiria apenas uma nova implementação de `PortfolioLocalDataSource` — nada mais muda.

### SOLID aplicado

| Princípio | Onde |
|-----------|------|
| **S** — Single Responsibility | Cada use case faz uma coisa; cada widget/seção tem um papel. |
| **O** — Open/Closed | Nova fonte de dados = nova implementação da interface, sem alterar o existente. |
| **L** — Liskov | `PortfolioRepositoryImpl` e `UrlAppLauncher` são substituíveis por suas interfaces (usado nos testes). |
| **I** — Interface Segregation | `AppLauncher` e `PortfolioRepository` são interfaces focadas. |
| **D** — Dependency Inversion | Controller depende de use cases e de `AppLauncher` (abstrações), injetados via GetX. |

---

## 🚀 Como rodar

Requisitos: **Flutter 3.19+** (recomendado via [FVM](https://fvm.app)).

```bash
flutter pub get
flutter run -d chrome        # roda no navegador
```

Build de produção (web):

```bash
flutter build web --release
# saída em build/web/ — pronta para deploy (Vercel, Netlify, GitHub Pages, Firebase Hosting...)
```

Testes:

```bash
flutter test
```

---

## ✏️ Como editar o conteúdo

Todo o conteúdo fica **num único arquivo**, fácil de manter:

- **Projetos, skills, serviços, perfil:**
  `lib/features/portfolio/data/datasources/portfolio_local_data_source.dart`

- **Links dos projetos** (no topo do mesmo arquivo, classe `PortfolioLinks`):
  troque as URLs; deixe `''` (vazio) para o botão não aparecer.
  Há um bloco `// A CONFIRMAR` com os links que faltam preencher:
  - `bibliaAppStore` → URL da App Store do Bíblia Game
  - `creditProposalsCode` → repositório do desafio .NET
  - `bibliaGameApi` → confirmar a URL do repositório da API
  - `golemsLive` → GitHub Pages do jogo (se ativado)

- **Textos de interface (menus, botões, títulos):**
  `lib/core/localization/app_translations.dart` (mapas `_pt` e `_en`).

- **Cores / tema:** `lib/core/theme/app_colors.dart`.

### Trocar a foto de perfil

Substitua o arquivo `assets/images/profile.png` pela sua foto (mantendo o nome).
Não precisa recortar: o layout usa `BoxFit.cover` e enquadra a imagem sozinho.
O caminho está em `AppConstants.profileImage` (`lib/core/constants/app_constants.dart`).

### Currículo (download)

Os PDFs ficam em `web/cv/` (servidos direto) e em `assets/cv/`.
O botão "Baixar CV" usa a versão do idioma ativo (PT ou EN).

---

## 🌐 Idiomas

O site abre em **Português** por padrão. O botão `PT | EN` (na navbar e no menu mobile)
alterna o idioma instantaneamente via `Get.updateLocale`. Conteúdo de dados usa o
value object `LocalizedText`, e a UI usa as traduções do GetX.

---

## 🧪 Testes

- `test/localized_text_test.dart` — resolução de idioma do `LocalizedText`.
- `test/portfolio_repository_impl_test.dart` — repositório expõe os 8 projetos e remove links vazios.

---

## 📦 Stack

Flutter · Dart · GetX (estado, DI, rotas, i18n) · url_launcher · font_awesome_flutter · flutter_svg · Asap + Inconsolata.

Feito com 💜 em Flutter.
