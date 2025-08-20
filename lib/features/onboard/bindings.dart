import 'package:get/get.dart';

import 'controller/onboard_controller.dart';

class OnBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardController(), fenix: true);
  }
}
