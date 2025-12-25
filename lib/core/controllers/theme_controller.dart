import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';

class ThemeController extends GetxController {
  static const String _themeKey = 'is_dark_mode';

  final SecureStorageService _storage = SecureStorageService();
  final RxBool isDarkMode = true.obs; // Default to dark mode based on design

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final savedTheme = await _storage.read(_themeKey);
    if (savedTheme != null) {
      isDarkMode.value = savedTheme == 'true';
    }
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await _storage.write(_themeKey, isDarkMode.value.toString());
  }

  Future<void> setDarkMode(bool value) async {
    isDarkMode.value = value;
    await _storage.write(_themeKey, value.toString());
  }

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}
