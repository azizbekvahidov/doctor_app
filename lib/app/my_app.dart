import 'package:doctor_app/core/bindings/app_bindings.dart';
import 'package:doctor_app/core/config/app_config.dart';
import 'package:doctor_app/core/controllers/theme_controller.dart';
import 'package:doctor_app/core/design_system/styles/app_colors.dart';
import 'package:doctor_app/core/languages.dart';
import 'package:doctor_app/core/navigation/pages.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../core/utils/notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Light theme
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.black54,
          indicatorColor: AppColors.primary,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.grey),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          surface: AppColors.surface,
          onSurface: Colors.black87,
        ),
      );

  // Dark theme
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        primaryColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.darkTextSecondary,
        ),
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          surface: AppColors.darkSurface,
        ),
      );

  @override
  Widget build(BuildContext context) {
    AppConfig.screenSize = MediaQuery.of(context).size;
    AppConfig.padding = MediaQuery.of(context).padding;

    final OnboardController onboardController = Get.put(OnboardController());
    final ThemeController themeController =
        Get.put(ThemeController(), permanent: true);

    return Obx(() {
      final isDark = themeController.isDarkMode.value;

      return ShadApp.custom(
        appBuilder: (context) {
          return GetMaterialApp(
            initialBinding: AppBindings(),
            scaffoldMessengerKey: Notifier.messengerKey,
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            locale: Locale(onboardController.selectedLang.value ?? "uz"),
            fallbackLocale: const Locale("en"),
            initialRoute: AppPages.initial,
            getPages: AppPages.pages,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
        theme: ShadThemeData(
          brightness: isDark ? Brightness.dark : Brightness.light,
          colorScheme: isDark
              ? const ShadZincColorScheme.dark()
              : ShadColorScheme.fromName('zinc', brightness: Brightness.light).copyWith(
                  foreground: Colors.black87,
                  primary: AppColors.primary,
                  primaryForeground: Colors.white,
                ),
        ),
      );
    });
  }
}
