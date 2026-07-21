import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ).copyWith(top: 12, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "I Need Doctor",
                style: AppText.display.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              Text(
                "Tilni tanlang · Выберите язык",
                style: AppText.body.copyWith(color: AppColors.ink2),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => LanguageSelectButton(
                      lang: "Uz",
                      onTap: () => controller.setLang("uz"),
                      isSelected: controller.selectedLang.value == "uz",
                    ),
                  ),
                  const SizedBox(width: 30),
                  Obx(
                    () => LanguageSelectButton(
                      lang: "Ru",
                      onTap: () => controller.setLang("ru"),
                      isSelected: controller.selectedLang.value == "ru",
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                label: "next".tr,
                block: true,
                onPressed: () {
                  if (controller.selectedLang.value == null) {
                    Notifier.showSnackbar(
                      duration: Durations.extralong1,
                      content: Text("Iltimos tilni tanlang!", style: AppText.body),
                    );
                    return;
                  }
                  Get.toNamed(Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
