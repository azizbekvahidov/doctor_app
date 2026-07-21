import 'package:alice/alice.dart';
import 'package:alice/model/alice_configuration.dart';
import 'package:alice_dio/alice_dio_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../config/app_environment.dart';

/// Wraps the Alice HTTP inspector.
///
/// Active only when [AppEnvironment.isDevelopment] is true; in production every
/// entry point is a no-op, so no interceptor, notification, or inspector is
/// ever wired in. Everything is lazily created the first time it is used.
class AliceService {
  AliceService._();

  /// Navigator key Alice uses to open its inspector. Attach it to the app's
  /// [WidgetsApp]/`GetMaterialApp` via `navigatorKey`.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Alice? _alice;
  static AliceDioAdapter? _dioAdapter;

  /// Whether dev tooling is currently enabled.
  static bool get isEnabled => AppEnvironment.isDevelopment;

  /// Notifications and shake-to-open only work on mobile. On desktop the
  /// underlying flutter_local_notifications plugin throws "Windows settings
  /// must be set when targeting Windows platform" and then floods every request
  /// with "must be initialized before use", which breaks rendering. The
  /// floating dev button covers desktop instead.
  static bool get _isMobile =>
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  static Alice? get _instance {
    if (!isEnabled) return null;
    return _alice ??= Alice(
      configuration: AliceConfiguration(
        navigatorKey: navigatorKey,
        showNotification: _isMobile, // tap the notification to open it
        showInspectorOnShake: _isMobile, // shake a physical device to open it
      ),
    );
  }

  /// Dio interceptor that feeds requests/responses into Alice. Returns null
  /// when dev mode is off, so callers can skip adding it.
  static Interceptor? get dioInterceptor {
    if (!isEnabled) return null;
    if (_dioAdapter != null) return _dioAdapter;
    final adapter = AliceDioAdapter();
    _instance!.addAdapter(adapter);
    return _dioAdapter = adapter;
  }

  /// Opens the inspector screen programmatically (e.g. from a hidden dev
  /// gesture). No-op when dev mode is off.
  static void showInspector() => _instance?.showInspector();
}
