import 'dart:convert';

import 'attachment.dart';

class Message {
  final int? id;
  final String? from;
  final String? message;
  final dynamic readAt;
  final DateTime? createdAt;
  final List<Attachment>? attachments;

  Message({
    this.id,
    this.from,
    this.message,
    this.readAt,
    this.createdAt,
    this.attachments,
  });

  Message copyWith({
    int? id,
    String? from,
    String? message,
    dynamic readAt,
    DateTime? createdAt,
    List<Attachment>? attachments,
  }) =>
      Message(
        id: id ?? this.id,
        from: from ?? this.from,
        message: message ?? this.message,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        attachments: attachments ?? this.attachments,
      );

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    from: json["from"],
    message: json["message"],
    readAt: json["read_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from": from,
    "message": message,
    "read_at": readAt,
    "created_at": createdAt?.toIso8601String(),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}


