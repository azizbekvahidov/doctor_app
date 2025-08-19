import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../styles/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.height = 56,
    this.width,
    this.child,
    this.onTap,
    this.bgColor = AppColors.primary,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(16),
    ), // ✅ BorderRadius not Radius
  });
  final double? height;
  final double? width;
  final Widget? child;
  final Function()? onTap;
  final Color bgColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      decoration: ShadDecoration(border: ShadBorder(radius: borderRadius)),
      backgroundColor: bgColor,
      onPressed: onTap,
      height: height,
      width: width,
      child: child,
    );
  }
}
