import 'dart:convert';

class User {
  int? id;
  String? pinfl;
  String? lastName;
  String? firstName;
  String? middleName;
  DateTime? birthdate;
  String? email;
  String? phone;
  Degree? degree;
  Degree? profession;
  DateTime? approvedByModeratorAt;
  String? status;
  Description? description;
  SocialNetwork? socialNetwork;
  Settings? settings;
  DateTime? registeredAt;
  Avatar? avatar;
  List<Avatar>? documents;

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
    String? email,
    String? phone,
    Degree? degree,
    Degree? profession,
    DateTime? approvedByModeratorAt,
    String? status,
    Description? description,
    SocialNetwork? socialNetwork,
    Settings? settings,
    DateTime? registeredAt,
    Avatar? avatar,
    List<Avatar>? documents,
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
    degree: json["degree"] == null ? null : Degree.fromJson(json["degree"]),
    profession: json["profession"] == null
        ? null
        : Degree.fromJson(json["profession"]),
    approvedByModeratorAt: json["approved_by_moderator_at"] == null
        ? null
        : DateTime.parse(json["approved_by_moderator_at"]),
    status: json["status"],
    description: json["description"] == null
        ? null
        : Description.fromJson(json["description"]),
    socialNetwork: json["social_network"] == null
        ? null
        : SocialNetwork.fromJson(json["social_network"]),
    settings: json["settings"] == null
        ? null
        : Settings.fromJson(json["settings"]),
    registeredAt: json["registered_at"] == null
        ? null
        : DateTime.parse(json["registered_at"]),
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
    documents: json["documents"] == null
        ? []
        : List<Avatar>.from(json["documents"]!.map((x) => Avatar.fromJson(x))),
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
    "degree": degree?.toJson(),
    "profession": profession?.toJson(),
    "approved_by_moderator_at": approvedByModeratorAt?.toIso8601String(),
    "status": status,
    "description": description?.toJson(),
    "social_network": socialNetwork?.toJson(),
    "settings": settings?.toJson(),
    "registered_at": registeredAt?.toIso8601String(),
    "avatar": avatar?.toJson(),
    "documents": documents == null
        ? []
        : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Avatar {
  String? url;
  String? size;
  String? name;
  int? id;

  Avatar({this.url, this.size, this.name, this.id});

  Avatar copyWith({String? url, String? size, String? name, int? id}) => Avatar(
    url: url ?? this.url,
    size: size ?? this.size,
    name: name ?? this.name,
    id: id ?? this.id,
  );

  factory Avatar.fromRawJson(String str) => Avatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    url: json["url"],
    size: json["size"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "size": size,
    "name": name,
    "id": id,
  };
}

class Degree {
  int? id;
  Description? name;

  Degree({this.id, this.name});

  Degree copyWith({int? id, Description? name}) =>
      Degree(id: id ?? this.id, name: name ?? this.name);

  factory Degree.fromRawJson(String str) => Degree.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    name: json["name"] == null ? null : Description.fromJson(json["name"]),
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name?.toJson()};
}

class Description {
  String? uz;
  String? ru;

  Description({this.uz, this.ru});

  Description copyWith({String? uz, String? ru}) =>
      Description(uz: uz ?? this.uz, ru: ru ?? this.ru);

  factory Description.fromRawJson(String str) =>
      Description.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Description.fromJson(Map<String, dynamic> json) =>
      Description(uz: json["uz"], ru: json["ru"]);

  Map<String, dynamic> toJson() => {"uz": uz, "ru": ru};
}

class Settings {
  String? language;
  String? experienceFrom;

  Settings({this.language, this.experienceFrom});

  Settings copyWith({String? language, String? experienceFrom}) => Settings(
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

class SocialNetwork {
  String? instagram;
  String? telegram;

  SocialNetwork({this.instagram, this.telegram});

  SocialNetwork copyWith({String? instagram, String? telegram}) =>
      SocialNetwork(
        instagram: instagram ?? this.instagram,
        telegram: telegram ?? this.telegram,
      );

  factory SocialNetwork.fromRawJson(String str) =>
      SocialNetwork.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SocialNetwork.fromJson(Map<String, dynamic> json) =>
      SocialNetwork(instagram: json["instagram"], telegram: json["telegram"]);

  Map<String, dynamic> toJson() => {
    "instagram": instagram,
    "telegram": telegram,
  };
}
