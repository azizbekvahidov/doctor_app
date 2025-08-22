import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
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

  // Future<void> checkAuth() async {
  //   isAuthorization(true);
  //   await Future.delayed(Durations.medium1);
  //   User? user = await secureStorageService.getUser();
  //   if (user != null) {
  //     Get.offAllNamed(Routes.main);
  //   } else {
  //     Get.offNamed(Routes.login);
  //   }
  //   isAuthorization(false);
  // }

  Future<void> login() async {
    isAuthorization(true);
    await Future.delayed(Durations.extralong4);
    try {
      String pinfl = pinflController.text.trim();
      if (pinfl.isNotEmpty) {
        LoginData? loginData = await authRepository.login(pinfl);

        if (loginData != null) {
          await secureStorageService.saveToken(loginData.token!);
          String registeredAt =
              loginData.user!.registeredAt ?? DateTime.now().toString();
          if (registeredAt.isNotEmpty) {
            await secureStorageService.saveUser(loginData.user!.toRawJson());
            onboardController.getUser();
            await Future.delayed(Durations.medium3);
            await Get.offAllNamed(Routes.main);
          } else {
            Get.toNamed(Routes.identification);
          }
        }
      }
    } catch (e) {
      print("Error:$e");
    } finally {
      isAuthorization(false);
    }
  }

  Future<void> register() async {
    isAuthorization(true);
    await Future.delayed(Durations.extralong4);
    try {
      var result = await MyIdClient.start(
        config: MyIdConfig(environment: MyIdEnvironment.DEBUG, clientId: '11'),
        iosAppearance: MyIdIOSAppearance(),
      );
    } catch (e) {
      print("ERROR: $e");
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
