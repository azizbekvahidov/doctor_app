import 'dart:io';

import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final CabinetController cabinetController = Get.find<CabinetController>();
  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text("profile".tr, style: AppText.title),
              const SizedBox(height: 24),
              _avatar(),
              const SizedBox(height: 14),
              Obx(() {
                final user = userController.user.value;
                final name = user == null
                    ? ''
                    : "${user.firstName ?? ''} ${user.lastName ?? ''}".trim();
                return Text(
                  name,
                  textAlign: TextAlign.center,
                  style: AppText.title.copyWith(fontSize: 22),
                );
              }),
              const SizedBox(height: 4),
              Obx(
                () => Text(
                  userController.user.value?.profession?.name?.ru ??
                      "Doctor",
                  style: AppText.caption,
                ),
              ),
              const SizedBox(height: 28),
              AppCard(
                padding: 6,
                child: Column(
                  children: [
                    AppListRow(
                      onTap: () => Get.toNamed(Routes.documents),
                      leading: _rowIcon(LucideIcons.fileText),
                      title: "documents".tr,
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.ink3,
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    AppListRow(
                      onTap: () => Get.toNamed(Routes.workInfo),
                      leading: _rowIcon(LucideIcons.calendar),
                      title: "work_and_schedule".tr,
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.ink3,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                label: "logout".tr,
                block: true,
                kind: AppButtonKind.ghost,
                icon: const Icon(Icons.logout_rounded),
                onPressed: () => authController.logout(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowIcon(IconData icon) => Container(
    width: 42,
    height: 42,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.primaryTint,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon, size: 20, color: AppColors.primary),
  );

  Widget _avatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Obx(() {
          if (cabinetController.isAvatarLoading.value) {
            return const SizedBox(
              width: 96,
              height: 96,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final localPath = cabinetController.selectedAvatarPath.value;
          if (localPath.isNotEmpty) {
            return ClipOval(
              child: Image.file(
                File(localPath),
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            );
          }
          return AppAvatar(
            size: 96,
            imageUrl: userController.user.value?.avatar?.url,
            initials: _initials(),
          );
        }),
        Obx(
          () => cabinetController.isAvatarLoading.value
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () async => cabinetController.selectAvatarFile(),
                  child: Container(
                    width: 34,
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bg, width: 3),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  String _initials() {
    final user = userController.user.value;
    if (user == null) return '';
    final f = user.firstName ?? '';
    final l = user.lastName ?? '';
    return [
      if (f.isNotEmpty) f[0],
      if (l.isNotEmpty) l[0],
    ].join().toUpperCase();
  }
}
