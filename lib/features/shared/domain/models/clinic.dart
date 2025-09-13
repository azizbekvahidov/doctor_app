import 'dart:convert';

class Clinic {
  int? id;
  Address? name;
  Address? address;
  Coordinates? coordinates;

  Clinic({this.id, this.name, this.address, this.coordinates});

  Clinic copyWith({
    int? id,
    Address? name,
    Address? address,
    Coordinates? coordinates,
  }) => Clinic(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    coordinates: coordinates ?? this.coordinates,
  );

  factory Clinic.fromRawJson(String str) => Clinic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
    id: json["id"],
    name: json["name"] == null ? null : Address.fromJson(json["name"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    coordinates: json["coordinates"] == null
        ? null
        : Coordinates.fromJson(json["coordinates"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name?.toJson(),
    "address": address?.toJson(),
    "coordinates": coordinates?.toJson(),
  };
}

class Address {
  String? uz;
  String? ru;

  Address({this.uz, this.ru});

  Address copyWith({String? uz, String? ru}) =>
      Address(uz: uz ?? this.uz, ru: ru ?? this.ru);

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) =>
      Address(uz: json["uz"], ru: json["ru"]);

  Map<String, dynamic> toJson() => {"uz": uz, "ru": ru};
}

class Coordinates {
  String? latitude;
  String? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates copyWith({String? latitude, String? longitude}) => Coordinates(
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
  );

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      Coordinates(latitude: json["latitude"], longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
