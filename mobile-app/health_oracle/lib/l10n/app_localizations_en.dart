// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteEntry => 'Delete entry?';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get noData => 'No data';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get today => 'Today';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get addEntryTitle => 'Add entry';

  @override
  String get choosePlaceholder => 'Select category(ies) above';

  @override
  String get selectedPrefix => 'Selected: ';

  @override
  String get greetingMorning => 'Good morning,';

  @override
  String get greetingDay => 'Good afternoon,';

  @override
  String get greetingEvening => 'Good evening,';

  @override
  String get greetingNight => 'Good night,';

  @override
  String get defaultUserName => 'User';

  @override
  String get unitMmHg => 'mmHg';

  @override
  String get unitBpm => 'bpm';

  @override
  String get unitMmol => 'mmol/L';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get personalData => 'Personal data';

  @override
  String get physicalParams => 'Physical parameters';

  @override
  String get firstName => 'First name';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get age => 'Age';

  @override
  String get yearsOld => 'years old';

  @override
  String get clearData => 'Clear data';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get schedule => 'Schedule';

  @override
  String get settings => 'Settings';

  @override
  String get metricPressure => 'Pressure';

  @override
  String get metricPulse => 'Pulse';

  @override
  String get metricWeight => 'Weight';

  @override
  String get metricSugar => 'Sugar';

  @override
  String get metricPressureUpper => 'PRESSURE';

  @override
  String get metricPulseUpper => 'PULSE';

  @override
  String get metricWeightUpper => 'WEIGHT';

  @override
  String get metricSugarUpper => 'SUGAR';

  @override
  String get historyNoRecords => 'No records yet';

  @override
  String get historyAddFirst => 'Add your first measurement';

  @override
  String get historyYourMeasurements => 'Your measurements';

  @override
  String get onboardingWelcome => 'Welcome!';

  @override
  String get onboardingSubtitle => 'Let\'s get to know each other';

  @override
  String get onboardingQuestion => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Your name';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingFinish => 'Start';

  @override
  String get onboardingBirthDateTitle => 'Date of birth';

  @override
  String get onboardingBirthDateSubtitle => 'This will help calculate your age';

  @override
  String get onboardingSelectDate => 'Select date';

  @override
  String get onboardingHeightTitle => 'Your height';

  @override
  String get onboardingHeightSubtitle => 'Enter your height in centimeters';

  @override
  String get onboardingWeightTitle => 'Your weight';

  @override
  String get onboardingWeightSubtitle => 'Enter your weight in kilograms';

  @override
  String get upperPressure => 'Upper pressure';

  @override
  String get lowerPressure => 'Lower pressure';

  @override
  String get pulse => 'Pulse';

  @override
  String get sugarLevel => 'Sugar level';

  @override
  String get dynamics => 'Dynamics';

  @override
  String get week => 'Week';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get scheduleManageReminders => 'Manage reminders';

  @override
  String get scheduleActive => 'Active';

  @override
  String get scheduleInactive => 'Inactive';

  @override
  String get scheduleActiveCount => 'Active';

  @override
  String get scheduleTotal => 'Total';

  @override
  String get newReminder => 'New reminder';

  @override
  String get editing => 'Editing';

  @override
  String get basicData => 'Basic data';

  @override
  String get notificationTitle => 'Notification title';

  @override
  String get description => 'Description';

  @override
  String get timeAndRepeat => 'Time and repeat';

  @override
  String get time => 'Time';

  @override
  String get repeat => 'Repeat';

  @override
  String get startDate => 'Start date';

  @override
  String get notificationStyle => 'Notification style';

  @override
  String get notificationType => 'Notification type';

  @override
  String get cardColor => 'Card color';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatMonthly => 'Once a month';

  @override
  String get repeatWeekdays => 'Weekdays';

  @override
  String get notifications => 'Notifications';

  @override
  String get reminders => 'Reminders';

  @override
  String get dailySummary => 'Daily summary';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get fontSize => 'Font size';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get other => 'Other';

  @override
  String get typeStandard => 'Standard';

  @override
  String get colorPurple => 'Purple';

  @override
  String get measurePressure => 'Measure pressure';

  @override
  String get eveningMeasurement => 'Evening measurement';

  @override
  String get weighing => 'Weighing';

  @override
  String get recordSugar => 'Record sugar';

  @override
  String get doctorVisit => 'Doctor visit';
}
