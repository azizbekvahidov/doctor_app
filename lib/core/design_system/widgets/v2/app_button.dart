import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/app_colors.dart';
import '../../styles/dimens.dart';

enum AppButtonKind { primary, secondary, ghost, danger, success }

enum AppButtonSize { lg, sm }

/// v2 pill button. Mirrors the design system's `VButton`.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.kind = AppButtonKind.primary,
    this.size = AppButtonSize.lg,
    this.block = false,
    this.icon,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;
  final AppButtonSize size;
  final bool block;
  final Widget? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final bool isLg = size == AppButtonSize.lg;
    final double height = isLg ? 54 : 40;
    final double fontSize = isLg ? 16 : 14;
    final EdgeInsets padding = EdgeInsets.symmetric(horizontal: isLg ? 26 : 18);

    final _KindStyle style = _styleFor(kind);
    final bool disabled = onPressed == null || loading;

    return Opacity(
      opacity: disabled && !loading ? 0.6 : 1,
      child: Material(
        color: style.background,
        borderRadius: AppRadii.pillR,
        child: InkWell(
          borderRadius: AppRadii.pillR,
          onTap: disabled ? null : onPressed,
          child: Container(
            height: height,
            width: block ? double.infinity : null,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: AppRadii.pillR,
              border: style.border,
              boxShadow: kind == AppButtonKind.primary
                  ? const [
                      BoxShadow(
                        color: Color(0x8C2D5BE3),
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        spreadRadius: -10,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(style.foreground),
                    ),
                  )
                else ...[
                  if (icon != null) ...[
                    IconTheme(
                      data: IconThemeData(color: style.foreground, size: 20),
                      child: icon!,
                    ),
                    const SizedBox(width: 9),
                  ],
                  Text(
                    label,
                    style: GoogleFonts.manrope(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.1,
                      color: style.foreground,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  _KindStyle _styleFor(AppButtonKind k) {
    switch (k) {
      case AppButtonKind.primary:
        return const _KindStyle(AppColors.primary, Colors.white);
      case AppButtonKind.secondary:
        return const _KindStyle(AppColors.primaryTint, AppColors.primary);
      case AppButtonKind.ghost:
        return _KindStyle(
          Colors.transparent,
          AppColors.ink2,
          border: Border.all(color: AppColors.border, width: 1.5),
        );
      case AppButtonKind.danger:
        return const _KindStyle(AppColors.danger, Colors.white);
      case AppButtonKind.success:
        return const _KindStyle(AppColors.success, Colors.white);
    }
  }
}

class _KindStyle {
  const _KindStyle(this.background, this.foreground, {this.border});
  final Color background;
  final Color foreground;
  final BoxBorder? border;
}
