import 'package:doctor_app/features/auth/domain/models/login_data.dart';

abstract class AuthRepository {
  Future<LoginData?> login(String pinfl);
  Future<void> register();
  Future<void> logout();
}
