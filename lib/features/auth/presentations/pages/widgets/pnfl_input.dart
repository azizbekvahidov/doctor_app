import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PnflInput extends StatelessWidget {
  const PnflInput({
    super.key,
    required this.controller,
    required this.maskFormatter,
  });

  final AuthController controller;
  final MaskTextInputFormatter maskFormatter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasError = controller.isTextFieldEmpty.value;
      return AppInput(
        controller: controller.pinflController,
        keyboardType: TextInputType.number,
        inputFormatters: [maskFormatter],
        hint: "12345678901234",
        errorText: hasError ? 'valid_pnfl'.tr : null,
      );
    });
  }
}
