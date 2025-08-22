import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/core/widgets/circle.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../styles/text_styles.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final OnboardController onboardController = Get.find<OnboardController>();
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
          padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60),
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
                  ShadInput(
                    controller: controller.pinflController,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    decoration: ShadDecoration(
                      border: ShadBorder.all(
                        color: Colors.grey, // default border color
                      ),
                      focusedBorder: ShadBorder.all(
                        color: Colors.grey, // border when focused
                        width: 2,
                        radius: BorderRadius.circular(10),
                      ),
                      errorBorder: ShadBorder.all(
                        color: Colors.red, // border when error
                      ),
                      disableSecondaryBorder: true,
                    ),
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
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    child: Obx(
                      () => PrimaryButton(
                        onTap: () => controller.login(),
                        child: controller.isAuthorization.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.5,
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
