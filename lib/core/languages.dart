import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ru_RU': {
      'hello': 'Привет',
      'login': 'Войти',
      'logout': 'Выход из системы',
      'next': 'Продолжить',
      'dismiss': 'Отменить',

      // --- Announcements ---
      'new_ann': 'Новые заказы',
      'active_ann': 'Активные заказы',

      // --- Personal Info ---
      'first_name': "Имя",
      'last_name': "Фамилия",
      'middle_name': "Отчество",
      'personal_info': "Личная информация",
      'phone_number': "Номер телефона",
      'email': "Эл. почта",
      'birthday': "Дата рождения",
      'experience': "Ваш опыт",
      'degree': "Ваша степень",
      'profession': "Ваша специальность",
      'about_uz': "О себе на узбекском языке",
      'about_ru': "О себе на русском языке",
      'social_networks': "Социальные сети",
      'identification_info': 'Сделайте селфи и пройдите идентификацию',
      'identification': 'Идентификация',
      'register_success': 'Вы успешно зарегистрировались в системе.',
      'select_profession': 'Пожалуйста, выберите вашу специальность',
      'select_degree': 'Пожалуйста, выберите вашу степень',

      // --- Validation texts ---
      'valid_first_name': 'Пожалуйста, введите ваше имя',
      'valid_last_name': 'Пожалуйста, введите вашу фамилию',
      'valid_middle_name': 'Пожалуйста, введите отчество',
      'valid_phone_number': 'Пожалуйста, введите ваш номер телефона',
      'valid_email': 'Пожалуйста, введите вашу эл. почту',
      'valid_birthday': 'Пожалуйста, введите дату рождения',
      'valid_experience': 'Пожалуйста, введите ваш опыт',
      'valid_degree': 'Пожалуйста, выберите степень',
      'valid_profession': 'Пожалуйста, выберите специальность',
      'valid_about_uz':
          'Пожалуйста, введите информацию о себе на узбекском языке',
      'valid_about_ru':
          'Пожалуйста, введите информацию о себе на русском языке',
      'valid_social_networks':
          'Пожалуйста, введите информацию о социальных сетях',
      'valid_language': 'Пожалуйста, выберите язык',
      'valid_pnfl': 'Пожалуйста, введите ваш ПИНФЛ!',

      // --- Medical Degrees ---
      'bachelor': 'Бакалавр',
      'master': 'Магистр',
      'phd': 'PhD (Доктор философии)',
      'docent': 'Доцент',
      'professor': 'Профессор',
      'resident': 'Резидент',
      'intern': 'Интерн',
      'specialist': 'Специалист',
      'doctor_sciences': 'Доктор наук',

      // --- Medical Professions ---
      'general_practitioner': 'Терапевт',
      'dentist': 'Стоматолог',
      'surgeon': 'Хирург',
      'pediatrician': 'Педиатр',
      'cardiologist': 'Кардиолог',
      'neurologist': 'Невролог',
      'oncologist': 'Онколог',
      'orthopedist': 'Ортопед',
      'gynecologist': 'Гинеколог',
      'urologist': 'Уролог',
      'dermatologist': 'Дерматолог',
      'psychiatrist': 'Психиатр',
      'radiologist': 'Рентгенолог',
      'ophthalmologist': 'Офтальмолог',
      'anesthesiologist': 'Анестезиолог',
      'endocrinologist': 'Эндокринолог',
      'family_doctor': 'Семейный врач',

      // --- Patient Info ---
      'patient_information': 'Информация о пациенте',
      'analysis_data': 'Результаты анализа',
      'diagnosis': 'Диагноз',
      'card': 'Карта',

      // --- Profile ---
      'documents': 'Документы',
      'work_and_schedule': 'Место работы и расписания',
      'profile': 'Профиль',

      // --- Work and Schedule ---
      'add_work_place': 'Добавить место работы',
      'add_day': 'Добавить день',
      'add_schedule': "Добавить рабочие часы",
      'select_weekday': "Выберите день недели",
      'lunch_time': "Время обеда",
      'opening_hours': "Рабочее время",
      'name_of_clinic': "Название клиники",
      'address_of_clinic': "Адрес клиники",
      'region': "Регион",
      'place': "Место работы",
      'schedule': "Расписание",
      'delete_document_alert': 'Удалить документ?',
      'no_documents': 'Документы отсутствуют',

      // price
      'main_price': '',

      // --- Days ---
      'monday': 'Понедельник',
      'tuesday': 'Вторник',
      'wednesday': 'Среда',
      'thursday': 'Четверг',
      'friday': 'Пятница',
      'saturday': 'Суббота',
      'sunday': 'Воскресенье',

      'no_schedules': 'Расписаний нет',
      'clinic': 'Клиника',
      'address': 'Адрес',
      'day': 'День',
      'hour': 'Часы',
      'lunch': 'Обед',
      'work_hours': 'Рабочие часы',

      // --- Common buttons ---
      'add': 'Добавить',
      'save': 'Сохранить',
      'create': 'Создать',
      'upload': 'Загрузить',
      'select_file': 'Выберите файл',
      'select_region': 'Выберите регион',
      'select_language': 'Выберите язык',
      'select_day': 'Выберите день',
      'select_time': 'Выберите время',
      'select_work_hours': 'Выберите рабочие часы',
      'select_clinic': 'Выберите клинику',
      'create_schedule': 'Создать расписание',
      'create_clinic': 'Создать клинику',
      'delete': 'Удалить',
      'cancel': 'Отмена',
      'yes': 'Да',
      'no': 'Нет',

      // --- Validation for schedule ---
      'valid_price': 'Пожалуйста, введите цену',
      'valid_clinic': 'Пожалуйста, введите название клиники',
      'valid_address': 'Пожалуйста, введите адрес клиники',
      'valid_region': 'Пожалуйста, выберите регион',
      'valid_day': 'Пожалуйста, выберите день недели',
      'valid_work_hours': 'Пожалуйста, введите рабочее время',
      'valid_first_price': 'Пожалуйста, введите цену первого приёма',
      'valid_second_price': 'Пожалуйста, введите цену второго приёма',
      'valid_schedules': 'Пожалуйста, добавьте расписание',

      // --- Prices ---
      'first_price': 'Цена первого приёма',
      'second_price': 'Цена второго приёма',

      // --- Issues / Archive ---
      'archive_alert': 'Отправить в архив?',
      'archived': 'Архивировано',
      'issue_archived_successfully': 'Успешно архивировано',
      'no_archived_issues': 'Архивы отсутствуют',
      'archives': 'Архивы',

      // --- Chat ---
      'type message': 'Введите сообщение',
      'send': 'Отправить',
      'chats': 'Чаты',

      // --- Notifications ---
      'schedule_was_created_successfully': 'Расписание успешно создано',
    },

    // ====================== Uzbek ==========================
    'uz_UZ': {
      'hello': 'Salom',
      'login': 'Kirish',
      'logout': 'Tizimdan chiqildi',
      'next': 'Davom etish',
      'dismiss': 'Bekor qilish',

      // --- Announcements ---
      'new_ann': 'Yangi buyurtmalar',
      'active_ann': 'Aktiv buyurtmalar',

      // --- Personal Info ---
      'first_name': "Ism",
      'last_name': "Familiya",
      'middle_name': "Otasining ismi",
      'personal_info': "Shaxsiy ma'lumotlar",
      'phone_number': "Telefon raqam",
      'email': "Email",
      'birthday': "Tug'ilgan kun",
      'experience': "Tajribangiz",
      'degree': "Darajangiz",
      'profession': "Yo'nalishingiz",
      'about_uz': "O'zbek tilida o'zingiz haqingizda",
      'about_ru': "Rus tilida o'zingiz haqingizda",
      'social_networks': "Ijtimoiy tarmoqlar",
      'identification_info': 'Selfi oling va identifikatsiyadan o\'ting',
      'identification': 'Identifikatsiya',
      'register_success': 'Siz tizimda muvaffaqiyatli ro\'yxatdan o\'tdingiz.',
      'select_profession': 'Iltimos yo\'nalishingizni tanlang',
      'select_degree': 'Iltimos darajangizni tanlang',

      // --- Validation texts ---
      'valid_first_name': 'Iltimos ismingizni kiriting',
      'valid_last_name': 'Iltimos familiyangizni kiriting',
      'valid_middle_name': 'Iltimos otangizning ismini kiriting',
      'valid_phone_number': 'Iltimos telefon raqamingizni kiriting',
      'valid_email': 'Iltimos emailingizni kiriting',
      'valid_birthday': 'Iltimos tug\'ilgan kuningizni kiriting',
      'valid_experience': 'Iltimos tajribangizni kiriting',
      'valid_degree': 'Iltimos darajangizni tanlang',
      'valid_profession': 'Iltimos yo\'nalishingizni tanlang',
      'valid_about_uz':
          'Iltimos o\'zbek tilida o\'zingiz haqingizda ma\'lumot kiriting',
      'valid_about_ru':
          'Iltimos rus tilida o\'zingiz haqingizda ma\'lumot kiriting',
      'valid_social_networks':
          'Iltimos ijtimoiy tarmoqlar haqingizda ma\'lumot kiriting',
      'valid_language': 'Iltimos tilni tanlang',
      'valid_pnfl': 'Iltimos JSHSHR ni kiriting!',

      // --- Medical Degrees ---
      'bachelor': 'Bakalavr',
      'master': 'Magistr',
      'phd': 'PhD (Falsafa doktori)',
      'docent': 'Dotsent',
      'professor': 'Professor',
      'resident': 'Rezident',
      'intern': 'Intern',
      'specialist': 'Mutaxassis',
      'doctor_sciences': 'Fan doktori',

      // --- Medical Professions ---
      'general_practitioner': 'Terapevt',
      'dentist': 'Stomatolog',
      'surgeon': 'Jarroh',
      'pediatrician': 'Pediatr',
      'cardiologist': 'Kardiolog',
      'neurologist': 'Nevrolog',
      'oncologist': 'Onkolog',
      'orthopedist': 'Ortoped',
      'gynecologist': 'Ginekolog',
      'urologist': 'Urolog',
      'dermatologist': 'Dermatolog',
      'psychiatrist': 'Psixiatr',
      'radiologist': 'Rentgenolog',
      'ophthalmologist': 'Oftalmolog',
      'anesthesiologist': 'Anesteziolog',
      'endocrinologist': 'Endokrinolog',
      'family_doctor': 'Oilaviy shifokor',

      // --- Patient Info ---
      'patient_information': 'Bemor ma\'lumotlari',
      'analysis_data': 'Analiz natijasi',
      'diagnosis': 'Diagnos',
      'card': 'Karta',

      // --- Profile ---
      'documents': 'Hujjatlar',
      'work_and_schedule': 'Ish joyi va jadvallari',
      'profile': 'Profil',

      // --- Work and Schedule ---
      'add_work_place': 'Ish joyini qo\'shing',
      'add_day': 'Kun qo\'shish',
      'add_schedule': "Ish vaqtlarini qo'shish",
      'select_weekday': "Hafta kunini tanlang",
      'lunch_time': "Tushlik vaqti",
      'opening_hours': "Ish vaqti",
      'name_of_clinic': "Shifoxona nomi",
      'address_of_clinic': "Shifoxona manzili",
      'region': "Viloyat",
      'place': "Ish joyi",
      'schedule': "Ish jadvali",
      'delete_document_alert': 'Hujjatni o\'chirmoqchimisiz?',
      'no_documents': 'Hujjatlar mavjud emas',

      // --- Days ---
      'monday': 'Dushanba',
      'tuesday': 'Seshanba',
      'wednesday': 'Chorshanba',
      'thursday': 'Payshanba',
      'friday': 'Juma',
      'saturday': 'Shanba',
      'sunday': 'Yakshanba',

      'no_schedules': 'Jadvallar mavjud emas',
      'clinic': 'Klinika',
      'address': 'Manzil',
      'day': 'Kun',
      'hour': 'Soat',
      'lunch': 'Tushlik',
      'work_hours': 'Ish soatlari',

      // --- Common buttons ---
      'add': 'Qo\'shish',
      'save': 'Saqlash',
      'create': 'Yaratish',
      'upload': 'Yuklash',
      'select_file': 'Faylni tanlang',
      'select_region': 'Viloyatni tanlang',
      'select_language': 'Tilni tanlang',
      'select_day': 'Kun tanlash',
      'select_time': 'Vaqtni tanlang',
      'select_work_hours': 'Ish vaqtlarini tanlang',
      'select_clinic': 'Klinikani tanlang',
      'create_schedule': 'Jadval yaratish',
      'create_clinic': 'Klinika yaratish',
      'delete': 'O\'chirish',
      'cancel': 'Bekor qilish',
      'yes': 'Ha',
      'no': 'Yo\'q',

      // --- Validation for schedule ---
      'valid_price': 'Iltimos narxni kiriting',
      'valid_clinic': 'Iltimos klinika nomini kiriting',
      'valid_address': 'Iltimos klinika manzilini kiriting',
      'valid_region': 'Iltimos viloyatni tanlang',
      'valid_day': 'Iltimos hafta kunini tanlang',
      'valid_work_hours': 'Iltimos ish vaqtlarini kiriting',
      'valid_first_price': 'Iltimos birinchi qabul narxini kiriting',
      'valid_second_price': 'Iltimos ikkinchi qabul narxini kiriting',
      'valid_schedules': 'Iltimos jadval qo\'shing',

      // --- Prices ---
      'first_price': 'Birinchi qabul narxi',
      'second_price': 'Ikkinchi qabul narxi',

      // --- Issues / Archive ---
      'archive_alert': 'Arxivga tushurishni istaysizmi?',
      'archived': 'Arxivlandi',
      'issue_archived_successfully': 'Muvaffaqиятli arxivlandi',
      'no_archived_issues': 'Arxivlar mavjud emas',
      'archives': 'Arxivlar',
      'no_active_ann': 'Aktiv buyurtmalar mavjud emas',

      // --- Chat ---
      'type message': 'Xabarni kiriting',
      'send': 'Yuborish',
      'chats': 'Xabarlar',

      // --- Notifications ---
      'schedule_was_created_successfully': 'Jadval muvaffaqiyatli yaratildi',
      'document_was_deleted_successfully': 'Hujjat muvaffaqiyatli o\'chirildi',
      'document_was_uploaded_successfully': 'Hujjat muvaffaqiyatli yuklandi!',
      "error_while_creating_schedule":
          'Jadval yaratishda xatolik. Iltimos qayta urinib ko\'ring.',
    },
  };
}
