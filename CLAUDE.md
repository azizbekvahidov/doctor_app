# CLAUDE.md - AI Assistant Guide for Doctor App

This document provides comprehensive guidance for AI assistants working with this Flutter mobile application for healthcare professionals.

## Project Overview

**Doctor App** is a cross-platform mobile application for doctor registration and profile management. Built with Flutter 3.9.0+, it targets iOS, Android, Web, and Desktop platforms.

**Primary Purpose**: Healthcare professional registration system with biometric identification, profile management, and patient interaction features.

**API Backend**: `https://doctor-api.smartmobile.uz`

## Technology Stack

| Category | Technology | Version |
|----------|------------|---------|
| Framework | Flutter | ^3.9.0 |
| Language | Dart | SDK compatible |
| State Management | GetX | 4.7.2 |
| UI Components | shadcn_ui | 0.28.5 |
| HTTP Client | Dio | 5.9.0 |
| Secure Storage | flutter_secure_storage | 9.2.4 |
| Biometric Auth | myid | 1.3.9 |
| Internationalization | intl | 0.20.2 |
| Logging | talker | 5.0.0 |

## Directory Structure

```
lib/
├── main.dart                    # Entry point
├── app/
│   └── my_app.dart              # Root app configuration (ShadApp + GetMaterialApp)
├── core/                        # Shared infrastructure
│   ├── bindings/                # Global dependency injection
│   ├── config/                  # Screen size, padding configs
│   ├── constants/               # API endpoints
│   ├── design_system/           # Colors, typography, reusable widgets
│   ├── enums/                   # App-wide enums
│   ├── pages/                   # Route definitions
│   ├── services/                # DioService, SecureStorageService
│   └── utils/                   # Logging, notifications, formatters
├── languages.dart               # i18n translations (Uzbek, Russian)
└── features/                    # Feature modules
    ├── auth/                    # Authentication (login, register, identification)
    ├── main/                    # Main dashboard
    ├── onboard/                 # Onboarding flow
    ├── profile/                 # Doctor profile management
    └── detail/                  # Patient details
```

## Architecture Patterns

### GetX Pattern
This project uses **GetX** for state management, routing, and dependency injection:

```dart
// Controller example
class AuthController extends GetxController {
  var isLoading = false.obs;           // Reactive variable
  Rxn<User> user = Rxn(null);          // Nullable reactive

  void login() async {
    isLoading.value = true;
    // ...
  }
}

// UI binding with Obx
Obx(() => controller.isLoading.value
  ? CircularProgressIndicator()
  : LoginButton())
```

