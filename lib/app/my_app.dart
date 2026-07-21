import 'package:doctor_app/core/bindings/app_bindings.dart';
import 'package:doctor_app/core/config/app_config.dart';
import 'package:doctor_app/core/languages.dart';
import 'package:doctor_app/core/navigation/pages.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/design_system/styles/app_text.dart';
import 'package:doctor_app/core/dev/dev_tools_overlay.dart';
import 'package:doctor_app/core/services/alice_service.dart';
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

    return ShadApp.custom(
      appBuilder: (context) {
        return GetMaterialApp(
          initialBinding: AppBindings(),
          navigatorKey: AliceService.navigatorKey,
          scaffoldMessengerKey: Notifier.messengerKey,
          debugShowCheckedModeBanner: false,
          // Floating dev-tools button (Alice inspector) above every screen.
          builder: (context, child) =>
              DevToolsOverlay(child: child ?? const SizedBox.shrink()),
          translations: AppTranslations(),
          locale: Locale(onboardController.selectedLang.value ?? "uz"),
          fallbackLocale: const Locale("en"),
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.bg, // warm stone (v2)
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              surface: AppColors.surface,
            ),
            textTheme: AppText.textTheme(ThemeData.light().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.bg,
              foregroundColor: AppColors.ink,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
          ),
        );
      },
      theme: ShadThemeData(
        brightness: Brightness.light,

        colorScheme: const ShadZincColorScheme.light(),
      ),
    );
  }
}
