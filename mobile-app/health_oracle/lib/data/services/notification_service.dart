import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_oracle/data/services/theme_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../../l10n/app_localizations.dart';
import '../models/reminder.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('ic_stat_notification');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
    _initialized = true;
  }

  static Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    bool granted = false;

    if (android != null) {
      final result = await android.requestNotificationsPermission();
      granted = result ?? false;
    }

    if (ios != null) {
      final result = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      granted = result ?? false;
    }

    return granted;
  }

  static Future<bool> hasPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      final result = await android.areNotificationsEnabled();
      return result ?? false;
    }
    
    return true;
  }

  static AppLocalizations get _l10n {
    final locale = PlatformDispatcher.instance.locale;
    return lookupAppLocalizations(locale);
  }

  static String _getCategoryName(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return _l10n.notificationCategoryPressure;
      case ReminderCategory.pulse:
        return _l10n.notificationCategoryPulse;
      case ReminderCategory.weight:
        return _l10n.notificationCategoryWeight;
      case ReminderCategory.sugar:
        return _l10n.notificationCategorySugar;
      case ReminderCategory.other:
        return _l10n.notificationCategoryOther;
    }
  }

  static Future<void> scheduleReminder(Reminder reminder) async {
    if (!reminder.isActive) return;

    if (!ThemeService.instance.notificationsEnabled) {
    return;
    }

    final notificationId = reminder.id.hashCode;
    final categoryName = _getCategoryName(reminder.category);
    final categoryLabel = _l10n.notificationCategoryLabel;
    final body = reminder.description?.isNotEmpty == true
        ? '${reminder.description}\n$categoryLabel: $categoryName'
        : '$categoryLabel: $categoryName';

    final androidDetails = AndroidNotificationDetails(
      'reminders',
      'Напоминания',
      channelDescription: 'Напоминания о измерениях',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_stat_notification',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    DateTimeComponents? matchComponents;
    switch (reminder.repeatType) {
      case RepeatType.daily:
        matchComponents = DateTimeComponents.time;
        break;
      case RepeatType.weekly:
        matchComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
      case RepeatType.monthly:
        matchComponents = DateTimeComponents.dayOfMonthAndTime;
        break;
      case RepeatType.weekdays:
        matchComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
    }

    await _plugin.zonedSchedule(
      notificationId,
      reminder.title,
      body,
      tzScheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: matchComponents,
    );
  }

  static Future<void> cancelReminder(Reminder reminder) async {
    final notificationId = reminder.id.hashCode;
    await _plugin.cancel(notificationId);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static Future<void> rescheduleAllReminders(List<Reminder> reminders) async {
    await cancelAll();
    for (final reminder in reminders) {
      if (reminder.isActive) {
        await scheduleReminder(reminder);
      }
    }
  }
}
