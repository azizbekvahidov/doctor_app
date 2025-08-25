import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalFormData {
  final String firstName;
  final String lastName;
  final String middleName;
  final String email;
  final String birthday;
  final int experience;
  final String phoneNumber;
  final String degree;
  final String profession;
  final String aboutUz;
  final String aboutRu;
  final String telegramUsername;
  final String instagramUsername;

  PersonalFormData({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.email,
    required this.birthday,
    required this.experience,
    required this.phoneNumber,
    required this.degree,
    required this.profession,
    required this.aboutUz,
    required this.aboutRu,
    required this.telegramUsername,
    required this.instagramUsername,
  });

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "middle_name": middleName,
    "email": email,
    "birthday": birthday,
    "experience": experience,
    "phone_number": phoneNumber,
    "degree": degree,
    "profession": profession,
    "about_uz": aboutUz,
    "about_ru": aboutRu,
    "telegram_username": telegramUsername,
    "instagram_username": instagramUsername,
  };
}

class RegisterScreenController extends GetxController {
  Rxn<PersonalFormData> personalFomrData = Rxn<PersonalFormData>(null);
  save(PersonalFormData personalFormData) {
    personalFomrData.value = personalFormData;
  }

  int calculateExperience(String input) {
    if (input.isEmpty) return 0;

    try {
      final startDate = DateFormat("dd-MM-yyyy").parse(input);
      final now = DateTime.now();

      int years = now.year - startDate.year;

      // Adjust if "anniversary" not yet reached this year
      if (now.month < startDate.month ||
          (now.month == startDate.month && now.day < startDate.day)) {
        years--;
      }

      return years < 0 ? 0 : years; // avoid negatives
    } catch (e) {
      return 0; // fallback if parsing fails
    }
  }
}
