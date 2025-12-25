# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Development Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Build for release
flutter build apk          # Android
flutter build ios          # iOS

# Run static analysis
flutter analyze

# Run tests
flutter test
flutter test test/widget_test.dart  # Single test file
```

## Architecture Overview

This is a Flutter doctor/medical app using **GetX** for state management and navigation, **shadcn_ui** for UI components, and **Dio** for HTTP requests.

### Project Structure

```
lib/
├── app/my_app.dart           # App entry with ShadApp + GetMaterialApp
├── core/
│   ├── bindings/             # GetX dependency injection
│   ├── config/               # App configuration (screen size, padding)
│   ├── constants/            # API endpoints
│   ├── design_system/        # Reusable UI (AppColors, TextStyles, buttons)
│   ├── navigation/           # Routes and page definitions
│   ├── services/             # DioService, SecureStorageService
│   ├── utils/                # Formatters, logging, notifications
│   ├── wrappers/             # Result sealed class (Success/Error)
│   └── languages.dart        # i18n translations (uz, ru)
├── features/
│   ├── auth/                 # Login, registration, MyID identification
│   ├── chat/                 # Patient-doctor messaging
│   ├── issue_detail/         # Patient issue details view
│   ├── main/                 # Home, archive, announcements
│   ├── onboard/              # Language selection, onboarding
│   ├── profile/              # Documents, work info, schedules, clinics
│   └── shared/               # Shared controllers and repositories (IssueController, UserController)
└── main.dart
```

### Key Patterns

**Feature Structure**: Each feature follows domain-driven structure:
- `domain/` - Models and repository interfaces
- `data/` - Repository implementations
- `presentation/` - Controllers, pages, widgets

**Dependency Injection**: Uses GetX bindings. Global dependencies in `core/bindings/app_bindings.dart`, feature-specific bindings in each feature's `bindings.dart`.

**Navigation**: GetX routing defined in `core/navigation/pages.dart` with routes in `core/navigation/routes.dart`. Initial route is `/onboard`.

**HTTP**: `DioService.createDio()` factory method with automatic Bearer token injection from `SecureStorageService`. Base URL in `ApiConstants`.

**Result Pattern**: Use `Result<T>` sealed class from `core/wrappers/result.dart` for error handling:
```dart
sealed class Result<T>
class Success<T> extends Result<T>
class Error<T> extends Result<T>
```

**Shared Controllers**: `features/shared/controllers/` contains cross-feature controllers like `IssueController` (manages issues, chat, pagination) and `UserController`.

**Localization**: Supports Uzbek (`uz`) and Russian (`ru`). Translations in `core/languages.dart`. Access with `.tr` extension on translation keys.

### UI Components

- Primary color: `#3A00E5`
- Font family: WorkSans (100-900 weights)
- Design system widgets in `core/design_system/widgets/`
- Uses shadcn_ui components wrapped in ShadApp
