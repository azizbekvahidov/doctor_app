import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'widgets/pnfl_input.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final OnboardController onboardController = Get.find<OnboardController>();

  final maskFormatter = MaskTextInputFormatter(
    mask: '##############',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => !onboardController.isLangSelected.value
              ? IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_rounded),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(top: 20, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("login".tr, style: AppText.display),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JSHSHIR",
                    style: AppText.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PnflInput(controller: controller, maskFormatter: maskFormatter),
                ],
              ),
              const Spacer(),
              Obx(
                () => AppButton(
                  label: "login".tr,
                  block: true,
                  loading: controller.isAuthorization.value,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.login();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
