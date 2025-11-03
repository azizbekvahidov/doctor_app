import 'dart:async';

import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';

import 'package:doctor_app/core/design_system/widgets/buttons/create_button.dart';
import 'package:doctor_app/core/design_system/widgets/buttons/ready_buttons.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';

import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/profile/presentation/widgets/add_schedule_time_dialog.dart';
import 'package:doctor_app/features/profile/presentation/widgets/clinic_list.dart';
import 'package:doctor_app/features/profile/presentation/widgets/schedule_table.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkSchedulePage extends StatefulWidget {
  const CreateWorkSchedulePage({super.key});

  @override
  State<CreateWorkSchedulePage> createState() => _CreateWorkSchedulePageState();
}

class _CreateWorkSchedulePageState extends State<CreateWorkSchedulePage> {
  final CabinetController cabinetController = Get.find<CabinetController>();

  final OnboardController onboardController = Get.find<OnboardController>();

  save() {
    if (!cabinetController.formKey.currentState!.validate()) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        cabinetController.formKey.currentState!.reset();
      });
      return;
    }
    if (cabinetController.selectedSchedules.isEmpty) {
      Notifier.showSnackbar(
        duration: Duration(seconds: 2),
        fromBottom: 160,
        content: Text("valid_schedules".tr, style: WorkSansStyle.label),
        backgroundColor: AppColors.red,
      );
      return;
    }
    cabinetController.create();
  }

  @override
  void dispose() {
    cabinetController.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("add_work_place".tr),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: cabinetController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTitle(text: "clinic".tr),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            if (cabinetController.selectedClinicRequest.value !=
                                null) {
                              cabinetController.clinicController.text =
                                  onboardController.selectedLang.value == 'uz'
                                  ? cabinetController
                                        .selectedClinicRequest
                                        .value!
                                        .nameUz
                                  : cabinetController
                                        .selectedClinicRequest
                                        .value!
                                        .nameRu;
                            }
                            return BasicTextFormField(
                              controller: cabinetController.clinicController,
                              onChanged: (query) {
                                cabinetController.getClinics(query);
                              },
                              errorText: 'valid_clinic'.tr,
                              trailing: GestureDetector(
                                onTap: () => cabinetController.toggleClinic(),
                                child: Obx(
                                  () => cabinetController.clinics.isNotEmpty
                                      ? cabinetController.showClinic.value
                                            ? Icon(Icons.arrow_drop_up)
                                            : Icon(Icons.arrow_drop_down)
                                      : SizedBox.shrink(),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(width: 10),
                        CreateButton(
                          onClick: () => Get.toNamed(Routes.createWorkPlace),
                        ),
                      ],
                    ),
                    ClinicList(
                      cabinetController: cabinetController,
                      onboardController: onboardController,
                    ),

                    const SizedBox(height: 20),
                    InputTitle(text: "first_price".tr),
                    const SizedBox(height: 8),
                    BasicTextFormField(
                      errorText: "valid_first_price".tr,
                      controller: cabinetController.priceController,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    InputTitle(text: "second_price".tr),
                    const SizedBox(height: 8),
                    BasicTextFormField(
                      errorText: "valid_second_price".tr,
                      controller: cabinetController.secondPriceController,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox.shrink(),
                            Center(
                              child: Text(
                                "schedule".tr,
                                style: WorkSansStyle.titleMedium.copyWith(),
                              ),
                            ),
                            CreateButton(
                              onClick: () {
                                Get.dialog(
                                  AddScheduleTimeDialog(
                                    cabinetController: cabinetController,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        ScheduleTable(cabinetController: cabinetController),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SaveButton(onClick: save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
