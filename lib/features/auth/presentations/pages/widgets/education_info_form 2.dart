import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/profile_image.dart';
import 'package:get/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EducationInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController selectedProfessionController;
  final TextEditingController selectedDegreeController;

  const EducationInfoForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.phoneNumberController,
    required this.selectedProfessionController,
    required this.selectedDegreeController,
  });

  @override
  State<EducationInfoForm> createState() => _EducationInfoFormState();
}

class _EducationInfoFormState extends State<EducationInfoForm> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '+998 ## ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  List<String> medicalDegreesKeys = [
    "bachelor",
    "master",
    "phd",
    "docent",
    "professor",
  ];

  List<String> medicalProfessionsKeys = [
    "general_practitioner",
    "dentist",
    "surgeon",
    "therapist",
    "pediatrician",
    "cardiologist",
    "neurologist",
    "oncologist",
    "orthopedist",
    "gynecologist",
    "urologist",
    "dermatologist",
    "psychiatrist",
    "radiologist",
    "ophthalmologist",
    "anesthesiologist",
    "endocrinologist",
    "family_doctor",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        key: ValueKey(2),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImage(),
          const SizedBox(height: 16),
          InputTitle(text: "phone_number".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            textInputType: TextInputType.phone,
            errorText: "valid_phone_number".tr,
            controller: widget.phoneNumberController,
            inputFormatters: [maskFormatter],
          ),
          const SizedBox(height: 25),
          InputTitle(text: "profession".tr),
          const SizedBox(height: 8),
          FormField(
            initialValue: widget.selectedDegreeController.text,
            builder: (field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: AppColors.grey),
                      expandedBorder: Border.all(color: AppColors.grey),
                    ),
                    hintText: 'select_profession'.tr,
                    initialItem:
                        widget.selectedProfessionController.text.isEmpty
                        ? null
                        : widget.selectedProfessionController.text.tr,
                    items: medicalProfessionsKeys.map((key) => key.tr).toList(),

                    onChanged: (value) {
                      setState(() {
                        final selectedKey = medicalProfessionsKeys.firstWhere(
                          (k) => k.tr == value,
                          orElse: () => value!,
                        );
                        widget.selectedProfessionController.text = selectedKey;
                      });
                    },
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        field.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              );
            },
            validator: (value) {
              if (widget.selectedProfessionController.text.isEmpty) {
                return "valid_profession".tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          InputTitle(text: "degree".tr),
          const SizedBox(height: 8),
          FormField(
            builder: (field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown<String>(
                    decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(color: AppColors.grey),
                      expandedBorder: Border.all(color: AppColors.grey),
                    ),
                    hintText: 'select_degree'.tr,
                    initialItem: widget.selectedDegreeController.text.isEmpty
                        ? null
                        : widget
                              .selectedDegreeController
                              .text
                              .tr, // show translated value
                    items: medicalDegreesKeys
                        .map((key) => key.tr)
                        .toList(), // show translated list
                    onChanged: (value) {
                      setState(() {
                        final selectedKey = medicalDegreesKeys.firstWhere(
                          (k) => k.tr == value,
                          orElse: () => value!,
                        );
                        widget.selectedDegreeController.text =
                            selectedKey; // store the key
                      });
                    },
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        field.errorText!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              );
            },
            validator: (value) {
              if (widget.selectedDegreeController.text.isEmpty) {
                return "valid_degree".tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          InputTitle(text: "email".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            errorText: "valid_email".tr,
            controller: widget.emailController,
          ),
        ],
      ),
    );
  }
}
