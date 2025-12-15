import 'dart:convert';

class Region {
  int? id;
  Name? name;

  Region({this.id, this.name});

  Region copyWith({int? id, Name? name}) =>
      Region(id: id ?? this.id, name: name ?? this.name);

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name?.toJson()};
}

class Name {
  String? uz;
  String? ru;

  Name({this.uz, this.ru});

  Name copyWith({String? uz, String? ru}) =>
      Name(uz: uz ?? this.uz, ru: ru ?? this.ru);

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(uz: json["uz"], ru: json["ru"]);

  Map<String, dynamic> toJson() => {"uz": uz, "ru": ru};
}
