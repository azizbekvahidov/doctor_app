import 'package:doctor_app/core/widgets/buttons.dart';
import 'package:doctor_app/core/widgets/text_field.dart/basic_text_field.dart';
import 'package:doctor_app/core/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/profile_image.dart';
import 'package:doctor_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (page == 2) {
              setState(() {
                page = 1;
              });
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [Text("Personal Information"), Text("$page/2")],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ProfileImage(),
                  if (page == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputTitle(text: "name"),
                        SizedBox(height: 8),
                        BasicTextField(),
                        SizedBox(height: 25),
                        InputTitle(text: "last"),
                        SizedBox(height: 8),
                        BasicTextField(),
                        SizedBox(height: 25),
                        InputTitle(text: "middle"),
                        SizedBox(height: 8),
                        BasicTextField(),
                        SizedBox(height: 25),
                        InputTitle(text: "birthday"),
                        SizedBox(height: 8),
                        BasicTextField(),
                      ],
                    )
                  else
                    Column(children: []),
                ],
              ),
              PrimaryButton(
                height: 60,
                onTap: () => setState(() {
                  page = 2;
                }),
                width: double.infinity,
                child: Text(
                  'next'.tr,
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w500,
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
