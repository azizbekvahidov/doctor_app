import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              final user = userController.user.value;
              if (user == null) return const SizedBox.shrink();
              final first = user.firstName ?? '';
              final last = user.lastName ?? '';
              final initials = [
                if (first.isNotEmpty) first[0],
                if (last.isNotEmpty) last[0],
              ].join().toUpperCase();
              return Row(
                children: [
                  AppAvatar(
                    size: 52,
                    initials: initials,
                    imageUrl: user.avatar?.url,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Salom 👋", style: AppText.caption),
                        Text(
                          "$first $last".trim(),
                          style: AppText.title.copyWith(fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(width: 8),
          _NotificationButton(),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.ink,
              size: 22,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bg, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
