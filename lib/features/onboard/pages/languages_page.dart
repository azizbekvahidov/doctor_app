import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'widgets/lang_button.dart';

class LanguagesPage extends StatelessWidget {
  const LanguagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LangButton(lang: "Uz", onTap: () {}),
                  SizedBox(width: 30),
                  LangButton(lang: "Ru", onTap: () {}),
                ],
              ),
              PrimaryButton(
                child: Text(
                  "Next",
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
