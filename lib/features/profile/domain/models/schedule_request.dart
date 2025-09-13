import 'dart:convert';

import 'package:doctor_app/features/profile/domain/models/schedule.dart';

class ScheduleRequest {
  List<ScheduleElement>? schedule;
  int? price;
  int? secondPrice;
  int? clinicId;
  Clinic? clinic;

  ScheduleRequest({
    this.schedule,
    this.price,
    this.secondPrice,
    this.clinicId,
    this.clinic,
  });

  ScheduleRequest copyWith({
    List<ScheduleElement>? schedule,
    int? price,
    int? secondPrice,
    int? clinicId,
    Clinic? clinic,
  }) => ScheduleRequest(
    schedule: schedule ?? this.schedule,
    price: price ?? this.price,
    secondPrice: secondPrice ?? this.secondPrice,
    clinicId: clinicId ?? this.clinicId,
    clinic: clinic ?? this.clinic,
  );

  factory ScheduleRequest.fromRawJson(String str) =>
      ScheduleRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleRequest.fromJson(Map<String, dynamic> json) =>
      ScheduleRequest(
        schedule: json["schedule"] == null
            ? []
            : List<ScheduleElement>.from(
                json["schedule"]!.map((x) => Schedule.fromJson(x)),
              ),
        price: json["price"],
        secondPrice: json["second_price"],
        clinicId: json["clinic_id"],
        clinic: json["clinic"] == null ? null : Clinic.fromJson(json["clinic"]),
      );

  Map<String, dynamic> toJson() => {
    "schedule": schedule == null
        ? []
        : List<dynamic>.from(schedule!.map((x) => x.toJson())),
    "price": price,
    "second_price": secondPrice,
    "clinic_id": clinicId,
    "clinic": clinic?.toJson(),
  };
}

class Clinic {
  String? nameUz;
  String? nameRu;
  String? addressUz;
  String? addressRu;
  double? latitude;
  double? longitude;
  int? districtId;

  Clinic({
    this.nameUz,
    this.nameRu,
    this.addressUz,
    this.addressRu,
    this.latitude,
    this.longitude,
    this.districtId,
  });

  Clinic copyWith({
    String? nameUz,
    String? nameRu,
    String? addressUz,
    String? addressRu,
    double? latitude,
    double? longitude,
    int? districtId,
  }) => Clinic(
    nameUz: nameUz ?? this.nameUz,
    nameRu: nameRu ?? this.nameRu,
    addressUz: addressUz ?? this.addressUz,
    addressRu: addressRu ?? this.addressRu,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    districtId: districtId ?? this.districtId,
  );

  factory Clinic.fromRawJson(String str) => Clinic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
    nameUz: json["name_uz"],
    nameRu: json["name_ru"],
    addressUz: json["address_uz"],
    addressRu: json["address_ru"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    districtId: json["district_id"],
  );

  Map<String, dynamic> toJson() => {
    "name_uz": nameUz,
    "name_ru": nameRu,
    "address_uz": addressUz,
    "address_ru": addressRu,
    "latitude": latitude,
    "longitude": longitude,
    "district_id": districtId,
  };
}
