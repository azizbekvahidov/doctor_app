import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;
  DioService._internal() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.getToken(); // always latest token
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Here you could refresh token / log out
          return handler.next(e);
        },
      ),
    );
  }

  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.mainUrl));

  final SecureStorageService _storage = SecureStorageService();

  Dio get dio => _dio;
}
