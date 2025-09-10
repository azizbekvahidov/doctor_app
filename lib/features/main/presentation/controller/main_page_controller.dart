import 'package:doctor_app/core/enums/contents.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  Rx<Contents> content = Rx(Contents.home);

  setContent(Contents ctn) {
    content.value = ctn;
  }
}
