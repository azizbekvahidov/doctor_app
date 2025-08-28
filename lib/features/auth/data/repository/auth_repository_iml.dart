import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:doctor_app/core/utils/log_helper.dart';
import 'package:doctor_app/features/auth/domain/models/auth_data.dart';
import 'package:doctor_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryIml extends AuthRepository {
  final Dio dio;
  AuthRepositoryIml(this.dio);

  @override
  Future<AuthData?> login(pinfl) async {
    try {
      AuthData? loginData = AuthData();
      final Response response = await dio.post(
        ApiConstants.login,
        data: {'pinfl': pinfl},
      );
      if (response.statusCode == 200) {
        loginData = AuthData.fromJson(response.data['data']);
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
  Future<bool> register(personalData) async {
    final storeage = SecureStorageService();
    String? token = await storeage.getToken();

    try {
      final Response response = await dio.post(
        ApiConstants.register,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: personalData,
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      // LogHelper.info(e.requestOptions.headers.toString());
      // LogHelper.info(e.response!.statusCode!.toString());
      // // LogHelper.error(e.requestOptions.uri.toString());
      LogHelper.error(e.response!.data.toString());
      return false;
    } catch (e) {
      return false;
    }
  }
}
