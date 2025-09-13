import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../core/pages/routes.dart';

class OnboardController extends GetxController {
  Rxn<String> selectedLang = Rxn(null);
  final SecureStorageService _storage = SecureStorageService();
  var isLoading = false.obs;
  var isLangSelected = false.obs;
  var loadingUser = false.obs;

  Future<void> config() async {
    isLoading.value = true;
    final savedLang = await _storage.getLang();
    final user = await _storage.getUser();

    if (savedLang == null) {
      Get.toNamed(Routes.lang);
      isLangSelected(false);
      return;
    }
    selectedLang.value = savedLang;
    Get.updateLocale(Locale(savedLang));
    isLangSelected(true);

    if (user == null) {
      Get.offAndToNamed(Routes.login);
      return;
    }
    isLoading(true);
    await Future.delayed(Duration(seconds: 1));
    await Get.offAllNamed(Routes.main);
    isLoading(false);
  }

  Future<void> setLang(String lang) async {
    selectedLang.value = lang;
    await _storage.saveLang(lang);
    Get.updateLocale(Locale(lang));
  }
}
