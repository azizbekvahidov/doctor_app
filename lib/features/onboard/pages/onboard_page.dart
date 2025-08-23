import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final OnboardController controller = Get.find<OnboardController>();

  @override
  void initState() {
    controller.config();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? CircularProgressIndicator()
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
