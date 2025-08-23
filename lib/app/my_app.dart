import 'package:doctor_app/core/bindings/app_bindings.dart';
import 'package:doctor_app/core/config/app_config.dart';
import 'package:doctor_app/core/languages.dart';
import 'package:doctor_app/core/pages/pages.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../core/utils/notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfig.screenSize = MediaQuery.of(context).size;
    AppConfig.padding = MediaQuery.of(context).padding;

    final OnboardController onboardController = Get.put(OnboardController());
    return ShadApp(
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadZincColorScheme.light(),
      ),
      home: GetMaterialApp(
        initialBinding: AppBindings(),
        scaffoldMessengerKey: Notifier.messengerKey, // attach here
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: Locale(onboardController.selectedLang.value),
        fallbackLocale: const Locale("en"),
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
      ),
    );
  }
}
