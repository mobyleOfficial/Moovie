# Moovie

A modular Flutter app for discovering movies, reading reviews, and social interaction. Built by Mobyle using Clean Architecture, BLoC state management, and a multi-package monorepo structure.

---

## Overview

Moovie is a multi-flavor Flutter application that consumes The Movie Database (TMDB) API and a custom backend. It supports English, Spanish, and Portuguese, adapts to light/dark themes, and is structured as a monorepo with independently versioned packages for each feature and UI module.

**Main tabs:**
- **Home** — Trending movies and reviews
- **Search** — Movie search
- **Social** — Social activity feed
- **Profile** — User profile

---

## Installation

### Prerequisites

- Flutter SDK (Dart `^3.11.4`)
- Ruby 3.2.0 (via rbenv or system)
- Android Studio or VS Code with Flutter extension
- Environment file at `secrets/.env` (see [Configuration](#configuration))

### Steps

```bash
# 1. Clone the repository
git clone <repo-url>
cd moovie

# 2. Setup environment
rbenv local 3.2.0
bundle install

# 3. Create the secrets/env file (see Configuration section)
cp secrets/.env.example secrets/.env
# Edit secrets/.env with real values

# 4. Install Flutter dependencies (root + all packages)
flutter pub get

# 5. Run code generation (routing, DI, ObjectBox)
dart run build_runner build --delete-conflicting-outputs

# 6. Setup IDE run configurations
bundle exec fastlane setup_ide

# 7. Run the app
flutter run                              # production flavor
flutter run -t lib/main_dev.dart        # dev flavor
flutter run -t lib/main_staging.dart    # staging flavor
```

---

## Configuration

The app reads environment variables at build time. Create a `.env` file in the `secrets/` folder:

```bash
cp secrets/.env.example secrets/.env
```

Then edit `secrets/.env`:

```env
TMDB_API_KEY=your_tmdb_bearer_token
BACKEND_URL=https://your-backend-url.com
```

| Variable | Description |
|----------|-------------|
| `TMDB_API_KEY` | Bearer token for the TMDB v4 API |
| `BACKEND_URL` | Base URL for the Moovie backend service |

### App Flavors

| Flavor | Entry point | App name |
|--------|-------------|----------|
| `prod` | `lib/main.dart` | Moovie |
| `staging` | `lib/main_staging.dart` | Moovie[Stg] |
| `dev` | `lib/main_dev.dart` | Moovie[Dev] |

Flavor-specific configuration lives in `lib/config/app_config.dart`.

---

## Project Structure

```
moovie/
├── lib/                        # Main app (entry points, routing, DI)
│   ├── main.dart               # Production entry point
│   ├── main_dev.dart
│   ├── main_staging.dart
│   ├── config/
│   │   └── app_config.dart     # Flavor configuration
│   ├── di/
│   │   ├── injection.dart      # GetIt setup
│   │   ├── http_di_module.dart # Dio clients (TMDB + Backend)
│   │   └── movies_module.dart  # Movies use case bindings
│   └── routes/
│       ├── app_router.dart     # Route definitions (auto_route)
│       └── main_screen.dart    # Bottom navigation shell
│
├── core/                       # Shared abstractions package
│   └── lib/                    # HttpClient interface, UseCase base, Result types
│
├── features/                   # Business logic (Clean Architecture)
│   ├── movies/
│   │   ├── domain/             # Package: movies_domain (pure Dart, no deps)
│   │   │   └── lib/            # Entities, repository contracts, use cases
│   │   └── data/               # Package: movies_data (implements domain)
│   │       └── lib/            # Data models, repositories, datasources
│   ├── news/
│   │   ├── domain/             # Package: news_domain
│   │   └── data/               # Package: news_data
│   └── profile/
│       ├── domain/             # Package: profile_domain
│       └── data/               # Package: profile_data
│
└── ui/                         # Presentation layer (UI packages)
    ├── common/                 # Shared: theme, components, localization
    ├── home/                   # Home tab
    ├── movies_list/            # Paginated movie list
    ├── movie_detail/           # Movie detail screen
    ├── search/                 # Search tab
    ├── social/                 # Social tab
    ├── profile/                # Profile tab (package: profile_ui)
    ├── reviews/                # Reviews sub-feature
    └── new_user_activity/      # Onboarding modal
```

### Package dependency graph

```
App (moovie)
 ├── core
 ├── features/<name>  ──>  <name>_data  ──>  <name>_domain  ──>  core
 └── ui/<module>      ──>  common
                      ──>  features/<name>  (via domain layer only)
```

- `domain` packages have **zero** external dependencies — pure Dart.
- `data` packages implement `domain` contracts and own all serialization/persistence.
- UI modules never import from another feature's `data` layer.

---

## Architecture

### State Management

BLoC / Cubit (`flutter_bloc`). Each UI module has three files:

| File | Role |
|------|------|
| `<module>_state.dart` | Sealed state classes: `Loading`, `Success`, `Error` |
| `<module>_bloc.dart` | Cubit starting in `Loading`, emitting states |
| `<module>_screen.dart` | `@RoutePage()` widget with `BlocBuilder` |

### Dependency Injection

GetIt + Injectable. Modules are annotated with `@module` and registered in `lib/di/`. Two named `Dio` clients are provided:

- `@Named('tmdb')` — TMDB API with Bearer token header
- `@Named('backend')` — Custom backend client

After any DI annotation changes, regenerate with:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Routing

Auto Route with nested tab navigation:

```
MainRoute
├── HomeTab       → HomeRoute → [MoviesListRoute, ReviewsRoute]
├── SearchTab     → SearchRoute
├── SocialTab     → SocialRoute
└── ProfileTab    → ProfileRoute

(modal) NewUserActivityRoute  # slide-bottom transition
(push)  MovieDetailRoute
```

After any route annotation changes, regenerate with `build_runner`.

### Local Storage

ObjectBox for on-device persistence. Entities with `@Entity()` annotations require code generation:
```bash
dart run build_runner build
```

---

## Localization

Strings are defined in ARB files under `ui/common/lib/l10n/` and accessed via `AppLocalizations`.

Supported languages: **English** (`en`), **Spanish** (`es`), **Portuguese** (`pt`)

### Adding a string

1. Add to `app_en.arb`:
   ```json
   "myKey": "My string",
   "@myKey": { "description": "What this string is for" }
   ```
2. Add translated values to `app_es.arb` and `app_pt.arb`.
3. Regenerate:
   ```bash
   flutter gen-l10n
   ```
4. Use in any widget:
   ```dart
   AppLocalizations.of(context)!.myKey
   ```

Never hardcode user-visible strings in widgets. Always import `AppLocalizations` through `package:common/common.dart`.

---

## UI Components

Shared components live in `ui/common/` and are exported from `package:common/common.dart`:

| Component | File |
|-----------|------|
| `MoovieScaffold` | `moovie_scaffold.dart` |
| `MoovieAppBar` | `moovie_app_bar.dart` |
| `MoovieButton` | `moovie_button.dart` |
| `MoovieTextField` | `moovie_text_field.dart` |
| `MoovieDialog` | `moovie_dialog.dart` |
| `MoovieTabBar` | `moovie_tab_bar.dart` |
| `MoovieSwitch` | `moovie_switch.dart` |
| `MoovieSlider` | `moovie_slider.dart` |
| `MoovieIconButton` | `moovie_icon_button.dart` |
| `MoovieActivityIndicator` | `moovie_activity_indicator.dart` |
| `MoovieBottomNavigationBar` | `moovie_bottom_navigation_bar.dart` |

### Theming

Material Design 3 with light and dark variants. Theme configuration is in `ui/common/lib/src/theme/`:

- `moovie_colors.dart` — Color constants
- `moovie_color_scheme.dart` — Color scheme definitions per brightness
- `moovie_text_theme.dart` — Typography scale
- `moovie_theme.dart` — Light/dark `ThemeData` assembly

---

## Development Workflow

### Code generation

Several packages require code generation. Run after any annotation change:

```bash
# All generators (routing, DI, ObjectBox)
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs

# Localization only
flutter gen-l10n
```

### Daily commands

```bash
flutter pub get                                                    # After pubspec changes
dart run build_runner build --delete-conflicting-outputs           # After annotation changes
flutter gen-l10n                                                   # After ARB changes
dart format .                                                      # Format code
bundle exec fastlane lint                                          # Lint
bundle exec fastlane test                                          # Run tests
flutter run -t lib/main_dev.dart                                   # Run dev flavor
```

### Fastlane commands

All fastlane commands must be run with `bundle exec` to use the locked Ruby gems:

```bash
# Setup IDE run configurations (after initial checkout)
bundle exec fastlane setup_ide

# Lint
bundle exec fastlane lint

# Test
bundle exec fastlane test

# Build for a specific flavor
bundle exec fastlane ios build flavor:dev
bundle exec fastlane android build flavor:staging

# Release builds (signing/upload configured later)
bundle exec fastlane ios release flavor:prod
bundle exec fastlane android release flavor:prod
```

See `fastlane/README.md` for detailed documentation.

### Adding a new feature

1. Create `features/<name>/` with `domain/` and `data/` sub-packages.
2. Add path dependencies to the root `pubspec.yaml`.
3. Register use cases and repositories in `lib/di/`.
4. Create the UI module under `ui/<name>/` with the three required files (`_state`, `_bloc`, `_screen`).

To scaffold a UI module from the standard template, use the `/new-ui-module <name>` slash command.

---

## Guidelines

### Code style

- Classes: `PascalCase` · Files/directories: `snake_case` · Variables/functions: `camelCase`
- Prefer `const` constructors wherever possible.
- Use `final` for variables that are not reassigned.
- Avoid `dynamic` — always provide explicit types.
- Use arrow syntax (`=>`) for single-expression functions and methods.
- One class per file.

### Accessibility

- All interactive widgets must have a semantic label (`Tooltip`, `Semantics`, or `MergeSemantics`).
- Minimum touch target: **48×48 dp**.
- Text must meet WCAG AA contrast ratios: **4.5:1** for normal text, **3:1** for large text.
- Never rely on color alone to convey state — always pair with an icon, label, or shape change.
- Icon-only buttons must wrap their `Icon` in a `Tooltip` or use `Semantics(label: ...)`.

### Testing

Mirror the `lib/` structure under `test/features/<name>/`:

```
test/features/<name>/
  data/models/        # Serialization tests
  data/repositories/  # Repository implementation tests
  domain/usecases/    # Use case unit tests
  presentation/       # Widget and Bloc/Cubit tests
```

- Every public use case must have at least one unit test.
- Mock all external dependencies — no real network or storage in unit tests.
- Test file naming: `<source_file>_test.dart`.

---

## Key Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` / `bloc` | State management (BLoC/Cubit) |
| `rxdart` | Reactive streams |
| `dio` | HTTP client |
| `objectbox` | Local database |
| `auto_route` | Declarative routing with code generation |
| `get_it` / `injectable` | Dependency injection |
| `intl` | Localization and date formatting |
| `cached_network_image` | Network image caching |
| `infinite_scroll_pagination` | Paginated list views |

---

## License

Apache License 2.0 — see `LICENSE` for details.
