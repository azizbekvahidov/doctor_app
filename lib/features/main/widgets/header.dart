import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/widgets/circle.dart';
import 'package:doctor_app/styles/app_colors.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../onboard/controller/onboard_controller.dart';

class Header extends StatelessWidget {
  Header({super.key});
  final OnboardController onboardController = Get.find<OnboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Row(
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
            );
          }),
          Spacer(),
          SizedBox(
            height: 65,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Circle(
                  bgColor: AppColors.lightGray,
                  border: Border.all(color: Colors.transparent),
                  width: 50,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(AssetFinder.icon('notification')),
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
