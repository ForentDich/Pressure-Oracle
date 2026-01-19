// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteEntry => 'Удалить запись?';

  @override
  String get notSpecified => 'Не указано';

  @override
  String get noData => 'Нет данных';

  @override
  String get yesterday => 'Вчера';

  @override
  String get today => 'Сегодня';

  @override
  String daysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String get addEntryTitle => 'Добавить запись';

  @override
  String get choosePlaceholder => 'Выберите категорию(ии) сверху';

  @override
  String get selectedPrefix => 'Выбрано: ';

  @override
  String get greetingMorning => 'Доброе утро,';

  @override
  String get greetingDay => 'Добрый день,';

  @override
  String get greetingEvening => 'Добрый вечер,';

  @override
  String get greetingNight => 'Доброй ночи,';

  @override
  String get defaultUserName => 'Пользователь';

  @override
  String get unitMmHg => 'мм рт.ст.';

  @override
  String get unitBpm => 'уд/мин';

  @override
  String get unitMmol => 'ммоль/л';

  @override
  String get unitKg => 'кг';

  @override
  String get unitCm => 'см';

  @override
  String get profile => 'Профиль';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get personalData => 'Личные данные';

  @override
  String get physicalParams => 'Физические параметры';

  @override
  String get firstName => 'Имя';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get height => 'Рост';

  @override
  String get weight => 'Вес';

  @override
  String get age => 'Возраст';

  @override
  String get yearsOld => 'лет';

  @override
  String get clearData => 'Очистить данные';

  @override
  String get home => 'Главная';

  @override
  String get history => 'История';

  @override
  String get schedule => 'Расписание';

  @override
  String get settings => 'Настройки';

  @override
  String get metricPressure => 'Давление';

  @override
  String get metricPulse => 'Пульс';

  @override
  String get metricWeight => 'Вес';

  @override
  String get metricSugar => 'Сахар';

  @override
  String get metricPressureUpper => 'ДАВЛЕНИЕ';

  @override
  String get metricPulseUpper => 'ПУЛЬС';

  @override
  String get metricWeightUpper => 'ВЕС';

  @override
  String get metricSugarUpper => 'САХАР';

  @override
  String get historyNoRecords => 'Записей пока нет';

  @override
  String get historyAddFirst => 'Добавьте первое измерение';

  @override
  String get historyYourMeasurements => 'Ваши измерения';

  @override
  String get onboardingWelcome => 'Добро пожаловать!';

  @override
  String get onboardingSubtitle => 'Давайте познакомимся';

  @override
  String get onboardingQuestion => 'Как к вам можно обращаться?';

  @override
  String get onboardingNameHint => 'Ваше имя';

  @override
  String get onboardingContinue => 'Далее';

  @override
  String get onboardingFinish => 'Начать';

  @override
  String get onboardingBirthDateTitle => 'Дата рождения';

  @override
  String get onboardingBirthDateSubtitle =>
      'Это поможет рассчитать ваш возраст';

  @override
  String get onboardingSelectDate => 'Выберите дату';

  @override
  String get onboardingHeightTitle => 'Ваш рост';

  @override
  String get onboardingHeightSubtitle => 'Укажите ваш рост в сантиметрах';

  @override
  String get onboardingWeightTitle => 'Ваш вес';

  @override
  String get onboardingWeightSubtitle => 'Укажите ваш вес в килограммах';

  @override
  String get upperPressure => 'Верхнее давление';

  @override
  String get lowerPressure => 'Нижнее давление';

  @override
  String get pulse => 'Пульс';

  @override
  String get sugarLevel => 'Уровень сахара';

  @override
  String get dynamics => 'Динамика';

  @override
  String get week => 'Неделя';

  @override
  String get weekdayMon => 'Пн';

  @override
  String get weekdayTue => 'Вт';

  @override
  String get weekdayWed => 'Ср';

  @override
  String get weekdayThu => 'Чт';

  @override
  String get weekdayFri => 'Пт';

  @override
  String get weekdaySat => 'Сб';

  @override
  String get weekdaySun => 'Вс';

  @override
  String get scheduleManageReminders => 'Управляйте напоминаниями';

  @override
  String get scheduleActive => 'Активные';

  @override
  String get scheduleInactive => 'Неактивные';

  @override
  String get scheduleActiveCount => 'Активных';

  @override
  String get scheduleTotal => 'Всего';

  @override
  String get newReminder => 'Новое напоминание';

  @override
  String get editing => 'Редактирование';

  @override
  String get basicData => 'Основные данные';

  @override
  String get notificationTitle => 'Название уведомления (необязательно)';

  @override
  String get description => 'Описание (необязательно)';

  @override
  String get timeAndRepeat => 'Время и повтор';

  @override
  String get time => 'Время';

  @override
  String get repeat => 'Повтор';

  @override
  String get startDate => 'Дата начала';

  @override
  String get notificationStyle => 'Оформление уведомления';

  @override
  String get notificationType => 'Тип уведомления';

  @override
  String get cardColor => 'Цвет карточки';

  @override
  String get repeatDaily => 'Каждый день';

  @override
  String get repeatWeekly => 'Каждую неделю';

  @override
  String get repeatMonthly => 'Раз в месяц';

  @override
  String get repeatWeekdays => 'По будням';

  @override
  String get notifications => 'Уведомления';

  @override
  String get reminders => 'Напоминания';

  @override
  String get dailySummary => 'Ежедневная сводка';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get theme => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get fontSize => 'Размер текста';

  @override
  String get fontSizeNormal => 'Обычный';

  @override
  String get other => 'Прочее';

  @override
  String get typeStandard => 'Стандартное';

  @override
  String get colorPurple => 'Фиолетовый';

  @override
  String get measurePressure => 'Измерить давление';

  @override
  String get eveningMeasurement => 'Вечернее измерение';

  @override
  String get weighing => 'Взвешивание';

  @override
  String get recordSugar => 'Записать сахар';

  @override
  String get doctorVisit => 'Визит к врачу';

  @override
  String get notificationPermissionDenied =>
      'Разрешение на уведомления не получено. Включите в настройках.';

  @override
  String get defaultReminderTitlePressure => 'Измерьте давление!';

  @override
  String get defaultReminderTitlePulse => 'Измерьте пульс!';

  @override
  String get defaultReminderTitleWeight => 'Время взвеситься!';

  @override
  String get defaultReminderTitleSugar => 'Измерьте уровень сахара!';

  @override
  String get defaultReminderTitleOther => 'Напоминание';

  @override
  String get defaultReminderDescription =>
      'Регулярные измерения важны для здоровья';

  @override
  String get notificationCategoryPressure => 'Давление';

  @override
  String get notificationCategoryPulse => 'Пульс';

  @override
  String get notificationCategoryWeight => 'Вес';

  @override
  String get notificationCategorySugar => 'Сахар';

  @override
  String get notificationCategoryOther => 'Прочее';

  @override
  String get notificationCategoryLabel => 'Категория';
}
