import 'dart:convert';

class Message {
  final int? id;
  final String? from;
  final String? message;
  final DateTime? readAt;
  final DateTime? createdAt;

  Message({this.id, this.from, this.message, this.readAt, this.createdAt});

  Message copyWith({
    int? id,
    String? from,
    String? message,
    DateTime? readAt,
    DateTime? createdAt,
  }) => Message(
    id: id ?? this.id,
    from: from ?? this.from,
    message: message ?? this.message,
    readAt: readAt ?? this.readAt,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    from: json["from"],
    message: json["message"],
    readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from": from,
    "message": message,
    "read_at": readAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}
