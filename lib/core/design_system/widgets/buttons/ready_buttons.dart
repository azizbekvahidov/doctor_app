import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buttons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onClick});

  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onTap: onClick,
      width: double.infinity,
      child: Text(
        "save".tr,
        style: WorkSansStyle.labelLarge.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
