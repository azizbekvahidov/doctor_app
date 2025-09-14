import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({super.key, this.onClick});
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      child: SvgPicture.asset(
        AssetFinder.icon('add_work'),
        color: AppColors.primary,
        width: 28,
        height: 28,
      ),
      onTap: onClick,
    );
  }
}
