import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @deleteEntry.
  ///
  /// In ru, this message translates to:
  /// **'Удалить запись?'**
  String get deleteEntry;

  /// No description provided for @notSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Не указано'**
  String get notSpecified;

  /// No description provided for @noData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных'**
  String get noData;

  /// No description provided for @yesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get yesterday;

  /// No description provided for @today.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get today;

  /// No description provided for @daysAgo.
  ///
  /// In ru, this message translates to:
  /// **'{count} дн. назад'**
  String daysAgo(int count);

  /// No description provided for @addEntryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить запись'**
  String get addEntryTitle;

  /// No description provided for @choosePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Выберите категорию(ии) сверху'**
  String get choosePlaceholder;

  /// No description provided for @selectedPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Выбрано: '**
  String get selectedPrefix;

  /// No description provided for @greetingMorning.
  ///
  /// In ru, this message translates to:
  /// **'Доброе утро,'**
  String get greetingMorning;

  /// No description provided for @greetingDay.
  ///
  /// In ru, this message translates to:
  /// **'Добрый день,'**
  String get greetingDay;

  /// No description provided for @greetingEvening.
  ///
  /// In ru, this message translates to:
  /// **'Добрый вечер,'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In ru, this message translates to:
  /// **'Доброй ночи,'**
  String get greetingNight;

  /// No description provided for @defaultUserName.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь'**
  String get defaultUserName;

  /// No description provided for @unitMmHg.
  ///
  /// In ru, this message translates to:
  /// **'мм рт.ст.'**
  String get unitMmHg;

  /// No description provided for @unitBpm.
  ///
  /// In ru, this message translates to:
  /// **'уд/мин'**
  String get unitBpm;

  /// No description provided for @unitMmol.
  ///
  /// In ru, this message translates to:
  /// **'ммоль/л'**
  String get unitMmol;

  /// No description provided for @unitKg.
  ///
  /// In ru, this message translates to:
  /// **'кг'**
  String get unitKg;

  /// No description provided for @unitCm.
  ///
  /// In ru, this message translates to:
  /// **'см'**
  String get unitCm;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfile;

  /// No description provided for @personalData.
  ///
  /// In ru, this message translates to:
  /// **'Личные данные'**
  String get personalData;

  /// No description provided for @physicalParams.
  ///
  /// In ru, this message translates to:
  /// **'Физические параметры'**
  String get physicalParams;

  /// No description provided for @firstName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get firstName;

  /// No description provided for @birthDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDate;

  /// No description provided for @height.
  ///
  /// In ru, this message translates to:
  /// **'Рост'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get weight;

  /// No description provided for @age.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get age;

  /// No description provided for @yearsOld.
  ///
  /// In ru, this message translates to:
  /// **'лет'**
  String get yearsOld;

  /// No description provided for @clearData.
  ///
  /// In ru, this message translates to:
  /// **'Очистить данные'**
  String get clearData;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @history.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get history;

  /// No description provided for @schedule.
  ///
  /// In ru, this message translates to:
  /// **'Расписание'**
  String get schedule;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @metricPressure.
  ///
  /// In ru, this message translates to:
  /// **'Давление'**
  String get metricPressure;

  /// No description provided for @metricPulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get metricPulse;

  /// No description provided for @metricWeight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get metricWeight;

  /// No description provided for @metricSugar.
  ///
  /// In ru, this message translates to:
  /// **'Сахар'**
  String get metricSugar;

  /// No description provided for @metricPressureUpper.
  ///
  /// In ru, this message translates to:
  /// **'ДАВЛЕНИЕ'**
  String get metricPressureUpper;

  /// No description provided for @metricPulseUpper.
  ///
  /// In ru, this message translates to:
  /// **'ПУЛЬС'**
  String get metricPulseUpper;

  /// No description provided for @metricWeightUpper.
  ///
  /// In ru, this message translates to:
  /// **'ВЕС'**
  String get metricWeightUpper;

  /// No description provided for @metricSugarUpper.
  ///
  /// In ru, this message translates to:
  /// **'САХАР'**
  String get metricSugarUpper;

  /// No description provided for @historyNoRecords.
  ///
  /// In ru, this message translates to:
  /// **'Записей пока нет'**
  String get historyNoRecords;

  /// No description provided for @historyAddFirst.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте первое измерение'**
  String get historyAddFirst;

  /// No description provided for @historyYourMeasurements.
  ///
  /// In ru, this message translates to:
  /// **'Ваши измерения'**
  String get historyYourMeasurements;

  /// No description provided for @onboardingWelcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать!'**
  String get onboardingWelcome;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Давайте познакомимся'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingQuestion.
  ///
  /// In ru, this message translates to:
  /// **'Как к вам можно обращаться?'**
  String get onboardingQuestion;

  /// No description provided for @onboardingNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Ваше имя'**
  String get onboardingNameHint;

  /// No description provided for @onboardingContinue.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get onboardingContinue;

  /// No description provided for @onboardingFinish.
  ///
  /// In ru, this message translates to:
  /// **'Начать'**
  String get onboardingFinish;

  /// No description provided for @onboardingBirthDateTitle.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get onboardingBirthDateTitle;

  /// No description provided for @onboardingBirthDateSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это поможет рассчитать ваш возраст'**
  String get onboardingBirthDateSubtitle;

  /// No description provided for @onboardingSelectDate.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get onboardingSelectDate;

  /// No description provided for @onboardingHeightTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш рост'**
  String get onboardingHeightTitle;

  /// No description provided for @onboardingHeightSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите ваш рост в сантиметрах'**
  String get onboardingHeightSubtitle;

  /// No description provided for @onboardingWeightTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш вес'**
  String get onboardingWeightTitle;

  /// No description provided for @onboardingWeightSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите ваш вес в килограммах'**
  String get onboardingWeightSubtitle;

  /// No description provided for @upperPressure.
  ///
  /// In ru, this message translates to:
  /// **'Верхнее давление'**
  String get upperPressure;

  /// No description provided for @lowerPressure.
  ///
  /// In ru, this message translates to:
  /// **'Нижнее давление'**
  String get lowerPressure;

  /// No description provided for @pulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get pulse;

  /// No description provided for @sugarLevel.
  ///
  /// In ru, this message translates to:
  /// **'Уровень сахара'**
  String get sugarLevel;

  /// No description provided for @dynamics.
  ///
  /// In ru, this message translates to:
  /// **'Динамика'**
  String get dynamics;

  /// No description provided for @week.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get week;

  /// No description provided for @weekdayMon.
  ///
  /// In ru, this message translates to:
  /// **'Пн'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In ru, this message translates to:
  /// **'Вт'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In ru, this message translates to:
  /// **'Ср'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In ru, this message translates to:
  /// **'Чт'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In ru, this message translates to:
  /// **'Пт'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In ru, this message translates to:
  /// **'Сб'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In ru, this message translates to:
  /// **'Вс'**
  String get weekdaySun;

  /// No description provided for @scheduleManageReminders.
  ///
  /// In ru, this message translates to:
  /// **'Управляйте напоминаниями'**
  String get scheduleManageReminders;

  /// No description provided for @scheduleActive.
  ///
  /// In ru, this message translates to:
  /// **'Активные'**
  String get scheduleActive;

  /// No description provided for @scheduleInactive.
  ///
  /// In ru, this message translates to:
  /// **'Неактивные'**
  String get scheduleInactive;

  /// No description provided for @scheduleActiveCount.
  ///
  /// In ru, this message translates to:
  /// **'Активных'**
  String get scheduleActiveCount;

  /// No description provided for @scheduleTotal.
  ///
  /// In ru, this message translates to:
  /// **'Всего'**
  String get scheduleTotal;

  /// No description provided for @newReminder.
  ///
  /// In ru, this message translates to:
  /// **'Новое напоминание'**
  String get newReminder;

  /// No description provided for @editing.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get editing;

  /// No description provided for @basicData.
  ///
  /// In ru, this message translates to:
  /// **'Основные данные'**
  String get basicData;

  /// No description provided for @notificationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Название уведомления (необязательно)'**
  String get notificationTitle;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание (необязательно)'**
  String get description;

  /// No description provided for @timeAndRepeat.
  ///
  /// In ru, this message translates to:
  /// **'Время и повтор'**
  String get timeAndRepeat;

  /// No description provided for @time.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get time;

  /// No description provided for @repeat.
  ///
  /// In ru, this message translates to:
  /// **'Повтор'**
  String get repeat;

  /// No description provided for @startDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get startDate;

  /// No description provided for @notificationStyle.
  ///
  /// In ru, this message translates to:
  /// **'Оформление уведомления'**
  String get notificationStyle;

  /// No description provided for @notificationType.
  ///
  /// In ru, this message translates to:
  /// **'Тип уведомления'**
  String get notificationType;

  /// No description provided for @cardColor.
  ///
  /// In ru, this message translates to:
  /// **'Цвет карточки'**
  String get cardColor;

  /// No description provided for @repeatDaily.
  ///
  /// In ru, this message translates to:
  /// **'Каждый день'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In ru, this message translates to:
  /// **'Каждую неделю'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In ru, this message translates to:
  /// **'Раз в месяц'**
  String get repeatMonthly;

  /// No description provided for @repeatWeekdays.
  ///
  /// In ru, this message translates to:
  /// **'По будням'**
  String get repeatWeekdays;

  /// No description provided for @notifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications;

  /// No description provided for @reminders.
  ///
  /// In ru, this message translates to:
  /// **'Напоминания'**
  String get reminders;

  /// No description provided for @dailySummary.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневная сводка'**
  String get dailySummary;

  /// No description provided for @appearance.
  ///
  /// In ru, this message translates to:
  /// **'Внешний вид'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @fontSize.
  ///
  /// In ru, this message translates to:
  /// **'Размер текста'**
  String get fontSize;

  /// No description provided for @fontSizeNormal.
  ///
  /// In ru, this message translates to:
  /// **'Обычный'**
  String get fontSizeNormal;

  /// No description provided for @other.
  ///
  /// In ru, this message translates to:
  /// **'Прочее'**
  String get other;

  /// No description provided for @typeStandard.
  ///
  /// In ru, this message translates to:
  /// **'Стандартное'**
  String get typeStandard;

  /// No description provided for @colorPurple.
  ///
  /// In ru, this message translates to:
  /// **'Фиолетовый'**
  String get colorPurple;

  /// No description provided for @measurePressure.
  ///
  /// In ru, this message translates to:
  /// **'Измерить давление'**
  String get measurePressure;

  /// No description provided for @eveningMeasurement.
  ///
  /// In ru, this message translates to:
  /// **'Вечернее измерение'**
  String get eveningMeasurement;

  /// No description provided for @weighing.
  ///
  /// In ru, this message translates to:
  /// **'Взвешивание'**
  String get weighing;

  /// No description provided for @recordSugar.
  ///
  /// In ru, this message translates to:
  /// **'Записать сахар'**
  String get recordSugar;

  /// No description provided for @doctorVisit.
  ///
  /// In ru, this message translates to:
  /// **'Визит к врачу'**
  String get doctorVisit;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In ru, this message translates to:
  /// **'Разрешение на уведомления не получено. Включите в настройках.'**
  String get notificationPermissionDenied;

  /// No description provided for @defaultReminderTitlePressure.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте давление!'**
  String get defaultReminderTitlePressure;

  /// No description provided for @defaultReminderTitlePulse.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте пульс!'**
  String get defaultReminderTitlePulse;

  /// No description provided for @defaultReminderTitleWeight.
  ///
  /// In ru, this message translates to:
  /// **'Время взвеситься!'**
  String get defaultReminderTitleWeight;

  /// No description provided for @defaultReminderTitleSugar.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте уровень сахара!'**
  String get defaultReminderTitleSugar;

  /// No description provided for @defaultReminderTitleOther.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание'**
  String get defaultReminderTitleOther;

  /// No description provided for @defaultReminderDescription.
  ///
  /// In ru, this message translates to:
  /// **'Регулярные измерения важны для здоровья'**
  String get defaultReminderDescription;

  /// No description provided for @notificationCategoryPressure.
  ///
  /// In ru, this message translates to:
  /// **'Давление'**
  String get notificationCategoryPressure;

  /// No description provided for @notificationCategoryPulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get notificationCategoryPulse;

  /// No description provided for @notificationCategoryWeight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get notificationCategoryWeight;

  /// No description provided for @notificationCategorySugar.
  ///
  /// In ru, this message translates to:
  /// **'Сахар'**
  String get notificationCategorySugar;

  /// No description provided for @notificationCategoryOther.
  ///
  /// In ru, this message translates to:
  /// **'Прочее'**
  String get notificationCategoryOther;

  /// No description provided for @notificationCategoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get notificationCategoryLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
