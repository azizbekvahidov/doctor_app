import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/core/widgets/circle.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class IdentificationPage extends GetView<AuthController> {
  const IdentificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ShadButton.secondary(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Divider(thickness: 2),
                  Circle(),
                  SizedBox(height: 160),
                  Column(
                    children: [
                      SvgPicture.asset(AssetFinder.icon('avatar'), height: 65),
                      Text(
                        "Сделать селфи и  пройти идентификацию",
                        style: WorkSansStyle.headline3.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => PrimaryButton(
                    onTap: () => controller.register(),
                    child: controller.isAuthorization.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ),
                          )
                        : Text(
                            "Identification",
                            style: WorkSansStyle.labelLarge.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
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
