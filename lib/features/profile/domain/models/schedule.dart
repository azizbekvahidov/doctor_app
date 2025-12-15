import 'dart:convert';

class Schedule {
  Clinic? clinic;
  List<ScheduleElement>? schedule;
  Price? price;

  Schedule({this.clinic, this.schedule, this.price});

  Schedule copyWith({
    Clinic? clinic,
    List<ScheduleElement>? schedule,
    Price? price,
  }) => Schedule(
    clinic: clinic ?? this.clinic,
    schedule: schedule ?? this.schedule,
    price: price ?? this.price,
  );

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    clinic: json["clinic"] == null ? null : Clinic.fromJson(json["clinic"]),
    schedule: json["schedule"] == null
        ? []
        : List<ScheduleElement>.from(
            json["schedule"]!.map((x) => ScheduleElement.fromJson(x)),
          ),
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
  );

  Map<String, dynamic> toJson() => {
    "clinic": clinic?.toJson(),
    "schedule": schedule == null
        ? []
        : List<dynamic>.from(schedule!.map((x) => x.toJson())),
    "price": price?.toJson(),
  };
}

class Clinic {
  int? id;
  Address? name;
  Address? address;
  Coordinates? coordinates;
  District? district;

  Clinic({this.id, this.name, this.address, this.coordinates, this.district});

  Clinic copyWith({
    int? id,
    Address? name,
    Address? address,
    Coordinates? coordinates,
    District? district,
  }) => Clinic(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    coordinates: coordinates ?? this.coordinates,
    district: district ?? this.district,
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
    district: json["district"] == null
        ? null
        : District.fromJson(json["district"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name?.toJson(),
    "address": address?.toJson(),
    "coordinates": coordinates?.toJson(),
    "district": district?.toJson(),
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

class District {
  int? id;
  Address? name;
  Region? region;

  District({this.id, this.name, this.region});

  District copyWith({int? id, Address? name, Region? region}) => District(
    id: id ?? this.id,
    name: name ?? this.name,
    region: region ?? this.region,
  );

  factory District.fromRawJson(String str) =>
      District.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"] == null ? null : Address.fromJson(json["name"]),
    region: json["region"] == null ? null : Region.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name?.toJson(),
    "region": region?.toJson(),
  };
}

class Region {
  int? id;
  Address? name;

  Region({this.id, this.name});

  Region copyWith({int? id, Address? name}) =>
      Region(id: id ?? this.id, name: name ?? this.name);

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    id: json["id"],
    name: json["name"] == null ? null : Address.fromJson(json["name"]),
  );

  Map<String, dynamic> toJson() => {"id": id, "name": name?.toJson()};
}

class Price {
  String? main;
  String? second;

  Price({this.main, this.second});

  Price copyWith({String? main, String? second}) =>
      Price(main: main ?? this.main, second: second ?? this.second);

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) =>
      Price(main: json["main"], second: json["second"]);

  Map<String, dynamic> toJson() => {"main": main, "second": second};
}

class ScheduleElement {
  String? day;
  Lunch? work;
  Lunch? lunch;

  ScheduleElement({this.day, this.work, this.lunch});

  ScheduleElement copyWith({String? day, Lunch? work, Lunch? lunch}) =>
      ScheduleElement(
        day: day ?? this.day,
        work: work ?? this.work,
        lunch: lunch ?? this.lunch,
      );

  factory ScheduleElement.fromRawJson(String str) =>
      ScheduleElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ScheduleElement.fromJson(Map<String, dynamic> json) =>
      ScheduleElement(
        day: json["day"],
        work: json["work"] == null ? null : Lunch.fromJson(json["work"]),
        lunch: json["lunch"] == null ? null : Lunch.fromJson(json["lunch"]),
      );

  Map<String, dynamic> toJson() => {
    "day": day!.toLowerCase(),
    "work_from": work!.from,
    "work_until": work!.until,
    "lunch_from": lunch!.from,
    "lunch_until": lunch!.until,
  };
}

class Lunch {
  String? from;
  String? until;

  Lunch({this.from, this.until});

  Lunch copyWith({String? from, String? until}) =>
      Lunch(from: from ?? this.from, until: until ?? this.until);

  factory Lunch.fromRawJson(String str) => Lunch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Lunch.fromJson(Map<String, dynamic> json) =>
      Lunch(from: json["from"], until: json["until"]);

  Map<String, dynamic> toJson() => {"from": from, "until": until};
}
