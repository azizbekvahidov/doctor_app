import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/auth/domain/models/login_data.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';

import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myid/enums.dart';
import 'package:myid/myid.dart';
import 'package:myid/myid_config.dart';

import '../../../../core/design_system/styles/text_styles.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final SecureStorageService secureStorageService = SecureStorageService();
  final OnboardController onboardController = Get.find<OnboardController>();

  AuthController(this.authRepository);

  final TextEditingController pinflController = TextEditingController();

  var isAuthorization = false.obs;
  var isLangSelected = false.obs;
  var isTextFieldEmpty = false.obs;

  Future<void> login() async {
    try {
      String pinfl = pinflController.text.trim().replaceAll('-', '');

      if (pinfl.isEmpty) {
        isTextFieldEmpty(true);
        await Future.delayed(Duration(seconds: 1));
        isTextFieldEmpty(false);
        // Notifier.showSnackbar(
        //   content: Text(
        //     'Iltimos JSHSHRni kiriting!',
        //     style: WorkSansStyle.titleSmall.copyWith(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 15,
        //     ),
        //   ),
        // );

        return;
      }
      isAuthorization(true);
      await Future.delayed(Durations.extralong1);
      LoginData? loginData = await authRepository.login(pinfl);

      if (loginData == null) {
        Notifier.showSnackbar(
          content: Text(
            'JSHSHR bo\'yicha ma\'lumotlar mavjud emas!',
            style: WorkSansStyle.titleSmall.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        );
        return;
      }
      await secureStorageService.saveToken(loginData.token!);
      String registeredAt =
          loginData.user!.registeredAt ?? DateTime.now().toString();
      if (registeredAt.isEmpty) {
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

    await Get.offAllNamed(Routes.onboard)?.then((value) {
      Notifier.showSnackbar(
        content: Text(
          'Tizimdan chiqildi!',
          style: WorkSansStyle.titleSmall.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1500),
      );
    });
  }
}
