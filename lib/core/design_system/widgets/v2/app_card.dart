import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text.dart';
import '../../styles/dimens.dart';

/// v2 surface card (`VCard`).
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding = 18, this.onTap});

  final Widget child;
  final double padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.cardR,
        boxShadow: AppShadows.card,
        border: Border.all(color: const Color(0xB3ECE9E4)),
      ),
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadii.cardR,
        onTap: onTap,
        child: card,
      ),
    );
  }
}

/// v2 circular avatar (`VAvatar`). Shows [imageUrl] when provided, otherwise
/// [initials] on a tinted background.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.initials,
    this.imageUrl,
    this.size = 48,
    this.tone = AppColors.primaryTint,
    this.color = AppColors.primary,
  });

  final String? initials;
  final String? imageUrl;
  final double size;
  final Color tone;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
      child: (imageUrl != null && imageUrl!.isNotEmpty)
          ? Image.network(
              imageUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _initials(),
            )
          : _initials(),
    );
  }

  Widget _initials() => Text(
    initials ?? '',
    style: AppText.title.copyWith(fontSize: size * 0.36, color: color),
  );
}

enum AppBadgeTone { primary, soft, success, warning, danger, neutral }

/// v2 status pill (`VBadge`).
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.primary,
    this.icon,
  });

  final String label;
  final AppBadgeTone tone;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _tone(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: AppRadii.pillR),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 13),
              child: icon!,
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: AppText.caption.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color) _tone(AppBadgeTone t) {
    switch (t) {
      case AppBadgeTone.primary:
        return (AppColors.primary, Colors.white);
      case AppBadgeTone.soft:
        return (AppColors.primaryTint, AppColors.primary);
      case AppBadgeTone.success:
        return (AppColors.successTint, AppColors.success);
      case AppBadgeTone.warning:
        return (AppColors.warningTint, const Color(0xFFB97B22));
      case AppBadgeTone.danger:
        return (AppColors.dangerTint, AppColors.danger);
      case AppBadgeTone.neutral:
        return (AppColors.surface2, AppColors.ink2);
    }
  }
}

/// v2 list row (`VListRow`).
class AppListRow extends StatelessWidget {
  const AppListRow({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 2),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 13)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body.copyWith(fontWeight: FontWeight.w700),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.caption.copyWith(color: AppColors.ink3),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
    if (onTap == null) return row;
    return InkWell(onTap: onTap, child: row);
  }
}
