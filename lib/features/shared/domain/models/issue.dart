class Issue {
  final int? id;
  final String? uuid;
  final Patient? patient;
  final String? issue;
  final String? address;
  final DateTime? birthdate;
  final DateTime? inactiveAt;

  Issue({
    this.id,
    this.uuid,
    this.patient,
    this.issue,
    this.address,
    this.birthdate,
    this.inactiveAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    id: json["id"],
    uuid: json["uuid"],
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
    issue: json["issue"],
    address: json["address"],
    birthdate: json["birthdate"] == null
        ? null
        : DateTime.parse(json["birthdate"]),
    inactiveAt: json["inactive_at"] == null
        ? null
        : DateTime.parse(json["inactive_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "patient": patient?.toJson(),
    "issue": issue,
    "address": address,
    "birthdate": birthdate?.toIso8601String(),
    "inactive_at": inactiveAt?.toIso8601String(),
  };
}

class Patient {
  final int? id;
  final String? fullName;

  Patient({this.id, this.fullName});

  factory Patient.fromJson(Map<String, dynamic> json) =>
      Patient(id: json["id"], fullName: json["full_name"]);

  Map<String, dynamic> toJson() => {"id": id, "full_name": fullName};
}
