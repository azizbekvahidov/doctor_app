import 'package:doctor_app/features/auth/domain/models/auth_data.dart';

abstract class AuthRepository {
  Future<AuthData?> login(String pinfl);
  Future<bool> register(Map<String, dynamic> personalData);
  Future<void> logout();
}
