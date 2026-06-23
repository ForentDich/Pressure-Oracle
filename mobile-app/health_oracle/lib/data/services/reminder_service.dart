import 'package:hive_flutter/hive_flutter.dart';
import '../models/reminder.dart';

class ReminderService {
  static const String _boxName = 'reminders';
  static Box<Reminder>? _box;

  static Future<void> init() async {
    Hive.registerAdapter(ReminderAdapter());
    Hive.registerAdapter(RepeatTypeAdapter());
    Hive.registerAdapter(ReminderCategoryAdapter());
    _box = await Hive.openBox<Reminder>(_boxName);
  }

  static Box<Reminder> get box {
    if (_box == null) {
      throw Exception('ReminderService not initialized. Call init() first.');
    }
    return _box!;
  }

  static Future<Reminder> add({
    required String title,
    String? description,
    required int hour,
    required int minute,
    required RepeatType repeatType,
    required ReminderCategory category,
    bool isActive = true,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final reminder = Reminder(
      id: id,
      title: title,
      description: description,
      hour: hour,
      minute: minute,
      repeatType: repeatType,
      category: category,
      isActive: isActive,
      createdAt: DateTime.now(),
    );
    await box.put(id, reminder);
    return reminder;
  }

  static Future<void> update(Reminder reminder) async {
    await reminder.save();
  }

  static Future<void> delete(String id) async {
    await box.delete(id);
  }

  static Future<void> deleteAll() async {
    await box.clear();
  }

  static Future<void> toggleActive(String id) async {
    final reminder = box.get(id);
    if (reminder != null) {
      reminder.isActive = !reminder.isActive;
      await reminder.save();
    }
  }

  static List<Reminder> getAll() {
    return box.values.toList();
  }

  static List<Reminder> getActive() {
    return box.values.where((r) => r.isActive).toList();
  }

  static List<Reminder> getInactive() {
    return box.values.where((r) => !r.isActive).toList();
  }

  static Reminder? getById(String id) {
    return box.get(id);
  }

  static int get activeCount => getActive().length;

  static int get totalCount => box.length;
}
