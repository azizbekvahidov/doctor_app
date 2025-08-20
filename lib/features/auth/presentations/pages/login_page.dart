import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/core/widgets/circle.dart';
import 'package:doctor_app/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../styles/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Circle(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JSHSHIR",
                    style: WorkSansStyle.headline5.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  ShadInput(
                    onChanged: (value) {},
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    decoration: ShadDecoration(
                      border: ShadBorder.all(
                        color: Colors.grey, // default border color
                      ),
                      focusedBorder: ShadBorder.all(
                        color: Colors.grey, // border when focused
                        width: 2,
                        radius: BorderRadius.circular(10),
                      ),
                      errorBorder: ShadBorder.all(
                        color: Colors.red, // border when error
                      ),
                      disableSecondaryBorder: true,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    child: Text("Lorem ipsum"),
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                    child: PrimaryButton(
                      child: Text(
                        "Login",
                        style: WorkSansStyle.labelLarge.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
