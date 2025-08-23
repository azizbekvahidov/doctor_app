import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../core/pages/routes.dart';
import '../../auth/domain/models/user.dart';

class OnboardController extends GetxController {
  RxString selectedLang = RxString("uz");
  final SecureStorageService _storage = SecureStorageService();
  var isLoading = false.obs;
  var isLangSelected = false.obs;

  Rxn<User> user = Rxn(null);

  @override
  void onInit() {
    super.onInit();

    getUser();
  }

  getUser() async {
    user.value = await _storage.getUser();
  }

  Future<void> config() async {
    final saved = await _storage.getLang();
    final user = await _storage.getUser();

    if (saved == null) {
      Get.toNamed(Routes.lang);
      isLangSelected(false);
      return;
    }
    selectedLang.value = saved;
    Get.updateLocale(Locale(saved));
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
