import 'package:doctor_app/core/config/app_config.dart';
import 'package:flutter/material.dart';

class Notifier {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Shows a floating snackbar near the top of the screen.
  ///
  /// The animation is intentionally left to [ScaffoldMessenger]: supplying a
  /// custom AnimationController here (as an earlier version did) produced a
  /// controller that was never driven, so the snackbar rendered at zero opacity
  /// and never became visible.
  static void showSnackbar({
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.red,
    int fromBottom = 190,
    required Widget content,
  }) {
    final messenger = messengerKey.currentState;
    if (messenger == null) return;

    messenger.clearSnackBars();

    // Push the toast toward the top of the screen, but never let the margin go
    // negative on short screens (that throws during layout).
    final double bottomMargin = (AppConfig.screenSize.height - fromBottom)
        .clamp(16.0, double.infinity);

    messenger.showSnackBar(
      SnackBar(
        content: content,
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: bottomMargin, left: 15, right: 15),
      ),
    );
  }
}
