/// Central switch for development-only tooling (currently the Alice HTTP
/// inspector).
///
/// Managed entirely from code: [isDevelopment] defaults to Flutter's debug
/// mode, but you can force it to a literal `true`/`false` here (or assign it
/// early in `main()`, before the first network call) to turn dev tooling on or
/// off regardless of build mode.
class AppEnvironment {
  AppEnvironment._();

  /// Master development-mode flag. When true, dev tooling is enabled.
  ///
  /// Examples:
  ///   static bool isDevelopment = true;       // force on (even in release)
  ///   static bool isDevelopment = false;      // force off
  ///   static bool isDevelopment = kDebugMode; // on in debug only
  ///     (requires: import 'package:flutter/foundation.dart';)
  static bool isDevelopment = true;
}
