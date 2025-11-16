// import 'package:doctor_app/core/design_system/styles/app_colors.dart';
// import 'package:doctor_app/core/design_system/styles/text_styles.dart';
// import 'package:doctor_app/core/design_system/widgets/buttons.dart';
// import 'package:doctor_app/core/enums/issue_pop_up_menu.dart';
// import 'package:doctor_app/core/navigation/routes.dart';
// import 'package:doctor_app/core/utils/asset_finder.dart';
// import 'package:doctor_app/core/utils/formatters.dart';
//
// import 'package:doctor_app/features/issue_detail/presentation/widgets/patient_row_detail_info.dart';
// import 'package:doctor_app/features/issue_detail/presentation/widgets/section_info.dart';
// import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
// import 'package:doctor_app/features/shared/domain/models/issue.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:shadcn_ui/shadcn_ui.dart';
//
// import '../../shared/controllers/issue_event.dart';
//
// class IssueDetailPage extends StatefulWidget {
//   const IssueDetailPage({super.key});
//
//   @override
//   State<IssueDetailPage> createState() => _IssueDetailPageState();
// }
//
// class _IssueDetailPageState extends State<IssueDetailPage> {
//   final IssueController issueController = Get.find<IssueController>();
//   Issue? issue;
//
//   bool isConnected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getIssue();
//     ever<IssueEvent?>(issueController.uiEvent, (event) {
//       if (event is Archive) {
//         Get.snackbar(
//           "",
//           "",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           margin: const EdgeInsets.all(16),
//           borderRadius: 8,
//           snackStyle: SnackStyle.FLOATING,
//           titleText: Text(
//             "archived".tr,
//             style: WorkSansStyle.labelLarge.copyWith(color: Colors.white),
//           ),
//           messageText: Text(
//             "issue_archived_successfully".tr,
//             style: WorkSansStyle.label.copyWith(color: Colors.white),
//           ),
//         );
//       }
//     });
//   }
//
//   getIssue() async {
//     await Future.delayed(Duration(milliseconds: 500));
//     setState(() {
//       issue = Get.arguments;
//       if (issue != null) {
//         issueController.setIssueUUID(issue!.uuid!);
//         isConnected = true;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: Icon(Icons.arrow_back),
//         ),
//         centerTitle: true,
//         title: Text("${"card".tr} №23"),
//         actions: [
//           PopupMenuButton(
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem<IssuePopUpMenu>(
//                 value: IssuePopUpMenu.archive,
//                 child: Text('archive'.tr),
//               ),
//             ],
//             onSelected: (value) {
//               if (value == IssuePopUpMenu.archive) {
//                 Get.dialog(
//                   Dialog(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.archive_outlined, size: 48),
//                           const SizedBox(height: 16),
//                           Text(
//                             "archive_alert".tr,
//                             textAlign: TextAlign.center,
//                             style: Get.textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//
//                           const SizedBox(height: 24),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ShadButton.secondary(
//                                   child: Text('no'.tr),
//                                   onPressed: () => Get.back(),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: ShadButton(
//                                   backgroundColor: AppColors.primary,
//                                   child: Text('yes'.tr),
//                                   onPressed: () {
//                                     issueController.archiveIssue();
//                                     Get.back();
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: true
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 PrimaryButton(onTap: () {}, child: Text("accept".tr)),
//                 ShadButton.secondary(
//                   child: Text('cancel'.tr),
//                   onPressed: () {},
//                 ),
//               ],
//             )
//           : Builder(
//               builder: (context) {
//                 if (isConnected) {
//                   if (issue != null) {
//                     if (issue!.inactiveAt != null) {
//                       return SizedBox.shrink();
//                     }
//                   }
//                   return FloatingActionButton(
//                     onPressed: () {
//                       Get.toNamed(Routes.chat, arguments: issue);
//                     },
//                     backgroundColor: AppColors.primary,
//                     child: SvgPicture.asset(
//                       AssetFinder.icon('chat'),
//                       height: 30,
//                     ),
//                   );
//                 }
//                 return SizedBox.shrink();
//               },
//             ),
//       body: SafeArea(
//         child: issue == null
//             ? Center(child: CircularProgressIndicator(color: Colors.black))
//             : ListView(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 children: [
//                   Text(
//                     "patient_information".tr,
//                     style: WorkSansStyle.headline4,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Column(
//                       children: [
//                         PatientRowDetailInfo(
//                           label: "first_name".tr,
//                           value: "Akhmad",
//                         ),
//                         SizedBox(height: 10),
//                         PatientRowDetailInfo(
//                           label: "last_name".tr,
//                           value: "Akhmad",
//                         ),
//                         SizedBox(height: 10),
//                         PatientRowDetailInfo(
//                           label: "middle_name".tr,
//                           value: "Akhmad",
//                         ),
//                         SizedBox(height: 10),
//                         PatientRowDetailInfo(
//                           label: "birthday".tr,
//                           value: DateFormatter.birthday(DateTime.now()),
//                         ),
//                         SizedBox(height: 10),
//                         PatientRowDetailInfo(
//                           label: "address".tr,
//                           value: "г. Ташкент, Навоий кучаси",
//                         ),
//                         SizedBox(height: 10),
//                         PatientRowDetailInfo(
//                           label: "complaint".tr,
//                           value:
//                               "фываолдфыов афылваождф ыловадфыоваджфыо вждалофыжвало",
//                         ),
//                       ],
//                     ),
//                   ),
//                   SectionInfo(
//                     title: "analysis_data".tr,
//                     text:
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                   ),
//
//                   Container(
//                     margin: EdgeInsets.symmetric(vertical: 15),
//                     decoration: BoxDecoration(
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     height: 180,
//                     child: Center(
//                       child: Text("Image", style: WorkSansStyle.headline2),
//                     ),
//                   ),
//
//                   SectionInfo(
//                     title: "diagnosis".tr,
//                     text:
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/core/design_system/widgets/buttons.dart';
import 'package:doctor_app/core/enums/issue_pop_up_menu.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/utils/asset_finder.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/issue_detail/presentation/widgets/patient_row_detail_info.dart';
import 'package:doctor_app/features/issue_detail/presentation/widgets/section_info.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:doctor_app/features/shared/domain/models/issue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          "",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          snackStyle: SnackStyle.FLOATING,
          titleText: Text(
            "archived".tr,
            style: WorkSansStyle.labelLarge.copyWith(color: Colors.white),
          ),
          messageText: Text(
            "issue_archived_successfully".tr,
            style: WorkSansStyle.label.copyWith(color: Colors.white),
          ),
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
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text("${"card".tr} №23"),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<IssuePopUpMenu>(
                value: IssuePopUpMenu.archive,
                child: Text('archive'.tr),
              ),
            ],
            onSelected: (value) {
              if (value == IssuePopUpMenu.archive) {
                _showArchiveDialog();
              }
            },
          ),
        ],
      ),

      floatingActionButton: isAccepted
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () {
                Get.toNamed(Routes.chat, arguments: issue);
              },
              child: SvgPicture.asset(AssetFinder.icon('chat'), height: 28),
            )
          : null,

      bottomNavigationBar:
          (!isAccepted && issue != null && issue!.inactiveAt == null)
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ShadButton.secondary(
                        child: Text('cancel'.tr),
                        onPressed: () {
                          setState(() => isAccepted = false);
                          Get.snackbar(
                            "declined".tr,
                            "appointment_declined".tr,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        child: Text('accept'.tr),
                        onTap: () {
                          setState(() => isAccepted = true);
                          Get.snackbar(
                            "accepted".tr,
                            "appointment_accepted".tr,
                            backgroundColor: Colors.green,
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
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  Text(
                    "patient_information".tr,
                    style: WorkSansStyle.headline4,
                  ),
                  const SizedBox(height: 15),

                  // Example patient info
                  Column(
                    children: [
                      PatientRowDetailInfo(
                        label: "first_name".tr,
                        value: issue?.patient?.fullName ?? "Akhmad",
                      ),
                      const SizedBox(height: 10),
                      PatientRowDetailInfo(
                        label: "birthday".tr,
                        value: DateFormatter.birthday(
                          issue?.birthdate ?? DateTime.now(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PatientRowDetailInfo(
                        label: "address".tr,
                        value: issue?.address ?? "г. Ташкент, Навоий кучаси",
                      ),
                      const SizedBox(height: 10),
                      PatientRowDetailInfo(
                        label: "complaint".tr,
                        value:
                            issue?.issue ??
                            "фываолдфыов афылваождф ыловадфыоваджфыо вждалофыжвало",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SectionInfo(
                    title: "analysis_data".tr,
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightGray),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 180,
                    child: Center(
                      child: Text("Image", style: WorkSansStyle.headline2),
                    ),
                  ),

                  SectionInfo(
                    title: "diagnosis".tr,
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
                  ),
                ],
              ),
      ),
    );
  }

  void _showArchiveDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.archive_outlined, size: 48),
              const SizedBox(height: 16),
              Text(
                "archive_alert".tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ShadButton.secondary(
                      child: Text('no'.tr),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ShadButton(
                      backgroundColor: AppColors.primary,
                      child: Text('yes'.tr),
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
