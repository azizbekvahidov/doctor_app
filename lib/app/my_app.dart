import 'package:doctor_app/core/languages.dart';
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
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadZincColorScheme.light(),
      ),
      home: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: Locale(onboardController.selectedLang.value),
        fallbackLocale: const Locale("en"),
        initialRoute: Routes.register,
        getPages: AppPages.pages,
      ),
    );
  }
}
