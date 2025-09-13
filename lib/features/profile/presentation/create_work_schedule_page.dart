import 'dart:async';

import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/basic_text_fields.dart';
import 'package:doctor_app/core/design_system/widgets/text_field.dart/input_title.dart';
import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/features/profile/domain/models/schedule.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/profile/presentation/widgets/add_schedule_time_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

import 'widgets/time_picker_button.dart';

class CreateWorkSchedulePage extends StatelessWidget {
  CreateWorkSchedulePage({super.key});

  final CabinetController cabinetController = Get.find<CabinetController>();
  final OnboardController onboardController = Get.find<OnboardController>();

  Future<void> showAddScheduleDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AddScheduleTimeDialog(cabinetController: cabinetController);
      },
    );
  }

  save() {
    cabinetController.create();
  }

  @override
  Widget build(BuildContext context) {
    if (cabinetController.selectedClinicRequest.value != null) {
      cabinetController.clinicController.text =
          onboardController.selectedLang.value == 'uz'
          ? cabinetController.selectedClinicRequest.value!.nameUz
          : cabinetController.selectedClinicRequest.value!.nameRu;
    }
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputTitle(text: "clinic".tr),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: BasicTextField(
                          controller: cabinetController.clinicController,
                          onChanged: (query) {
                            cabinetController.getClinics(query);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        child: SvgPicture.asset(
                          AssetFinder.icon('add_work'),
                          color: AppColors.primary,
                          width: 28,
                          height: 28,
                        ),
                        onTap: () => Get.toNamed(Routes.createWorkPlace),
                      ),
                    ],
                  ),

                  Obx(() {
                    if (cabinetController.clinics.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        SizedBox(height: 5),
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final clinic = cabinetController.clinics[index];
                              return ListTile(
                                title: Text(clinic.name!.ru ?? ""),
                                subtitle: Text(clinic.address!.ru ?? ""),
                                onTap: () {
                                  // Handle clinic selection
                                },
                              );
                            },
                            itemCount: cabinetController.clinics.length,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  InputTitle(text: "Цена первого приема".tr),
                  const SizedBox(height: 8),
                  BasicTextFormField(
                    errorText: "",
                    controller: cabinetController.priceController,
                  ),
                  const SizedBox(height: 20),
                  InputTitle(text: "Цена последующих приемов".tr),
                  const SizedBox(height: 8),
                  BasicTextFormField(
                    errorText: "",
                    controller: cabinetController.secondPriceController,
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
                          InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            child: SvgPicture.asset(
                              AssetFinder.icon('add_work'),
                              color: AppColors.primary,
                              width: 28,
                              height: 28,
                            ),
                            onTap: () {
                              showAddScheduleDialog(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      Obx(() {
                        return Table(
                          border: TableBorder.symmetric(
                            inside: BorderSide.none,
                            outside: BorderSide.none,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2.4),
                            2: FlexColumnWidth(2.4),
                          },
                          children: [
                            // Header row
                            TableRow(
                              children: [
                                Text("day".tr, style: WorkSansStyle.body),
                                Center(
                                  child: Text(
                                    "hour".tr,
                                    style: WorkSansStyle.body,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "lunch".tr,
                                    style: WorkSansStyle.body,
                                  ),
                                ),
                              ],
                            ),

                            const TableRow(
                              children: [
                                SizedBox(height: 8),
                                SizedBox(),
                                SizedBox(),
                              ],
                            ),

                            // Rows
                            ...cabinetController.selectedSchedules.map((day) {
                              return TableRow(
                                children: [
                                  Text(day.day!.toLowerCase().tr),
                                  Center(
                                    child: Text(
                                      day.work!.from != null &&
                                              day.work!.until != null
                                          ? "${day.work!.from}-${day.work!.until}"
                                          : "-",
                                      style: WorkSansStyle.bodySmall,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      day.lunch!.from != null &&
                                              day.lunch!.until != null
                                          ? "${day.lunch!.from}-${day.lunch!.until}"
                                          : "-",
                                      style: WorkSansStyle.bodySmall,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PrimaryButton(
                  width: double.infinity,
                  onTap: save,
                  child: Text(
                    "save".tr,
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
