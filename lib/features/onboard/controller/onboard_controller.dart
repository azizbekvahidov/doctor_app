import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/features/main/main_page.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  RxnString selectedLang = RxnString("uz");
  final SecureStorageService _storage = SecureStorageService();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getLang();
  }

  Future<void> getLang() async {
    isLoading(true);
    final saved = await _storage.getLang();
    if (saved != null) {
      selectedLang.value = saved;
      Get.updateLocale(Locale(saved));

      Get.offAll(MainPage());
    }
    await Future.delayed(Duration(milliseconds: 1000));
    isLoading(false);
  }

  Future<void> setLang(String lang) async {
    selectedLang.value = lang;
    await _storage.saveLang(lang);
    Get.updateLocale(Locale(lang));
  }
}
