import 'dart:convert';

import 'user.dart';

class LoginData {
  String? type;
  String? token;
  User? user;

  LoginData({this.type, this.token, this.user});

  LoginData copyWith({String? type, String? token, User? user}) => LoginData(
    type: type ?? this.type,
    token: token ?? this.token,
    user: user ?? this.user,
  );

  factory LoginData.fromRawJson(String str) =>
      LoginData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
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
