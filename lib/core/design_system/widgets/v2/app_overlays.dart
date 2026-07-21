import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../styles/dimens.dart';

/// v2 bottom sheet content (`VSheet`) with a grab handle.
class AppSheet extends StatelessWidget {
  const AppSheet({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 26),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheet)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            if (title != null) ...[
              Text(title!, style: AppText.title.copyWith(fontSize: 18)),
              const SizedBox(height: 16),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

/// Presents [child] wrapped in an [AppSheet] as a modal bottom sheet.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  String? title,
  required Widget child,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => AppSheet(title: title, child: child),
  );
}

enum AppToastTone { success, danger, primary }

/// v2 dark pill toast (`VToast`).
class AppToast extends StatelessWidget {
  const AppToast({
    super.key,
    required this.message,
    this.tone = AppToastTone.success,
    this.icon = Icons.check_circle_rounded,
  });

  final String message;
  final AppToastTone tone;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xF0191A1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.float,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 19, color: _toneColor),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              message,
              style: AppText.caption.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color get _toneColor {
    switch (tone) {
      case AppToastTone.success:
        return AppColors.success;
      case AppToastTone.danger:
        return AppColors.danger;
      case AppToastTone.primary:
        return AppColors.primary;
    }
  }
}
