import 'dart:convert';

class User {
  int? id;
  String? pinfl;
  String? lastName;
  String? firstName;
  String? middleName;
  DateTime? birthdate;
  dynamic email;
  dynamic phone;
  dynamic degree;
  dynamic profession;
  dynamic approvedByModeratorAt;
  dynamic status;
  Description? description;
  dynamic socialNetwork;
  Settings? settings;
  String? registeredAt;
  Avatar? avatar;
  List<dynamic>? documents;

  User({
    this.id,
    this.pinfl,
    this.lastName,
    this.firstName,
    this.middleName,
    this.birthdate,
    this.email,
    this.phone,
    this.degree,
    this.profession,
    this.approvedByModeratorAt,
    this.status,
    this.description,
    this.socialNetwork,
    this.settings,
    this.registeredAt,
    this.avatar,
    this.documents,
  });

  User copyWith({
    int? id,
    String? pinfl,
    String? lastName,
    String? firstName,
    String? middleName,
    DateTime? birthdate,
    dynamic email,
    dynamic phone,
    dynamic degree,
    dynamic profession,
    dynamic approvedByModeratorAt,
    dynamic status,
    Description? description,
    dynamic socialNetwork,
    Settings? settings,
    String? registeredAt,
    Avatar? avatar,
    List<dynamic>? documents,
  }) => User(
    id: id ?? this.id,
    pinfl: pinfl ?? this.pinfl,
    lastName: lastName ?? this.lastName,
    firstName: firstName ?? this.firstName,
    middleName: middleName ?? this.middleName,
    birthdate: birthdate ?? this.birthdate,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    degree: degree ?? this.degree,
    profession: profession ?? this.profession,
    approvedByModeratorAt: approvedByModeratorAt ?? this.approvedByModeratorAt,
    status: status ?? this.status,
    description: description ?? this.description,
    socialNetwork: socialNetwork ?? this.socialNetwork,
    settings: settings ?? this.settings,
    registeredAt: registeredAt ?? this.registeredAt,
    avatar: avatar ?? this.avatar,
    documents: documents ?? this.documents,
  );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    pinfl: json["pinfl"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    birthdate: json["birthdate"] == null
        ? null
        : DateTime.parse(json["birthdate"]),
    email: json["email"],
    phone: json["phone"],
    degree: json["degree"],
    profession: json["profession"],
    approvedByModeratorAt: json["approved_by_moderator_at"],
    status: json["status"],
    description: json["description"] == null
        ? null
        : Description.fromJson(json["description"]),
    socialNetwork: json["social_network"],
    settings: json["settings"] == null
        ? null
        : Settings.fromJson(json["settings"]),
    registeredAt: json["registered_at"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    documents: json["documents"] == null
        ? []
        : List<dynamic>.from(json["documents"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pinfl": pinfl,
    "last_name": lastName,
    "first_name": firstName,
    "middle_name": middleName,
    "birthdate":
        "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
    "email": email,
    "phone": phone,
    "degree": degree,
    "profession": profession,
    "approved_by_moderator_at": approvedByModeratorAt,
    "status": status,
    "description": description?.toJson(),
    "social_network": socialNetwork,
    "settings": settings?.toJson(),
    "registered_at": registeredAt,
    "avatar": avatar?.toJson(),
    "documents": documents == null
        ? []
        : List<dynamic>.from(documents!.map((x) => x)),
  };
}

class Avatar {
  dynamic url;
  dynamic size;
  dynamic name;

  Avatar({this.url, this.size, this.name});

  Avatar copyWith({dynamic url, dynamic size, dynamic name}) => Avatar(
    url: url ?? this.url,
    size: size ?? this.size,
    name: name ?? this.name,
  );

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) =>
      Avatar(url: json["url"], size: json["size"], name: json["name"]);

  Map<String, dynamic> toJson() => {"url": url, "size": size, "name": name};
}

class Description {
  dynamic uz;
  dynamic ru;

  Description({this.uz, this.ru});

  Description copyWith({dynamic uz, dynamic ru}) =>
      Description(uz: uz ?? this.uz, ru: ru ?? this.ru);

  factory Description.fromRawJson(String str) =>
      Description.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Description.fromJson(Map<String, dynamic> json) =>
      Description(uz: json["uz"], ru: json["ru"]);

  Map<String, dynamic> toJson() => {"uz": uz, "ru": ru};
}

class Settings {
  dynamic language;
  dynamic experienceFrom;

  Settings({this.language, this.experienceFrom});

  Settings copyWith({dynamic language, dynamic experienceFrom}) => Settings(
    language: language ?? this.language,
    experienceFrom: experienceFrom ?? this.experienceFrom,
  );

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    language: json["language"],
    experienceFrom: json["experience_from"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "experience_from": experienceFrom,
  };
}
