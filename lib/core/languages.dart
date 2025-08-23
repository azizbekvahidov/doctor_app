import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU': {
      'hello': 'Привет',
      'login': 'Войти',
      'logout': 'Выйти',
      'next': 'Далше',
      'dismiss': 'Увольнять',
      'new_ann': 'Новые объявления',
      'active_ann': 'Активные объявления',
      'identification_info': 'Сделать селфи и  пройти идентификацию',
    },
    'uz_UZ': {
      'hello': 'Salom',
      'login': 'Kirish',
      'logout': 'Chiqish',
      'next': 'Davom etish',
      'dismiss': 'Bekor qilish',
      'new_ann': 'Yangi buyurtmalar',
      'active_ann': 'Aktiv buyurtmalar',
      'identification_info': 'Selfi oling va identifikatsiyadan o\'ting',
    },
  };
}
