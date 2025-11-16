import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../styles/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,

    this.width,
    this.child,
    this.onTap,
    this.bgColor = AppColors.primary,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  });

  final double? width;
  final Widget? child;
  final Function()? onTap;
  final Color bgColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      decoration: ShadDecoration(
        // border: ShadBorder(radius: borderRadius),
        gradient: LinearGradient(
          colors: [AppColors.bottomItemColor, AppColors.primary],
        ),
      ),
      backgroundColor: bgColor,
      onPressed: onTap,

      width: width,
      child: child,
    );
  }
}
