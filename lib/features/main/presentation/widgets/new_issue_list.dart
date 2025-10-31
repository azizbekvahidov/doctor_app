import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'announcement_list.dart';
import 'new_card.dart';

class ActiveIssueList extends GetView<IssueController> {
  const ActiveIssueList({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !controller.isMoreLoading.value) {
        controller.getNextPage();
      }
    });

    return Obx(() {
      final issues = controller.issues;

      return AnnouncementList(
        title: "active_ann".tr,
        height: 260,
        child: controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : issues.isNotEmpty
            ? ListView.separated(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: issues.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  if (index < issues.length) {
                    final issue = issues[index];

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            );

                        return SlideTransition(
                          position: offsetAnimation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: NewCard(
                        issue: issue,
                        key: ValueKey(issue.id),
                        onClick: () {
                          Get.toNamed(Routes.detail, arguments: issue);
                        },
                      ),
                    );
                  } else {
                    return controller.isMoreLoading.value
                        ? const SizedBox(
                            width: 80,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }
                },
              )
            : Center(child: Text("no_active_ann".tr)),
      );
    });
  }
}
