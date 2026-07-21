import 'package:dio/dio.dart';
import 'package:doctor_app/core/constants/api_constants.dart';
import 'package:doctor_app/core/navigation/routes.dart';
import 'package:doctor_app/core/services/alice_service.dart';
import 'package:doctor_app/core/services/secure_storage_service.dart';
import 'package:get/get.dart';

class DioService {
  DioService();

  Dio createDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.mainUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final SecureStorageService storage = SecureStorageService();
          final token = await storage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // An expired/invalid token yields 401 on every request; drop the dead
          // session and send the user back to the entry flow instead of leaving
          // the app "logged in" with a token the server rejects.
          if (e.response?.statusCode == 401) {
            final SecureStorageService storage = SecureStorageService();
            await storage.deleteToken();
            await storage.deleteUser();
            if (Get.currentRoute != Routes.onboard &&
                Get.currentRoute != Routes.login) {
              Get.offAllNamed(Routes.onboard);
            }
          }
          return handler.next(e);
        },
      ),
    );

    // Dev-only HTTP inspector. Added last so it observes the final request
    // (including the auth header). Null / skipped when dev mode is off.
    final aliceInterceptor = AliceService.dioInterceptor;
    if (aliceInterceptor != null) {
      dio.interceptors.add(aliceInterceptor);
    }

    return dio;
  }
}
