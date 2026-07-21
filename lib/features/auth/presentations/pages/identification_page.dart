import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdentificationPage extends GetView<AuthController> {
  const IdentificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ).copyWith(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.face_retouching_natural_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'identification'.tr,
                textAlign: TextAlign.center,
                style: AppText.title,
              ),
              const SizedBox(height: 8),
              Text(
                'identification_info'.tr,
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: AppColors.ink2),
              ),
              const Spacer(),
              Obx(
                () => AppButton(
                  label: "identification".tr,
                  block: true,
                  loading: controller.isAuthorization.value,
                  icon: const Icon(Icons.camera_alt_rounded),
                  onPressed: () => controller.verifyAndLogin(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
