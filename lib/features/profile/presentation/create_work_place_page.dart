import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/features/profile/domain/models/clinic_request.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkPlacePage extends StatelessWidget {
  CreateWorkPlacePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController ruNameOfClinicController =
      TextEditingController();
  final TextEditingController uzNameOfClinicController =
      TextEditingController();
  final TextEditingController ruAddressOfClinicController =
      TextEditingController();
  final TextEditingController uzAddressOfClinicController =
      TextEditingController();

  int selectedRegionId = -1;
  Region? selectedRegion;

  final CabinetController cabinetController = Get.find<CabinetController>();
  final OnboardController onboardController = Get.find<OnboardController>();

  saveClinic() async {
    if (_formKey.currentState!.validate() && selectedRegionId > 0) {
      final clinic = ClinicRequest(
        addressRu: ruAddressOfClinicController.text,
        addressUz: uzAddressOfClinicController.text,
        nameRu: ruNameOfClinicController.text,
        nameUz: uzNameOfClinicController.text,
        regionId: selectedRegionId,
      );
      LogHelper.info("Saving clinic: ${clinic.toJson()}");
      cabinetController.selectClinic(clinic);
      Get.back();
    } else {
      LogHelper.error("Form is not valid or region not selected");
      await Future.delayed(Duration(milliseconds: 1000));
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                              height: 240,
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
                                            errorText:
                                                "valid_name_of_clinic".tr,
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
                                            errorText:
                                                "valid_address_of_clinic".tr,
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
                                            errorText:
                                                "valid_name_of_clinic".tr,
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
                                            errorText:
                                                "valid_address_of_clinic".tr,
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
                    Obx(() {
                      return FormField(
                        initialValue: cabinetController.regions.isNotEmpty
                            ? onboardController.selectedLang.value == 'ru'
                                  ? cabinetController.regions[0].name!.ru
                                  : cabinetController.regions[0].name!.uz
                            : null,
                        builder: (field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputTitle(text: "region".tr),
                              SizedBox(height: 8),
                              CustomDropdown<String>(
                                decoration: CustomDropdownDecoration(
                                  closedBorder: Border.all(
                                    color: AppColors.grey,
                                  ),
                                  expandedBorder: Border.all(
                                    color: AppColors.grey,
                                  ),
                                ),
                                hintText: 'select_profession'.tr,
                                initialItem: selectedRegion != null
                                    ? onboardController.selectedLang.value ==
                                              'ru'
                                          ? selectedRegion!.name!.ru
                                          : selectedRegion!.name!.uz
                                    : null,
                                items: cabinetController.regions
                                    .map(
                                      (region) =>
                                          onboardController
                                                  .selectedLang
                                                  .value ==
                                              'ru'
                                          ? region.name!.ru!
                                          : region.name!.uz!,
                                    )
                                    .toList(),

                                onChanged: (value) {
                                  final _selectedRegion = cabinetController
                                      .regions
                                      .firstWhere(
                                        (region) =>
                                            (onboardController
                                                        .selectedLang
                                                        .value ==
                                                    'ru'
                                                ? region.name!.ru
                                                : region.name!.uz) ==
                                            value,
                                      );
                                  selectedRegion = _selectedRegion;
                                  selectedRegionId = _selectedRegion.id!;
                                },
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
                          if (selectedRegionId <= 0) {
                            return "valid_weekday".tr;
                          }
                          return null;
                        },
                      );
                    }),
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
                  onTap: saveClinic,
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
