import 'package:doctor_app/core/pages/pages.dart';
import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardController onboardController = Get.put(OnboardController());
    return ShadApp(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadZincColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadZincColorScheme.dark(),
      ),
      home: GetMaterialApp(
        locale: Locale(onboardController.selectedLang.value ?? "uz"),
        fallbackLocale: const Locale("en"),
        initialRoute: Routes.onboard,
        getPages: AppPages.pages,
      ),
    );
  }
}
