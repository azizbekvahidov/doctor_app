import 'package:doctor_app/core/services/dio_service.dart';
import 'package:doctor_app/features/auth/data/repository/auth_repository_iml.dart';
import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(AuthRepositoryIml(DioService().dio)));
  }
}
