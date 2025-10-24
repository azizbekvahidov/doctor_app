import 'dart:io';

import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/circle.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final CabinetController cabinetController = Get.find<CabinetController>();
  final UserController userController = Get.find<UserController>();

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
                      Obx(() {
                        if (cabinetController.isAvatarLoading.value) {
                          return Circle(
                            child: Padding(
                              padding: EdgeInsets.all(30),

                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (cabinetController
                            .selectedAvatarPath
                            .value
                            .isNotEmpty) {
                          return Circle(
                            child: Image.file(
                              File(cabinetController.selectedAvatarPath.value),
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Circle(
                            child: Image.network(
                              userController.user.value!.avatar!.url ??
                                  "https://img.freepik.com/free-photo/female-doctor-hospital-with-stethoscope_23-2148827774.jpg?semt=ais_hybrid&w=740&q=80",
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      }),
                      Obx(
                        () => cabinetController.isAvatarLoading.value
                            ? SizedBox.shrink()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Material(
                                    color: AppColors.lightGray,
                                    child: InkWell(
                                      splashColor: Colors.black12,
                                      onTap: () async => await cabinetController
                                          .selectAvatarFile(),
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: SvgPicture.asset(
                                          AssetFinder.icon('edit'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: WorkSansStyle.titleLarge.copyWith(
                          color: Colors.black,
                        ),
                        text: userController.user.value!.firstName,
                        children: [
                          TextSpan(text: "\n"),
                          TextSpan(text: userController.user.value!.lastName),
                        ],
                      ),
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
