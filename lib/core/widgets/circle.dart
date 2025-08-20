import 'package:doctor_app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({
    super.key,
    this.child,
    this.width = 100,
    this.height = 100,
    this.bgColor = Colors.grey,
    this.border = const Border.fromBorderSide(
      BorderSide(color: AppColors.grey, width: 3),
    ),
  });
  final Widget? child;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,

        border: border,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
