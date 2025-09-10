import 'package:doctor_app/features/main/presentation/controller/main_page_controller.dart';
import 'package:get/get.dart';

class MainPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
  }
}
