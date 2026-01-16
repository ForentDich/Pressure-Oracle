import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

part 'health_entry.g.dart';


@HiveType(typeId: 1)
enum EntryType {
  @HiveField(0)
  pressure,
  
  @HiveField(1)
  pulse,
  
  @HiveField(2)
  weight,
  
  @HiveField(3)
  sugar,
}


@HiveType(typeId: 2)
class HealthEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  EntryType type;

  @HiveField(2)
  DateTime createdAt;


  @HiveField(3)
  double value;


  @HiveField(4)
  double? secondaryValue;


  @HiveField(5)
  String? note;

  HealthEntry({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.value,
    this.secondaryValue,
    this.note,
  });


  String get displayValue {
    switch (type) {
      case EntryType.pressure:
        return '${value.toInt()}/${secondaryValue?.toInt() ?? 0}';
      case EntryType.pulse:
        return '${value.toInt()}';
      case EntryType.weight:
        return value.toStringAsFixed(1);
      case EntryType.sugar:
        return value.toStringAsFixed(1);
    }
  }

  String unit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case EntryType.pressure:
        return l10n.unitMmHg;
      case EntryType.pulse:
        return l10n.unitBpm;
      case EntryType.weight:
        return l10n.unitKg;
      case EntryType.sugar:
        return l10n.unitMmol;
    }
  }

  String typeName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case EntryType.pressure:
        return l10n.metricPressure;
      case EntryType.pulse:
        return l10n.metricPulse;
      case EntryType.weight:
        return l10n.metricWeight;
      case EntryType.sugar:
        return l10n.metricSugar;
    }
  }
}
