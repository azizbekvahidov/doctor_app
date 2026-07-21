import 'package:doctor_app/core/design_system/widgets/v2/v2.dart';
import 'package:doctor_app/core/enums/issue_pop_up_menu.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/issue_detail/presentation/widgets/patient_row_detail_info.dart';
import 'package:doctor_app/features/issue_detail/presentation/widgets/section_info.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/controllers/issue_event.dart';

class IssueDetailPage extends StatefulWidget {
  const IssueDetailPage({super.key});

  @override
  State<IssueDetailPage> createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  final IssueController issueController = Get.find<IssueController>();
  Issue? issue;

  bool isConnected = false;
  bool isAccepted = false; // temporary UI flag

  @override
  void initState() {
    super.initState();
    getIssue();

    ever<IssueEvent?>(issueController.uiEvent, (event) {
      if (event is Archive) {
        Get.snackbar(
          "archived".tr,
          "issue_archived_successfully".tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 14,
        );
      }
    });
  }

  getIssue() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      issue = Get.arguments;
      if (issue != null) {
        issueController.setIssueUUID(issue!.uuid!);
        isConnected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        centerTitle: true,
        title: Text("card".tr, style: AppText.title.copyWith(fontSize: 18)),
        actions: [
          PopupMenuButton<IssuePopUpMenu>(
            icon: const Icon(Icons.more_horiz_rounded, color: AppColors.ink),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<IssuePopUpMenu>(
                value: IssuePopUpMenu.archive,
                child: Text('archive'.tr, style: AppText.body),
              ),
            ],
            onSelected: (value) {
              if (value == IssuePopUpMenu.archive) _showArchiveDialog();
            },
          ),
        ],
      ),
      floatingActionButton: isAccepted
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () => Get.toNamed(Routes.chat, arguments: issue),
              child: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
            )
          : null,
      bottomNavigationBar:
          (!isAccepted && issue != null && issue!.inactiveAt == null)
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'cancel'.tr,
                        kind: AppButtonKind.ghost,
                        block: true,
                        onPressed: () {
                          Get.snackbar(
                            "declined".tr,
                            "appointment_declined".tr,
                            backgroundColor: AppColors.danger,
                            colorText: Colors.white,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: 'accept'.tr,
                        kind: AppButtonKind.success,
                        block: true,
                        onPressed: () {
                          setState(() => isAccepted = true);
                          Get.snackbar(
                            "accepted".tr,
                            "appointment_accepted".tr,
                            backgroundColor: AppColors.success,
                            colorText: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: issue == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  Text("patient_information".tr, style: AppText.micro),
                  const SizedBox(height: 12),
                  AppCard(
                    child: Column(
                      children: [
                        PatientRowDetailInfo(
                          label: "first_name".tr,
                          value: issue?.patient?.fullName ?? "—",
                        ),
                        const SizedBox(height: 12),
                        PatientRowDetailInfo(
                          label: "birthday".tr,
                          value: DateFormatter.birthday(
                            issue?.birthdate ?? DateTime.now(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        PatientRowDetailInfo(
                          label: "address".tr,
                          value: issue?.address ?? "—",
                        ),
                        const SizedBox(height: 12),
                        PatientRowDetailInfo(
                          label: "complaint".tr,
                          value: issue?.issue ?? "—",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppCard(
                    child: SectionInfo(
                      title: "analysis_data".tr,
                      text: issue?.issue ?? "—",
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: AppRadii.cardR,
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: AppColors.ink3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppCard(
                    child: SectionInfo(
                      title: "diagnosis".tr,
                      text: "—",
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showArchiveDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.cardR),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.warningTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.archive_rounded,
                  size: 30,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "archive_alert".tr,
                textAlign: TextAlign.center,
                style: AppText.headline,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'no'.tr,
                      kind: AppButtonKind.ghost,
                      block: true,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'yes'.tr,
                      block: true,
                      onPressed: () {
                        issueController.archiveIssue();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
