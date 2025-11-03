import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/main/presentation/widgets/header.dart';
import 'package:doctor_app/features/main/presentation/widgets/new_issue_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/controllers/issue_controller.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final issueController = Get.find<IssueController>();

    return RefreshIndicator(
      color: Colors.black,
      onRefresh: () async {
        // 👇 refresh all needed sections
        await issueController.getInitialIssues();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(), // important!
        child: Column(
          children: [
            Header(),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(top: 15),
              child: Column(
                children: [const ActiveIssueList(), const SizedBox(height: 30)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
