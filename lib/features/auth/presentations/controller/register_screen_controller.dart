import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/formatters.dart';
import 'package:doctor_app/features/auth/domain/models/personal_data_form.dart';
import 'package:doctor_app/features/auth/domain/models/user.dart';
import 'package:get/get.dart';

class RegisterScreenController extends GetxController {
  Rxn<PersonalFormData> personalFormData = Rxn<PersonalFormData>();

  final storage = SecureStorageService();

  @override
  void onInit() {
    super.onInit();
    personalFormData.value = PersonalFormData(); // 👈 always initialized
  }

  void save(PersonalFormData data) {
    personalFormData.value = data;
  }

  getUser() async {
    User? user = await storage.getUser();

    if (user != null) {
      personalFormData.value = PersonalFormData(
        firstName: user.firstName,
        lastName: user.lastName,
        middleName: user.middleName,
        birthday: user.birthdate != null
            ? DateFormatter.birthday(user.birthdate!)
            : null,
        phoneNumber: user.phone,
        email: user.email,
        aboutRu: user.description?.ru,
        aboutUz: user.description?.uz,
        experienceForm: user.settings?.experienceFrom,
        instagramUsername: user.socialNetwork?.instagram ?? "",
        telegramUsername: user.socialNetwork?.telegram ?? "",
      );
    }
  }
}
