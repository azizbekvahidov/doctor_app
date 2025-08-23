import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/auth/domain/models/login_data.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';
import 'package:doctor_app/features/auth/presentations/pages/login_page.dart';
import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myid/enums.dart';
import 'package:myid/myid.dart';
import 'package:myid/myid_config.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final SecureStorageService secureStorageService = SecureStorageService();
  final OnboardController onboardController = Get.find<OnboardController>();

  AuthController(this.authRepository);

  final TextEditingController pinflController = TextEditingController();

  // Holds the current widget to display
  var currentWidget = Rx<Widget>(LoginPage());
  var isAuthorization = false.obs;
  var isLangSelected = false.obs;

  Future<void> login() async {
    isAuthorization(true);

    try {
      String pinfl = pinflController.text.trim();
      if (pinfl.isEmpty) {
        Get.snackbar(
          "Xatolik!",
          "",
          messageText: Text(
            "Iltimos JSHSHR raqamingizni kiriting",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await Future.delayed(Durations.extralong1);
      LoginData? loginData = await authRepository.login(pinfl);

      if (loginData == null) {
        Get.snackbar(
          "Xatolik!",
          "",
          messageText: Text(
            "Ma'lumot mavjud emas",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      await secureStorageService.saveToken(loginData.token!);

      if (loginData.user!.registeredAt == null) {
        Get.toNamed(Routes.identification);
        return;
      }
      await secureStorageService.saveUser(loginData.user!.toRawJson());
      onboardController.getUser();
      await Future.delayed(Durations.medium3);
      await Get.offAllNamed(Routes.main);
    } catch (e) {
      LogHelper.error("Error:$e");
    } finally {
      isAuthorization(false);
    }
  }

  Future<void> register() async {
    isAuthorization(true);
    await Future.delayed(Durations.extralong4);
    try {
      var result = await MyIdClient.start(
        config: MyIdConfig(
          environment: MyIdEnvironment.DEBUG,
          clientId: '',
          entryType: MyIdEntryType.FACE_DETECTION,
        ),
        iosAppearance: MyIdIOSAppearance(),
      );
      LogHelper.info("MyId Code:${result.code}");
    } catch (e) {
      LogHelper.error("ERROR: $e");
    } finally {
      isAuthorization(false);
    }
  }

  Future<void> logout() async {
    await secureStorageService.deleteToken();
    await secureStorageService.deleteUser();
    currentWidget.value = LoginPage();
  }
}
