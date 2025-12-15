import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({super.key, this.onClick});
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: onClick,
      child: SvgPicture.asset(AssetFinder.icon('add_work')),
    );
  }
}
