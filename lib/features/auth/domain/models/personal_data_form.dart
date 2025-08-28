class PersonalFormData {
  final String? pinfl;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? birthday;
  final String? experienceForm;
  final String? phoneNumber;
  final String? degree;
  final String? profession;
  final String? aboutUz;
  final String? aboutRu;
  final String? telegramUsername;
  final String? instagramUsername;
  final String? language;

  PersonalFormData({
    this.pinfl,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.birthday,
    this.experienceForm,
    this.phoneNumber,
    this.degree,
    this.profession,
    this.aboutUz,
    this.aboutRu,
    this.telegramUsername,
    this.instagramUsername,
    this.language,
  });

  PersonalFormData copyWith({
    String? pinfl,
    String? firstName,
    String? lastName,
    String? middleName,
    String? email,
    String? birthday,
    String? experienceForm,
    String? phoneNumber,
    String? degree,
    String? profession,
    String? aboutUz,
    String? aboutRu,
    String? telegramUsername,
    String? instagramUsername,
    String? language,
  }) {
    return PersonalFormData(
      pinfl: pinfl ?? this.pinfl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      experienceForm: experienceForm ?? this.experienceForm,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      degree: degree ?? this.degree,
      profession: profession ?? this.profession,
      aboutUz: aboutUz ?? this.aboutUz,
      aboutRu: aboutRu ?? this.aboutRu,
      telegramUsername: telegramUsername ?? this.telegramUsername,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> prepareJsonToSend({
    int? degreeId,
    int? professionId,
    Map<String, String>? degreeObject,
    Map<String, String>? professionObject,
  }) {
    return {
      "phone": phoneNumber,
      "email": email,
      "description_uz": aboutUz,
      "description_ru": aboutRu,

      // Either send IDs if they exist, otherwise send objects
      if (degreeId != null) "degree_id": degreeId,
      if (degreeObject != null) "degree": degreeObject,
      if (professionId != null) "profession_id": professionId,
      if (professionObject != null) "profession": professionObject,

      "social_network": {
        "telegram": telegramUsername,
        "instagram": instagramUsername,
      },

      "settings": {
        "language": language,
        "experience_from": experienceForm, // example: "2010-01-24"
      },
    };
  }
}
