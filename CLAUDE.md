# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`doctor_app` is the Flutter client for the "I Need Doctor" telemedicine platform. It talks to the sibling backend at `../i-need-doctor-api` (base URL hardcoded in `lib/core/constants/api_constants.dart` as `https://doctor-api.smartmobile.uz`). Includes MyID (Uzbekistan e-ID face-verification) integration via the `myid` package.

## Commands

```bash
flutter pub get              # install dependencies
flutter run                  # run on connected device/emulator
flutter analyze              # static analysis (uses analysis_options.yaml -> flutter_lints)
flutter test                 # run tests
flutter test test/widget_test.dart   # run a single test file
flutter build apk            # Android build
flutter build ios            # iOS build
```

There is no code generation step (no `build_runner`/`freezed`/`json_serializable`) — models are hand-written with manual `fromRawJson`/`toRawJson`.

Note: `test/widget_test.dart` is still the default Flutter counter-app template and does not reflect the actual app UI — treat it as stale rather than a real regression signal.

## Architecture

State management, dependency injection, and navigation are all handled by **GetX** (`get` package) — there is no Riverpod/Bloc/Provider and no go_router.

- `lib/main.dart` — minimal entry point; just initializes bindings and runs `MyApp()`.
- `lib/app/my_app.dart` — wraps the app in `ShadApp.custom` (shadcn_ui theming) around `GetMaterialApp`, with `initialBinding: AppBindings()`, GetX-based translations, and `getPages: AppPages.pages`.
- `lib/core/` — shared infrastructure:
  - `bindings/app_bindings.dart` — global DI registrations (`Get.lazyPut(..., fenix: true)`).
  - `navigation/routes.dart` + `navigation/pages.dart` — route name constants and the `AppPages.pages` list of `GetPage`s (each with its own `binding:`).
  - `services/dio_service.dart` — builds the shared `Dio` client; an `InterceptorsWrapper` reads the auth token from `SecureStorageService` and injects `Authorization: Bearer <token>` on every request. No refresh/retry logic.
  - `services/secure_storage_service.dart` — token/user/lang persistence via `flutter_secure_storage`.
  - `constants/api_constants.dart` — hardcoded base URL and all endpoint paths.
  - `design_system/` — colors, text styles, reusable buttons/widgets.
  - `languages.dart` — hand-written GetX `Translations` map (no `.arb`/l10n tooling).
  - `utils/log_helper.dart` — logging via `talker`; `utils/notifier.dart` — snackbars.
- `lib/features/<feature>/` — one directory per feature (`auth`, `chat`, `issue_detail`, `main`, `onboard`, `profile`, `shared`), each internally split as:
  - `data/repository/` — repository implementations wrapping the shared `Dio` client.
  - `domain/{models,repository}` — models and repository interfaces.
  - `presentations/{pages,controller,widgets}` — `GetxController` subclasses (e.g. `AuthController`) hold reactive `.obs` state and are injected via a per-feature `bindings.dart` (note: `features/auth/bindins.dart` is a typo'd filename, not a mistake to "fix" blindly — check for references before renaming).

When adding a new feature, follow the existing `data/domain/presentations` + `bindings.dart` shape and register the binding in the relevant `AppPages` entry (or `AppBindings` if it must be available globally).

There is no `.env`/`flutter_dotenv`/`--dart-define` setup — all config (API base URL, etc.) is hardcoded in `lib/core/constants/`. If you need per-environment builds, that mechanism doesn't exist yet.
