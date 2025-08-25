import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SocialInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController aboutUzController;

  final TextEditingController aboutRuController;

  final TextEditingController telegramController;

  final TextEditingController instagramController;

  final TextEditingController experienceController;

  const SocialInfoForm({
    super.key,
    required this.formKey,
    required this.aboutUzController,
    required this.aboutRuController,
    required this.telegramController,
    required this.instagramController,
    required this.experienceController,
  });

  @override
  State<SocialInfoForm> createState() => _SocialInfoFormState();
}

class _SocialInfoFormState extends State<SocialInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "Oʻzbek"),
                      Tab(text: "Русский"),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: ShadTextarea(
                            controller: widget.aboutUzController,
                            placeholder: Text(
                              "about_uz".tr,
                              style: WorkSansStyle.labelLarge.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            minHeight: 200,
                            decoration: ShadDecoration(
                              border: ShadBorder.all(color: AppColors.grey),
                              secondaryFocusedBorder: ShadBorder.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: ShadTextarea(
                            controller: widget.aboutRuController,
                            placeholder: Text(
                              "about_ru".tr,
                              style: WorkSansStyle.labelLarge.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            minHeight: 200,
                            decoration: ShadDecoration(
                              border: ShadBorder.all(color: AppColors.grey),
                              secondaryFocusedBorder: ShadBorder.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTitle(text: "social_networks"),
              SizedBox(height: 20),
              BasicTextFormField(
                controller: widget.telegramController,
                errorText: "please enter your telegram username".tr,
                hintText: Text(
                  "Telegram",
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 15),
              BasicTextFormField(
                controller: widget.instagramController,
                errorText: "please enter your instagram username".tr,
                hintText: Text(
                  "Instagram",
                  style: WorkSansStyle.labelLarge.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 50),
              InputTitle(text: "Experience"),
              SizedBox(height: 15),
              FormField<String>(
                validator: (value) {
                  if (widget.experienceController.text.isEmpty) {
                    return "please select your birthday".tr;
                  }
                  return null;
                },
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            widget.experienceController.text = DateFormat(
                              "dd-MM-yyyy",
                            ).format(picked);
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: BasicTextField(
                          controller: widget.experienceController,

                          hintText: Text(
                            DateFormat("dd-MM-yyyy").format(DateTime.now()),
                            style: WorkSansStyle.labelLarge.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (field.errorText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          field.errorText!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
