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
                    height: 250,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: FormField(
                            validator: (value) {
                              if (widget.aboutUzController.text.isEmpty) {
                                return "valid_about_uz".tr;
                              }
                              return null;
                            },
                            builder: (field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShadTextarea(
                                    controller: widget.aboutUzController,
                                    placeholder: Text(
                                      "about_uz".tr,
                                      style: WorkSansStyle.labelLarge.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    minHeight: 170,
                                    decoration: ShadDecoration(
                                      border: ShadBorder.all(
                                        color: AppColors.grey,
                                      ),
                                      secondaryFocusedBorder: ShadBorder.all(
                                        color: Colors.transparent,
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
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: FormField(
                            validator: (value) {
                              if (widget.aboutRuController.text.isEmpty) {
                                return "valid_about_ru".tr;
                              }
                              return null;
                            },
                            builder: (field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShadTextarea(
                                    controller: widget.aboutRuController,
                                    placeholder: Text(
                                      "about_ru".tr,
                                      style: WorkSansStyle.labelLarge.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    minHeight: 170,
                                    decoration: ShadDecoration(
                                      border: ShadBorder.all(
                                        color: AppColors.grey,
                                      ),
                                      secondaryFocusedBorder: ShadBorder.all(
                                        color: Colors.transparent,
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
                              );
                            },
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
                errorText: "valid_social_networks".tr,
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
                errorText: "valid_social_networks".tr,
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
                    return "valid_experience".tr;
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
                              "yyyy-MM-dd",
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
