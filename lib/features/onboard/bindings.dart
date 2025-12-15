import 'package:doctor_app/features/auth/presentations/controller/auth_controller.dart';
import 'package:doctor_app/features/profile/presentation/controllers/cabinet_controller.dart';
import 'package:doctor_app/features/shared/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../../core/services/dio_service.dart';
import '../auth/data/repository/auth_repository_iml.dart';
import 'controller/onboard_controller.dart';

class OnBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardController());
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(
      () => AuthController(AuthRepositoryIml(DioService().createDio())),
    );
    Get.lazyPut(() => CabinetController());
  }
}
