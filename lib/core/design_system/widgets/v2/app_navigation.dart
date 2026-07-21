import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../styles/dimens.dart';

/// v2 screen header (`VTopBar`). A plain widget (not an AppBar) — place it at the
/// top of a Column inside a Scaffold body.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = true,
    this.onBack,
    this.action,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
      child: Row(
        children: [
          if (showBack) ...[
            GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 18,
                  color: AppColors.ink,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppText.title.copyWith(fontSize: 18)),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppText.caption.copyWith(
                      fontSize: 12.5,
                      color: AppColors.ink3,
                    ),
                  ),
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class AppTabItem {
  const AppTabItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

/// v2 floating dark pill bottom navigation (`VTabBar`).
class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppTabItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xF0191A1E),
        borderRadius: AppRadii.pillR,
        boxShadow: AppShadows.float,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < items.length; i++)
            _tab(items[i], i == currentIndex, () => onTap(i)),
        ],
      ),
    );
  }

  Widget _tab(AppTabItem item, bool active, VoidCallback onTap) {
    final Color fg = active ? Colors.white : Colors.white.withValues(alpha: 0.45);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: active ? Colors.white.withValues(alpha: 0.14) : Colors.transparent,
          borderRadius: AppRadii.pillR,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 20, color: fg),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: AppText.micro.copyWith(
                fontSize: 10,
                letterSpacing: 0,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
