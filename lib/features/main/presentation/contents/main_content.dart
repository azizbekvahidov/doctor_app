import 'package:doctor_app/core/enums/contents.dart';
import 'package:doctor_app/features/main/presentation/contents/archive_content.dart';
import 'package:doctor_app/features/main/presentation/contents/home_content.dart';
import 'package:doctor_app/features/main/presentation/controller/main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainContent extends GetView<MainPageController> {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // from right
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
        },
        child: controller.content.value == Contents.home
            ? const HomeContent(key: ValueKey('home'))
            : const ArchiveContent(key: ValueKey('archive')),
      );
    });
  }
}
