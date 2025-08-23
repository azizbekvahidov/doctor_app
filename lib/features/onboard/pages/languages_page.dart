import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/lang_button.dart';

class LanguagesPage extends GetView<OnboardController> {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => LangButton(
                      lang: "Uz",
                      onTap: () => controller.setLang("uz"),
                      isSelected: controller.selectedLang.value == "uz",
                    ),
                  ),
                  SizedBox(width: 30),
                  Obx(
                    () => LangButton(
                      lang: "Ru",
                      onTap: () => controller.setLang("ru"),
                      isSelected: controller.selectedLang.value == "ru",
                    ),
                  ),
                ],
              ),
              Obx(() {
                return PrimaryButton(
                  onTap: () => Get.toNamed(Routes.login),
                  height: 50,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: Text(
                      "next".tr,
                      key: ValueKey(
                        controller.selectedLang.value,
                      ), // important!
                      style: WorkSansStyle.labelLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
