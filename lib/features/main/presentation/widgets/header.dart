import 'package:doctor_app/core/enums/contents.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/main/presentation/controller/main_page_controller.dart';

import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Header extends StatelessWidget {
  Header({super.key});

  final AuthController authController = Get.find<AuthController>();

  final MainPageController mainPageController = Get.find<MainPageController>();

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (userController.user.value == null) return SizedBox.shrink();
            final user = userController.user.value;
            return GestureDetector(
              onTap: () => authController.logout(),
              child: Row(
                children: [
                  Circle(
                    height: 70,
                    width: 70,
                    child: Image.network(
                      userController.user.value!.avatar!.url ??
                          "https://img.freepik.com/free-photo/female-doctor-hospital-with-stethoscope_23-2148827774.jpg?semt=ais_hybrid&w=740&q=80",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user!.firstName!, style: WorkSansStyle.titleLarge),
                      Text(user.lastName!, style: WorkSansStyle.titleLarge),
                    ],
                  ),
                ],
              ),
            );
          }),
          Spacer(),
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: 65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () => mainPageController.setContent(Contents.archive),
                  borderRadius: BorderRadius.circular(50),
                  child: Circle(
                    bgColor: AppColors.lightGray,
                    border: Border.all(color: Colors.transparent),
                    width: 50,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(AssetFinder.icon('notification')),
                    ),
                  ),
                ),
                Positioned(
                  right: -2,
                  top: 0,
                  child: ShadBadge(
                    shape: CircleBorder(),
                    backgroundColor: AppColors.red,
                    child: Text('5', style: WorkSansStyle.labelLarge),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
