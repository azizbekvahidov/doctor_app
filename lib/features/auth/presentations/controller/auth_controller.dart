import 'package:doctor_app/core/pages/routes.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/auth/domain/models/auth_data.dart';
import 'package:doctor_app/features/auth/domain/models/personal_data_form.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';
import 'package:doctor_app/features/auth/presentations/controller/register_screen_controller.dart';

import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myid/enums.dart';
import 'package:myid/myid.dart';
import 'package:myid/myid_config.dart';

import '../../../../core/design_system/styles/text_styles.dart';

// --- Medical Degrees ---
Map<String, dynamic> degrees = {
  "bachelor": {"name_uz": "Bakalavr", "name_ru": "Бакалавр"},
  "master": {"name_uz": "Magistr", "name_ru": "Магистр"},
  "phd": {
    "name_uz": "PhD (Falsafa doktori)",
    "name_ru": "PhD (Доктор философии)",
  },
  "docent": {"name_uz": "Dotsent", "name_ru": "Доцент"},
  "professor": {"name_uz": "Professor", "name_ru": "Профессор"},
  "resident": {"name_uz": "Rezident", "name_ru": "Резидент"},
  "intern": {"name_uz": "Intern", "name_ru": "Интерн"},
  "specialist": {"name_uz": "Mutaxassis", "name_ru": "Специалист"},
  "doctor_sciences": {"name_uz": "Fan doktori", "name_ru": "Доктор наук"},
};

// --- Medical Professions ---
Map<String, dynamic> professions = {
  "general_practitioner": {"name_uz": "Terapevt", "name_ru": "Терапевт"},
  "dentist": {"name_uz": "Stomatolog", "name_ru": "Стоматолог"},
  "surgeon": {"name_uz": "Jarroh", "name_ru": "Хирург"},
  "pediatrician": {"name_uz": "Pediatr", "name_ru": "Педиатр"},
  "cardiologist": {"name_uz": "Kardiolog", "name_ru": "Кардиолог"},
  "neurologist": {"name_uz": "Nevrolog", "name_ru": "Невролог"},
  "oncologist": {"name_uz": "Onkolog", "name_ru": "Онколог"},
  "orthopedist": {"name_uz": "Ortoped", "name_ru": "Ортопед"},
  "gynecologist": {"name_uz": "Ginekolog", "name_ru": "Гинеколог"},
  "urologist": {"name_uz": "Urolog", "name_ru": "Уролог"},
  "dermatologist": {"name_uz": "Dermatolog", "name_ru": "Дерматолог"},
  "psychiatrist": {"name_uz": "Psixiatr", "name_ru": "Психиатр"},
  "radiologist": {"name_uz": "Rentgenolog", "name_ru": "Рентгенолог"},
  "ophthalmologist": {"name_uz": "Oftalmolog", "name_ru": "Офтальмолог"},
  "anesthesiologist": {"name_uz": "Anesteziolog", "name_ru": "Анестезиолог"},
  "endocrinologist": {"name_uz": "Endokrinolog", "name_ru": "Эндокринолог"},
  "family_doctor": {"name_uz": "Oilaviy shifokor", "name_ru": "Семейный врач"},
};

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
      String pinfl = pinflController.text.trim();

      if (pinfl.isEmpty) {
        isTextFieldEmpty(true);
        await Future.delayed(Duration(seconds: 1));
        isTextFieldEmpty(false);
        return;
      }
      isAuthorization.value = true;
      await Future.delayed(Durations.extralong1);
      AuthData? loginData = await authRepository.login(pinfl);

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
      await secureStorageService.saveUser(loginData.user!.toRawJson());
      await secureStorageService.saveToken(loginData.token!);
      String registeredAt = loginData.user!.registeredAt != null
          ? loginData.user!.registeredAt.toString()
          : "";
      if (registeredAt.isEmpty) {
        Get.toNamed(Routes.identification);
        return;
      } else {
        isAuthorization.value = false;
        myIdRegister(isRegisteredAt: true);
      }

      onboardController.getUser();
      await Future.delayed(Durations.medium3);
      await Get.offAllNamed(Routes.main);
    } catch (e) {
      LogHelper.error("Error:$e");
    } finally {
      isAuthorization.value = false;
    }
  }

  Future<void> register() async {
    isAuthorization.value = true;
    final RegisterScreenController registerScreenController =
        Get.find<RegisterScreenController>();

    try {
      PersonalFormData persondalData =
          registerScreenController.personalFormData.value!;
      final lang = await secureStorageService.getLang();
      persondalData = persondalData.copyWith(language: lang);
      final personalDataMap = persondalData.prepareJsonToSend(
        degreeId: 1,
        professionId: 1,
        degreeObject:
            degrees[registerScreenController.personalFormData.value!.degree],
        professionObject:
            professions[registerScreenController
                .personalFormData
                .value!
                .profession],
      );

      final isRegistered = await authRepository.register(personalDataMap);
      if (isRegistered) {
        Notifier.showSnackbar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          content: Text("register_success".tr, style: WorkSansStyle.label),
        );
        isAuthorization.value = false;
        await onboardController.getUser();
        await Future.delayed(Duration(milliseconds: 2250));
        await Get.toNamed(Routes.onboard);
      }
    } catch (e) {
      LogHelper.error(e.toString());
    }
  }

  Future<void> myIdRegister({bool isRegisteredAt = false}) async {
    MyIdResult result = await MyIdClient.start(
      config: MyIdConfig(
        environment: MyIdEnvironment.DEBUG,
        clientId: '',
        entryType: MyIdEntryType.FACE_DETECTION,
      ),
      iosAppearance: MyIdIOSAppearance(),
    );
    print("RES:${result}");
    LogHelper.error("BASE: ${result.base64}");
    LogHelper.error("Code: ${result.code}");
    LogHelper.error("Comparison: ${result.comparison}");

    if (result.base64 != null) {
      if (isRegisteredAt) {
        await Get.toNamed(Routes.main);
      } else {
        await Get.toNamed(Routes.register);
      }
    }
  }

  Future<void> logout() async {
    isAuthorization.value = false;
    await secureStorageService.deleteToken();
    await secureStorageService.deleteUser();

    Get.offAllNamed(Routes.onboard)?.then((value) {
      Notifier.showSnackbar(
        content: Text(
          'logout'.tr,
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
