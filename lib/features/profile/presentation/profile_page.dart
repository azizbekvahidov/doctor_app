import 'package:doctor_app/core/pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 50),
                  Text("profile".tr, style: WorkSansStyle.titleLarge),
                  SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Circle(),
                      Container(
                        padding: EdgeInsets.all(7),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightGray,
                        ),
                        child: SvgPicture.asset(AssetFinder.icon('edit')),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: WorkSansStyle.titleLarge.copyWith(
                        color: Colors.black,
                      ),
                      text: "Akhmadjon",
                      children: [
                        TextSpan(text: "\n"),
                        TextSpan(text: "Akbarov"),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.documents),
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border(
                          bottom: BorderSide(color: AppColors.subTitleLight),
                        ),
                      ),
                      width: double.infinity,
                      child: Text(
                        "documents".tr,
                        style: WorkSansStyle.label.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleDark,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.workInfo),
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border(
                          bottom: BorderSide(color: AppColors.subTitleLight),
                        ),
                      ),
                      width: double.infinity,
                      child: Text(
                        "work_and_schedule".tr,
                        style: WorkSansStyle.label.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.subTitleDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: PrimaryButton(
                  width: double.infinity,
                  child: Text(
                    "log out".tr,
                    style: WorkSansStyle.labelLarge.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
