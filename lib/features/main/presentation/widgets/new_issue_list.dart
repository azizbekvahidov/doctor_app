import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'announcement_list.dart';
import 'new_card.dart';
class NewIssueList extends GetView<IssueController> {
  const NewIssueList({super.key});

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

      if (controller.isLoading.value && issues.isEmpty) {
        return const SizedBox(
          height: 260,
          child: Center(
            child: CircularProgressIndicator(color: Colors.black),
          ),
        );
      }

      if (issues.isEmpty) {
        return const SizedBox.shrink();
      }

      return AnnouncementList(
        title: "new_ann".tr,
        height: 260,
        child: ListView.separated(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: issues.length + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            if (index < issues.length) {
              final issue = issues[index];

              // 🌀 Each item animates when it appears
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.3, 0), // slide from right
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ));

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: NewCard(
                  key: ValueKey(issue.id),
                  onClick: () {
                    Get.toNamed(Routes.detail);
                  },
                ),
              );
            } else {
              // 🔄 Loading indicator for pagination
              return controller.isMoreLoading.value
                  ? const SizedBox(
                width: 80,
                child: Center(child: CircularProgressIndicator()),
              )
                  : const SizedBox.shrink();
            }
          },
        ),
      );
    });
  }
}
