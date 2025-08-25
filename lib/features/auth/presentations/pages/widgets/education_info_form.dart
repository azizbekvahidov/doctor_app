import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/profile_image.dart';
import 'package:get/utils.dart';

class EducationInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<String> jobRoles;

  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController selectedProfessionController;
  final TextEditingController selectedDegreeController;

  EducationInfoForm({
    super.key,
    required this.formKey,
    required this.jobRoles,
    required this.emailController,
    required this.phoneNumberController,
    required this.selectedProfessionController,
    required this.selectedDegreeController,
  });

  @override
  State<EducationInfoForm> createState() => _EducationInfoFormState();
}

class _EducationInfoFormState extends State<EducationInfoForm> {
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
            errorText: "please enter your phone number".tr,
            controller: widget.phoneNumberController,
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
                    hintText: 'Select job role',
                    initialItem:
                        widget.selectedProfessionController.text.isEmpty
                        ? null
                        : widget.selectedProfessionController.text,
                    items: widget.jobRoles,
                    onChanged: (value) {
                      setState(() {
                        widget.selectedProfessionController.text = value!;
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
                return "please select your profession role".tr;
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
                    hintText: 'Select degree',
                    initialItem: widget.selectedDegreeController.text.isEmpty
                        ? null
                        : widget.selectedDegreeController.text,
                    items: widget.jobRoles,
                    onChanged: (value) {
                      print(widget.selectedDegreeController.text);
                      setState(() {
                        widget.selectedDegreeController.text = value!;
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
                return "please select your degree".tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          InputTitle(text: "email".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            errorText: "please enter your email".tr,
            controller: widget.emailController,
          ),
        ],
      ),
    );
  }
}
