import 'dart:convert';

import 'user.dart';

class AuthData {
  String? type;
  String? token;
  User? user;

  AuthData({this.type, this.token, this.user});

  AuthData copyWith({String? type, String? token, User? user}) => AuthData(
    type: type ?? this.type,
    token: token ?? this.token,
    user: user ?? this.user,
  );

  factory AuthData.fromRawJson(String str) =>
      AuthData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    type: json["type"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "token": token,
    "user": user?.toJson(),
  };
}
