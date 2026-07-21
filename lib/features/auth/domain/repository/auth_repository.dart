import 'package:doctor_app/features/auth/domain/models/auth_data.dart';

abstract class AuthRepository {
  /// Exchanges a verified identity for a session.
  ///
  /// [code] is the MyID authorization code (null when MyID isn't configured);
  /// [pinfl] is only used by the API while it runs in MyID test mode.
  Future<AuthData?> login({required String pinfl, String? code});
  Future<bool> register(Map<String, dynamic> personalData);
  Future<void> logout();
}
