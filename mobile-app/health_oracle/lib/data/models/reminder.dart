import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 3)
enum RepeatType {
  @HiveField(0)
  daily,
  
  @HiveField(1)
  weekly,
  
  @HiveField(2)
  monthly,
  
  @HiveField(3)
  weekdays,
}

@HiveType(typeId: 4)
enum ReminderCategory {
  @HiveField(0)
  pressure,
  
  @HiveField(1)
  pulse,
  
  @HiveField(2)
  weight,
  
  @HiveField(3)
  sugar,
  
  @HiveField(4)
  other,
}

@HiveType(typeId: 5)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int hour;

  @HiveField(4)
  int minute;

  @HiveField(5)
  RepeatType repeatType;

  @HiveField(6)
  ReminderCategory category;

  @HiveField(7)
  bool isActive;

  @HiveField(8)
  DateTime createdAt;

  Reminder({
    required this.id,
    required this.title,
    this.description,
    required this.hour,
    required this.minute,
    required this.repeatType,
    required this.category,
    this.isActive = true,
    required this.createdAt,
  });

  String get timeString {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
