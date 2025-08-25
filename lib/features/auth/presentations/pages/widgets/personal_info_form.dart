import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/features/auth/presentations/pages/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController birthdayController;

  const PersonalInfoForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.birthdayController,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImage(),
          const SizedBox(height: 16),
          InputTitle(text: "first_name".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            errorText: "please enter your first name".tr,
            controller: widget.firstNameController,
          ),
          const SizedBox(height: 25),
          InputTitle(text: "last_name".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            errorText: "please enter your last name".tr,
            controller: widget.lastNameController,
          ),
          const SizedBox(height: 25),
          InputTitle(text: "middle_name".tr),
          const SizedBox(height: 8),
          BasicTextFormField(
            errorText: "please enter your last name".tr,
            controller: widget.middleNameController,
          ),
          const SizedBox(height: 25),
          InputTitle(text: "birthday".tr),
          const SizedBox(height: 8),
          FormField<String>(
            validator: (value) {
              if (widget.birthdayController.text.isEmpty) {
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
                        widget.birthdayController.text = DateFormat(
                          "dd-MM-yyyy",
                        ).format(picked);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: BasicTextField(
                      controller: widget.birthdayController,

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
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
