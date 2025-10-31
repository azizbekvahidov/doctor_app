import 'package:doctor_app/core/design_system/styles/text_styles.dart';
import 'package:doctor_app/features/main/presentation/controller/main_page_controller.dart';
import 'package:doctor_app/features/main/presentation/widgets/archived_item.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArchiveContent extends GetView<MainPageController> {
  ArchiveContent({super.key});

  final IssueController issueController = Get.find<IssueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "archive".tr,
          style: WorkSansStyle.headline3.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        if (issueController.isLoadingArchivedIssues.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (issueController.archivedIssues.isEmpty) {
          return Center(
            child: Text("no_archived_issues".tr, style: WorkSansStyle.body),
          );
        }
        return ListView.separated(
          itemCount: issueController.archivedIssues.length,
          itemBuilder: (context, index) {
            final archived = issueController.archivedIssues[index];
            return ArchivedItem(archived: archived);
          },
          padding: EdgeInsets.symmetric(horizontal: 15),
          separatorBuilder: (context, index) => SizedBox(height: 10),
        );
      }),
    );
  }
}
