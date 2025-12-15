import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/design_system/styles/app_colors.dart';
import '../../domain/models/clinic_request.dart';

class ClinicList extends StatelessWidget {
  const ClinicList({
    super.key,
    required this.cabinetController,
    required this.onboardController,
  });

  final CabinetController cabinetController;
  final OnboardController onboardController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.1), // from slightly up
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child:
            cabinetController.showClinic.value == false ||
                cabinetController.clinics.isEmpty
            ? const SizedBox.shrink()
            : Column(
                key: const ValueKey("clinic_list"),
                children: [
                  const SizedBox(height: 5),
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.subTitleLight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: cabinetController.clinics.length,
                            itemBuilder: (context, index) {
                              final clinic = cabinetController.clinics[index];
                              return ListTile(
                                title: Text(clinic.name?.ru ?? ""),
                                subtitle: Text(clinic.address?.ru ?? ""),

                                onTap: () {
                                  cabinetController.clinicController.text =
                                      onboardController.selectedLang.value ==
                                          'ru'
                                      ? clinic.name?.ru ?? ""
                                      : clinic.name?.uz ?? "";

                                  cabinetController.selectClinic(
                                    ClinicRequest(
                                      id: clinic.id,
                                      nameRu: clinic.name?.ru ?? "",
                                      nameUz: clinic.name?.uz ?? "",
                                      addressRu: clinic.address?.ru ?? "",
                                      addressUz: clinic.address?.uz ?? "",
                                      district: clinic.district?.id ?? 0,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
