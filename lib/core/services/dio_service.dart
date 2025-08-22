import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;
  DioService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.mainUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final SecureStorageService _storage = SecureStorageService();

  Dio get dio {
    // Attach interceptor once
    if (_dio.interceptors.isEmpty) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Always fetch latest token
            final token = await _storage.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onError: (DioException e, handler) {
            // Handle token expiry, logging, etc.
            return handler.next(e);
          },
        ),
      );
    }
    return _dio;
  }
}
