# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

RP Pay (`rppay`) is a fictional payments app built as a personal Flutter/Dart study project. README and in-code comments are written in Portuguese; match that when editing existing files.

## Commands

```bash
flutter pub get              # install dependencies
flutter run                  # run the app (device/simulator required)
flutter analyze              # static analysis (uses analysis_options.yaml + flutter_lints)
flutter test                 # run all tests
flutter test test/widget_test.dart   # run a single test file
flutter test --plain-name "test name"  # run a single test by name
```

Flutter SDK: 3.44, Dart SDK: `^3.12.0` (see `pubspec.yaml`).

## Tests

Test files under `test/` mirror the `lib/` structure (e.g. `lib/features/home/presentation/cubits/home_cubit.dart` → `test/features/home/presentation/cubits/home_cubit_test.dart`). `test/widget_test.dart` is a smoke test that pumps `App` and verifies navigation from `SplashPage` to `MainNavigationPage`.

Cubits are tested with `bloc_test` (dev dependency) against hand-written fake repositories (implementing the feature's abstract `Repository` interface) rather than a mocking framework — simple enough given each repository has one or two methods. Repositories are tested directly against their simulated/hardcoded data. Follow this pattern for new features: fake the repository, assert emitted state sequences with `blocTest`.

## MCP

This project uses the `dart-flutter` Claude Code plugin (MCP server `plugin:dart-flutter:dart-mcp-server`), installed at the user scope (not per-project config), which exposes tools for analysis, hot reload/restart, LSP, pub, and runtime error inspection. Install/enable it with `claude plugin install dart-flutter@dart-flutter`; verify with `claude mcp list`.

## Architecture

Feature-First organization under `lib/features/`, each feature module structured the same way:

```
features/<feature>/
  presentation/   # depends on domain/
    cubits/       # <Feature>Cubit (state/business logic) + <Feature>State (Equatable, sealed via abstract base class)
    views/        # <Feature>Page (StatelessWidget, wires BlocProvider) + <Feature>View (renders based on state); widgets/ for widgets local to the view
  domain/         # pure Dart, depends on nothing
    entities/     # <Feature>...Entity — plain business data classes (no Flutter types such as IconData)
    repositories/ # abstract <Feature>Repository (the contract)
  data/           # depends on domain/
    models/       # <Feature>...Model extends the entity (where fromJson/toJson will live)
    repositories/ # concrete <Feature>RepositoryImpl (file: <feature>_repository_impl.dart)
```

Features with no business rules or data access (`splash`) only have `presentation/`; features with no screen of their own (`user`) only have `domain/` and `data/`. Cubits, states and widgets import entities from `domain/`, never models from `data/`; the only `presentation/` → `data/` reference is the `<Feature>Page` instantiating the `RepositoryImpl`.

The app root lives in `lib/app/app.dart` (`App`, run by `main.dart`). Shared/global code lives in `lib/core/`: `constants/app_colors.dart` (color palette), `theme/app_theme.dart` (Material 3 `ThemeData`), `widgets/` (reusable widgets like `custom_button.dart`, `custom_drawer.dart`).

Current features: `splash`, `navigation`, `home`, `pix`, `user`.

### State management pattern

Every feature follows the same wiring convention — replicate it exactly for new features:

- A `<Feature>Page` (`StatelessWidget`) creates the `BlocProvider` and instantiates the Cubit with a concrete repository implementation, e.g. `HomeCubit(repository: HomeRepositoryImpl())..loadData()`.
- The `<Feature>View` consumes state via `BlocBuilder`/`BlocListener` and contains no business logic or direct data access.
- Cubits depend on the repository's *abstract* interface, never the concrete implementation (dependency inversion — see the "SOLID principles" section in `README.md`), which is what makes them swappable/mockable in tests.
- States extend an abstract `Equatable` base class per feature (e.g. `HomeState` → `HomeInitialState`, `HomeLoadingState`, `HomeSuccessState`, `HomeErrorState`). Follow this Initial/Loading/Success/Error shape for new features.
- Repositories currently return hardcoded/simulated data with an artificial `Future.delayed` — there is no real backend or persistence layer yet.

### Navigation flow

`main.dart` → `App` (`lib/app/app.dart`, the `MaterialApp` with theme and initial page) → `SplashPage` (runs `SplashCubit.initApp()`, a timed delay) → on `SplashCompletedState`, pushes `MainNavigationPage` (fade transition). `MainNavigationPage` owns a `NavigationCubit` that loads the bottom-bar menus from `NavigationRepository` (simulated API returning JSON) and tracks the selected index. Each menu has a `label`, an `icon` name and a `NavigationMenuType`: `page` (native page, looked up by `route` in `navigationPages`), `webview` (opens `url` with `WebViewPage` from the `webview_page` git package, restricted to `WebViewConstants.allowedHosts` in `lib/core/constants/`) or `drawer` (opens `CustomDrawer` instead of switching tabs). Invalid/unknown menus are dropped by `NavigationMenuModel.fromJson`, and `page` menus whose route isn't registered are dropped by the cubit (`pageRoutes`). `NavigationCubit` also loads the user (`UserRepository`, in parallel with the menus), keeps it in `NavigationSuccessState.user` (the view passes name/account to `CustomDrawer`) and replaces `{user.name}`, `{user.firstName}`, `{user.agency}`, `{user.account}` placeholders in webview urls, url-encoded; a menu with an unknown placeholder is dropped. To expose a new native page or icon to the API, register it in `lib/features/navigation/presentation/views/navigation_registry.dart`. Widget tests that build `MainNavigationPage` must call `FakeWebViewPlatform.install()` (from `package:webview_page/testing.dart`).

### SOLID notes

The "SOLID principles" section in `README.md` documents how each SOLID principle maps onto this codebase (per-feature repository abstractions in `domain/`, Cubit constructor injection, Equatable state hierarchies, etc.) — read it before making architectural changes, since new code is expected to follow the same reasoning.
