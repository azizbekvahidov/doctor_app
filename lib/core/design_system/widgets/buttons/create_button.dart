import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({super.key, this.onClick});
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      onTap: onClick,
      child: SvgPicture.asset(
        AssetFinder.icon('add_work'),
        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        width: 28,
        height: 28,
      ),
    );
  }
}
