import 'package:doctor_app/features/onboard/controller/onboard_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardController());
  }
}
