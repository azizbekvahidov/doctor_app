import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';


class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onClick, this.isLoading = false});

  final Function()? onClick;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      width: double.infinity,
      backgroundColor: AppColors.primary,
      onPressed: isLoading ? null : onClick,
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              "save".tr,
              style: WorkSansStyle.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
    );
  }
}
