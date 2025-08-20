import 'package:doctor_app/features/auth/presentations/pages/login_page.dart';
import 'package:doctor_app/features/onboard/bindings.dart';
import 'package:doctor_app/features/onboard/pages/languages_page.dart';
import 'package:doctor_app/features/onboard/pages/onboard_page.dart';
import 'package:get/get.dart';

import '../../features/auth/bindins.dart';
import 'routes.dart';

class AppPages {
  static const initial = Routes.login; // first page when app starts

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.onboard,
      page: () => OnboardPage(),
      binding: OnBoardBindings(),
    ),
  ];
}
