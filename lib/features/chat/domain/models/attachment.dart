import 'dart:convert';

class Attachment {
  final String? url;
  final String? fileName;
  final String? size;

  Attachment({
    this.url,
    this.fileName,
    this.size,
  });

  Attachment copyWith({
    String? url,
    String? fileName,
    String? size,
  }) =>
      Attachment(
        url: url ?? this.url,
        fileName: fileName ?? this.fileName,
        size: size ?? this.size,
      );

  factory Attachment.fromRawJson(String str) => Attachment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    url: json["url"],
    fileName: json["file_name"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "file_name": fileName,
    "size": size,
  };
}