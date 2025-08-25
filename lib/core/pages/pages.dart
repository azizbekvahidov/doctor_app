import 'package:doctor_app/features/auth/presentations/pages/identification_page.dart';
import 'package:doctor_app/features/auth/presentations/pages/login_page.dart';
import 'package:doctor_app/features/auth/presentations/pages/register_page.dart';
import 'package:doctor_app/features/main/main_page.dart';
import 'package:doctor_app/features/onboard/bindings.dart';
import 'package:doctor_app/features/onboard/pages/languages_page.dart';
import 'package:doctor_app/features/onboard/pages/onboard_page.dart';
import 'package:get/get.dart';

import 'routes.dart';

class AppPages {
  static const initial = Routes.register;

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      transition: Transition.native,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.onboard,
      page: () => OnboardPage(),
      binding: OnBoardBindings(),
    ),
    GetPage(
      name: Routes.lang,
      page: () => LanguagesPage(),
      binding: OnBoardBindings(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 600),
    ),

    GetPage(
      name: Routes.identification,
      page: () => IdentificationPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
