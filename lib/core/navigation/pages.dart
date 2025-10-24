import 'package:doctor_app/features/auth/presentations/pages/identification_page.dart';
import 'package:doctor_app/features/auth/presentations/pages/login_page.dart';
import 'package:doctor_app/features/auth/presentations/pages/register_page.dart';
import 'package:doctor_app/features/chat/presentation/chat_page.dart';
import 'package:doctor_app/features/detail/presentation/detail_page.dart';
import 'package:doctor_app/features/main/bindings.dart';
import 'package:doctor_app/features/main/presentation/main_page.dart';
import 'package:doctor_app/features/onboard/bindings.dart';
import 'package:doctor_app/features/onboard/pages/languages_page.dart';
import 'package:doctor_app/features/onboard/pages/onboard_page.dart';
import 'package:doctor_app/features/profile/presentation/create_work_place_page.dart';
import 'package:doctor_app/features/profile/presentation/create_work_schedule_page.dart';
import 'package:doctor_app/features/profile/presentation/documents_page.dart';
import 'package:doctor_app/features/profile/presentation/work_info_page.dart';
import 'package:get/get.dart';

import '../../features/chat/presentation/chats_page.dart';
import 'routes.dart';

class AppPages {
  static const initial = Routes.onboard;

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
      binding: MainPageBindings(),
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
    GetPage(
      name: Routes.detail,
      page: () => DetailPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.documents,
      page: () => DocumentsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.workInfo,
      page: () => WorkInfoPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.createWorkSchedule,
      page: () => CreateWorkSchedulePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.createWorkPlace,
      page: () => CreateWorkPlacePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    GetPage(
      name: Routes.chat,
      page: () => ChatPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.chats,
      page: () => ChatsPage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
