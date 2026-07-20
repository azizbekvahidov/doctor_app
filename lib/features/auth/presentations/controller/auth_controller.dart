import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/core/utils/notifier.dart';
import 'package:doctor_app/features/auth/domain/models/auth_data.dart';
import 'package:doctor_app/features/auth/domain/models/personal_data_form.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';
import 'package:doctor_app/features/auth/presentations/controller/register_screen_controller.dart';
import 'package:doctor_app/features/shared/controllers/issue_controller.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';

import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myid/enums.dart';
import 'package:myid/myid.dart';
import 'package:myid/myid_config.dart';

import '../../../../core/design_system/styles/text_styles.dart';
import '../../domain/models/user.dart';

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

  AuthController(this.authRepository);

  final SecureStorageService secureStorageService = SecureStorageService();
  final OnboardController onboardController = Get.find<OnboardController>();
  final TextEditingController pinflController = TextEditingController();

  // Obx variables
  var isAuthorization = false.obs;
  var isLangSelected = false.obs;
  var isTextFieldEmpty = false.obs;

  // Normal Variables
  User? user;
  String? token;

  @override
  void onInit() {
    isAuthorization.value = false;

    super.onInit();
  }

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
      AuthData? authData = await authRepository.login(pinfl);
      await Future.delayed(Durations.extralong1);
      if (authData == null) {
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
      token = authData.token;
      user = authData.user;
      if (token == null || user == null) {
        isAuthorization.value = false;
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
      await secureStorageService.saveUser(user!.toRawJson());
      await secureStorageService.saveToken(token!);
      String registeredAt = user!.registeredAt != null
          ? user!.registeredAt.toString()
          : "";
      isAuthorization.value = false;
      if (registeredAt.isEmpty) {
        Get.toNamed(Routes.identification);
      } else {
        myIdRegister(isRegisteredAt: true);
      }
    } catch (e) {
      LogHelper.error("Error:$e");
    }
  }

  Future<void> register() async {
    isAuthorization.value = true;
    final RegisterScreenController registerScreenController =
        Get.find<RegisterScreenController>();

    try {
      PersonalFormData? personalData =
          registerScreenController.personalFormData.value;
      if (personalData == null) {
        return;
      }
      final lang = await secureStorageService.getLang();
      personalData = personalData.copyWith(language: lang);
      final personalDataMap = personalData.prepareJsonToSend(
        degreeId: 1,
        professionId: 1,
        degreeObject: degrees[personalData.degree],
        professionObject: professions[personalData.profession],
      );

      final isRegistered = await authRepository.register(personalDataMap);
      if (isRegistered) {
        Notifier.showSnackbar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          content: Text("register_success".tr, style: WorkSansStyle.label),
        );
        await Future.delayed(Duration(milliseconds: 2250));
        await Get.offAllNamed(Routes.onboard);
      } else {
        Notifier.showSnackbar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          content: Text(
            "Ma'lumotlarni saqlashda xatolik yuz berdi",
            style: WorkSansStyle.label,
          ),
        );
      }
    } catch (e) {
      LogHelper.error(e.toString());
    } finally {
      isAuthorization.value = false;
    }
  }

  Future<void> myIdRegister({bool isRegisteredAt = false}) async {
    isAuthorization.value = false;
    try {
      MyIdResult result = await MyIdClient.start(
        config: MyIdConfig(
          environment: MyIdEnvironment.DEBUG,
          clientId: '',
          entryType: MyIdEntryType.FACE_DETECTION,
        ),
        iosAppearance: MyIdIOSAppearance(),
      );
      LogHelper.warning("BASE64: ${result.base64}");
      LogHelper.warning("CODE: ${result.code}");
      LogHelper.warning("COMP: ${result.comparison}");
      if (result.code == null ||
          result.code == "CANCELLED" ||
          result.code == "USER_CANCELLED") {
        return;
      }

      if (result.base64 != null) {
        if (isRegisteredAt) {
          await Get.toNamed(Routes.onboard);
        } else {
          await Get.toNamed(Routes.register);
        }
      } else {
        LogHelper.error("Face detection failed with code: ${result.code}");
      }
    } on PlatformException catch (e) {
      LogHelper.warning("ERROR: ${e.toString()}");
    } catch (e) {
      LogHelper.error(e.toString());
    }
  }

  Future<void> logout() async {
    isAuthorization.value = false;

    // Best-effort server-side session invalidation; proceed with local cleanup
    // even if it fails so the device never stays logged in.
    try {
      await authRepository.logout();
    } catch (e) {
      LogHelper.error("Server logout failed: $e");
    }

    await secureStorageService.deleteToken();
    await secureStorageService.deleteUser();

    // Clear cached per-account state so a subsequent login can't see the
    // previous doctor's profile, issues, or chat.
    if (Get.isRegistered<UserController>()) {
      Get.find<UserController>().user.value = null;
    }
    if (Get.isRegistered<IssueController>()) {
      Get.find<IssueController>().reset();
    }

    user = null;
    token = null;

    Get.offAllNamed(Routes.onboard);
  }
}
