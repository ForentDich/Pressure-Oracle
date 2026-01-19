// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 5;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      hour: fields[3] as int,
      minute: fields[4] as int,
      repeatType: fields[5] as RepeatType,
      category: fields[6] as ReminderCategory,
      isActive: fields[7] as bool,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.repeatType)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepeatTypeAdapter extends TypeAdapter<RepeatType> {
  @override
  final int typeId = 3;

  @override
  RepeatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatType.daily;
      case 1:
        return RepeatType.weekly;
      case 2:
        return RepeatType.monthly;
      case 3:
        return RepeatType.weekdays;
      default:
        return RepeatType.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatType obj) {
    switch (obj) {
      case RepeatType.daily:
        writer.writeByte(0);
        break;
      case RepeatType.weekly:
        writer.writeByte(1);
        break;
      case RepeatType.monthly:
        writer.writeByte(2);
        break;
      case RepeatType.weekdays:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReminderCategoryAdapter extends TypeAdapter<ReminderCategory> {
  @override
  final int typeId = 4;

  @override
  ReminderCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderCategory.pressure;
      case 1:
        return ReminderCategory.pulse;
      case 2:
        return ReminderCategory.weight;
      case 3:
        return ReminderCategory.sugar;
      case 4:
        return ReminderCategory.other;
      default:
        return ReminderCategory.pressure;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderCategory obj) {
    switch (obj) {
      case ReminderCategory.pressure:
        writer.writeByte(0);
        break;
      case ReminderCategory.pulse:
        writer.writeByte(1);
        break;
      case ReminderCategory.weight:
        writer.writeByte(2);
        break;
      case ReminderCategory.sugar:
        writer.writeByte(3);
        break;
      case ReminderCategory.other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
