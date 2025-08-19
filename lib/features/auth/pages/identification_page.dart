import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/core/widgets/circle.dart';
import 'package:doctor_app/styles/app_colors.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ShadButton.secondary(
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
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
              child: PrimaryButton(
                child: Text(
                  "Identification",
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
