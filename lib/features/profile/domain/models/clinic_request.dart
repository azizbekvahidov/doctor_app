// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClinicRequest {
  final int? id;
  final String nameUz;
  final String nameRu;
  final String addressUz;
  final String addressRu;
  final int regionId;
  ClinicRequest({
    this.id,
    required this.nameUz,
    required this.nameRu,
    required this.addressUz,
    required this.addressRu,
    required this.regionId,
  });

  ClinicRequest copyWith({
    String? nameUz,
    String? nameRu,
    String? addressUz,
    String? addressRu,
    int? regionId,
  }) {
    return ClinicRequest(
      nameUz: nameUz ?? this.nameUz,
      nameRu: nameRu ?? this.nameRu,
      addressUz: addressUz ?? this.addressUz,
      addressRu: addressRu ?? this.addressRu,
      regionId: regionId ?? this.regionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_uz': nameUz,
      'name_ru': nameRu,
      'address_uz': addressUz,
      'address_ru': addressRu,
      'district_id': regionId,
      "latitude": 40.1102392,
      "longitude": 65.5168817,
      'clinic_id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ClinicRequest(nameUz: $nameUz, nameRu: $nameRu, addressUz: $addressUz, addressRu: $addressRu, regionId: $regionId)';
  }
}
