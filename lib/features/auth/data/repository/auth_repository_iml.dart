import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/auth/domain/models/login_data.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryIml extends AuthRepository {
  final Dio dio;
  AuthRepositoryIml(this.dio);

  @override
  Future<LoginData?> login(pinfl) async {
    try {
      LoginData? loginData = LoginData();
      final Response response = await dio.post(
        ApiConstants.login,
        data: {'pinfl': pinfl},
      );
      if (response.statusCode == 200) {
        loginData = LoginData.fromJson(response.data['data']);
      }
      return loginData;
    } on DioException catch (e) {
      LogHelper.error("Failed Login: ${e.toString()}");
      return null;
    } catch (e) {
      LogHelper.error("Failed Login: ${e.toString()}");
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await dio.post(ApiConstants.logout);
  }

  @override
  Future<void> register() async {
    await dio.post(ApiConstants.login);
  }
}
