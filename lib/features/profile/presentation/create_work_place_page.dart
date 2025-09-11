import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreateWorkPlacePage extends StatelessWidget {
  CreateWorkPlacePage({super.key});

  final TextEditingController ruNameOfClinicController =
      TextEditingController();
  final TextEditingController uzNameOfClinicController =
      TextEditingController();
  final TextEditingController ruAddressOfClinicController =
      TextEditingController();
  final TextEditingController uzAddressOfClinicController =
      TextEditingController();

  final List<String> medicalProfessionsKeys = [
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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 270,
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
                              height: 210,
                              child: TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 18),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InputTitle(text: "name_of_clinic".tr),
                                          SizedBox(height: 10),
                                          BasicTextFormField(
                                            controller:
                                                uzNameOfClinicController,
                                            errorText: "",
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InputTitle(
                                            text: "address_of_clinic".tr,
                                          ),
                                          SizedBox(height: 10),
                                          BasicTextFormField(
                                            errorText: "",
                                            controller:
                                                uzAddressOfClinicController,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 18),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InputTitle(text: "name_of_clinic".tr),
                                          SizedBox(height: 10),
                                          BasicTextFormField(
                                            errorText: "",
                                            controller:
                                                ruNameOfClinicController,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InputTitle(
                                            text: "address_of_clinic".tr,
                                          ),
                                          SizedBox(height: 10),
                                          BasicTextFormField(
                                            errorText: "",
                                            controller:
                                                ruAddressOfClinicController,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FormField(
                      initialValue: medicalProfessionsKeys[0],
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTitle(text: "region".tr),
                            SizedBox(height: 8),
                            CustomDropdown<String>(
                              decoration: CustomDropdownDecoration(
                                closedBorder: Border.all(color: AppColors.grey),
                                expandedBorder: Border.all(
                                  color: AppColors.grey,
                                ),
                              ),
                              hintText: 'select_profession'.tr,
                              initialItem: medicalProfessionsKeys[0].tr,
                              items: medicalProfessionsKeys
                                  .map((key) => key.tr)
                                  .toList(),

                              onChanged: (value) {},
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
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
                      validator: (value) {
                        // if (selectedDay == null) {
                        //   return "valid_weekday".tr;
                        // }
                        // return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            Colors.grey[200], // light grey like in screenshot
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 30,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),

                PrimaryButton(
                  width: double.infinity,
                  child: Text(
                    "save".tr,
                    style: WorkSansStyle.labelLarge.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
