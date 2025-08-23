import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/design_system/styles/text_styles.dart';
import 'widgets/pnfl_input.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final OnboardController onboardController = Get.find<OnboardController>();

  final maskFormatter = MaskTextInputFormatter(
    mask: '####-####-####-##',
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
                  icon: Icon(Icons.arrow_back),
                )
              : SizedBox.shrink(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ).copyWith(top: 60, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Circle(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JSHSHIR",
                    style: WorkSansStyle.headline5.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  PnflInput(
                    controller: controller,
                    maskFormatter: maskFormatter,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Align(
                  //   child: Text("Lorem ipsum"),
                  //   alignment: Alignment.center,
                  // ),
                  SizedBox(height: 15),
                  Obx(
                    () => PrimaryButton(
                      onTap: controller.isAuthorization.value
                          ? null
                          : () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.login();
                            },
                      child: controller.isAuthorization.value
                          ? Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              ),
                            )
                          : Text(
                              "login".tr,
                              style: WorkSansStyle.labelLarge.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