### Feature-First Structure
Each feature follows clean architecture layers:
- **domain/**: Models and abstract repositories
- **data/**: Repository implementations
- **presentations/**: Pages, controllers, and widgets

### Bindings Pattern
Each feature has a `bindings.dart` file for dependency injection:

```dart
class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(repository: AuthRepositoryIml()), fenix: true);
  }
}
```

## Key Files & Conventions

### Routes
Defined in `lib/core/pages/routes.dart`:
```
/onboard    /lang           /login          /identification
/register   /main           /detail         /documents
/work-info  /create-work-schedule          /create-work-place
```

### API Endpoints
Defined in `lib/core/constants/api_constants.dart`:
- Authentication: `/api/egov/auth`, `/api/egov/logout`, `/api/egov/get-token`
- Doctor: `/api/doctor/register`, `/api/doctor/schedule`
- Lists: `/api/list/clinic`, `/api/list/region`, `/api/list/degree`

### Design System
Located in `lib/core/design_system/`:
- **Colors**: `AppColors` class with primary purple (#3A00E5)
- **Typography**: `TextStyles` using WorkSans font family
- **Widgets**: `PrimaryButton`, `TopBar`, custom text fields

### Internationalization
Translations in `lib/languages.dart` with keys for Uzbek (uz_UZ) and Russian (ru_RU):
```dart
'login'.tr  // Usage in code
```

## Development Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d macos           # macOS
flutter run -d ios             # iOS simulator

# Analyze code
flutter analyze

# Run tests
flutter test

# Build release
flutter build apk              # Android
flutter build ios              # iOS
flutter build web              # Web
```

## Code Style Guidelines

### Naming Conventions
- **Files**: snake_case (`auth_controller.dart`)
- **Classes**: PascalCase (`AuthController`)
- **Variables/Methods**: camelCase (`isLoading`, `getUserData()`)
- **Constants**: camelCase or SCREAMING_SNAKE_CASE for constants

### GetX Conventions
- Controllers extend `GetxController`
- Pages extend `GetView<ControllerType>` or `StatelessWidget`
- Use `Obx(() => widget)` for reactive rebuilds
- Use `Get.find<T>()` to retrieve dependencies
- Use `fenix: true` in `lazyPut` for controllers that should be recreated

### Widget Structure
```dart
class SomePage extends GetView<SomeController> {
  const SomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => // reactive content),
    );
  }
}
```

### Error Handling
- Use try-catch in repository methods
- Log errors with `LogHelper.error()` or `LogHelper.exception()`
- Show user feedback with `Notifier.showSnackbar()`

## Important Services

### DioService (Singleton)
HTTP client with automatic Bearer token injection:
```dart
final response = await DioService().dio.post(endpoint, data: body);
```

### SecureStorageService
For sensitive data storage (tokens, user credentials):
```dart
await SecureStorageService().write(key: 'token', value: token);
final token = await SecureStorageService().read(key: 'token');
```

### LogHelper
Logging wrapper using Talker:
```dart
LogHelper.info("Message");
LogHelper.error("Error message");
LogHelper.exception(error, stackTrace);
```

## Common Patterns

### Creating a New Feature
1. Create feature folder in `lib/features/`
2. Add domain models in `domain/models/`
3. Create abstract repository in `domain/repository/`
4. Implement repository in `data/repository/`
5. Create controller in `presentations/controller/`
6. Create pages in `presentations/pages/`
7. Add bindings in feature root
8. Register routes in `lib/core/pages/pages.dart`

### Adding a New API Endpoint
1. Add constant to `lib/core/constants/api_constants.dart`
2. Create/update repository method
3. Call from controller

### Adding Translations
1. Add keys to `lib/languages.dart` in both `uz_UZ` and `ru_RU` maps
2. Use with `.tr` extension: `'key_name'.tr`

## Testing

Current testing is minimal with basic widget tests in `test/widget_test.dart`.

When adding tests:
- Unit tests for repositories and controllers
- Widget tests for UI components
- Integration tests for user flows

## Assets

- **Icons**: SVG files in `assets/icons/`
- **Fonts**: WorkSans family (weights 100-900) in `assets/fonts/WorkSans/`

## Platform-Specific Notes

### Android
- Permissions: INTERNET, READ_MEDIA_IMAGES, READ_EXTERNAL_STORAGE
- Configuration in `android/app/src/main/AndroidManifest.xml`

### iOS
- Configuration in `ios/Runner/Info.plist`
- Swift bridging header configured

## Troubleshooting

### Common Issues
1. **Dependency not found**: Run `flutter pub get`
2. **Build errors**: Run `flutter clean && flutter pub get`
3. **iOS pod issues**: Run `cd ios && pod install --repo-update`
4. **GetX controller not found**: Check bindings are registered in route

### Useful Debug Commands
```bash
flutter doctor         # Check environment
flutter pub outdated   # Check outdated packages
flutter analyze        # Static analysis
```

## Notes for AI Assistants

1. **Always use GetX patterns** - Don't introduce other state management solutions
2. **Follow feature-first structure** - Keep related code together
3. **Use existing design system** - Reuse `AppColors`, `TextStyles`, existing widgets
4. **Maintain i18n** - Add translations for any new user-facing strings
5. **Use DioService** - Don't create new HTTP client instances
6. **Error handling** - Log errors and show user feedback
7. **Secure storage** - Use `SecureStorageService` for sensitive data
8. **Naming conventions** - Match existing file and class naming patterns
