import 'package:doctor_app/core/config/app_config.dart';
import 'package:flutter/material.dart';

class Notifier {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar({
    Duration duration = const Duration(milliseconds: 600),
    Color backgroundColor = Colors.red,
    int fromBottom = 190,
    required Widget content,
  }) async {
    messengerKey.currentState?.clearSnackBars();
    final snackBar = SnackBar(
      content: content,
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: AppConfig.screenSize.height - fromBottom,
        left: 15,
        right: 15,
      ),
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: messengerKey.currentState!,
          duration: const Duration(milliseconds: 500),
        ),
        curve: Curves.easeInOut,
      ),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
