import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/avatar_with_status.dart';
import 'package:doctor_app/core/design_system/widgets/unread_badge.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final AuthController authController = Get.find<AuthController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (userController.user.value == null) return const SizedBox.shrink();
            final user = userController.user.value;
            return GestureDetector(
              onTap: () => authController.logout(),
              child: Row(
                children: [
                  AvatarWithStatus(
                    imageUrl: user!.avatar?.url,
                    size: 55,
                    name: user.firstName,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'hi_doctor'.tr} ${user.firstName ?? ''},',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'how_are_you'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          const Spacer(),
          // Notification bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.bell,
                  color: AppColors.accentPink,
                  size: 24,
                ),
              ),
              const Positioned(
                right: -4,
                top: -4,
                child: UnreadBadge(
                  count: 1,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
