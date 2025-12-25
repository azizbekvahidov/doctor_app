import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/unread_badge.dart';
import 'package:doctor_app/features/add/presentation/add_page.dart';
import 'package:doctor_app/features/chat/presentation/chats_page.dart';
import 'package:doctor_app/features/profile/presentation/profile_page.dart';
import 'package:doctor_app/features/qr/presentation/qr_page.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'contents/main_content.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserController userController = Get.find();

  int index = 0;

  final List<Widget> pages = [
    MainContent(key: const ValueKey("home")),
    ChatsPage(key: const ValueKey("chats")),
    QRPage(key: const ValueKey("qr")),
    AddPage(key: const ValueKey("add")),
    ProfilePage(key: const ValueKey("profile")),
  ];

  @override
  void initState() {
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkSurface : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            );
          },
          child: pages[index],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ).copyWith(bottom: 20),
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(LucideIcons.stethoscope, 0),
            _buildNavItemWithBadge(LucideIcons.messageCircle, 1, 2),
            _buildNavItem(LucideIcons.qrCode, 2),
            _buildNavItem(LucideIcons.filePlus, 3),
            _buildNavItem(LucideIcons.user, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int i) {
    final bool isSelected = i == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedColor = AppColors.primary;
    final unselectedColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return GestureDetector(
      onTap: () => setState(() => index = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          color: isSelected ? selectedColor : unselectedColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildNavItemWithBadge(IconData icon, int i, int badgeCount) {
    final bool isSelected = i == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedColor = AppColors.primary;
    final unselectedColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return GestureDetector(
      onTap: () => setState(() => index = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 24,
            ),
            if (badgeCount > 0)
              Positioned(
                right: -8,
                top: -8,
                child: UnreadBadge(
                  count: badgeCount,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
