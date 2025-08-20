import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU': {
      'hello': 'Привет',
      'login': 'Войти',
      'logout': 'Выйти',
      'next': 'Далше',
    },
    'uz_UZ': {
      'hello': 'Salom',
      'login': 'Kirish',
      'logout': 'Chiqish',
      'next': 'Davom etish',
    },
  };
}
