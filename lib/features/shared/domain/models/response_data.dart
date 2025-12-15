// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:doctor_app/features/auth/domain/models/user.dart';

class ResponseData {
  final bool isSuccess;
  final User? user;
  ResponseData({this.isSuccess = false, this.user});

  ResponseData copyWith({bool? isSuccess, User? user}) {
    return ResponseData(
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'isSuccess': isSuccess, 'user': user?.toJson()};
  }

  factory ResponseData.fromMap(Map<String, dynamic> map) {
    return ResponseData(
      isSuccess: map['isSuccess'] as bool,
      user: map['user'] != null
          ? User.fromJson(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseData.fromJson(String source) =>
      ResponseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResponseData(isSuccess: $isSuccess, user: $user)';

  @override
  bool operator ==(covariant ResponseData other) {
    if (identical(this, other)) return true;

    return other.isSuccess == isSuccess && other.user == user;
  }

  @override
  int get hashCode => isSuccess.hashCode ^ user.hashCode;
}
