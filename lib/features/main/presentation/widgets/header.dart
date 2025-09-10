import 'package:doctor_app/core/enums/contents.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/main/presentation/controller/main_page_controller.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Header extends StatefulWidget {
  Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final OnboardController onboardController = Get.find<OnboardController>();

  final AuthController authController = Get.find<AuthController>();

  final MainPageController mainPageController = Get.find<MainPageController>();

  @override
  void initState() {
    onboardController.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            if (onboardController.loadingUser.value) return SizedBox.shrink();
            return GestureDetector(
              onTap: () => authController.logout(),
              child: Row(
                children: [
                  if (onboardController.user.value!.avatar!.url == null)
                    SvgPicture.asset(AssetFinder.icon('avatar'), height: 55)
                  else
                    SizedBox.shrink(),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        onboardController.user.value!.firstName!,
                        style: WorkSansStyle.titleLarge,
                      ),
                      Text(
                        onboardController.user.value!.lastName!,
                        style: WorkSansStyle.titleLarge,
                      ),
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
