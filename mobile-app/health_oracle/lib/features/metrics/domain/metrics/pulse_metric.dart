import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class PulseMetric implements MetricInterface {
  @override
  String get title => 'ПУЛЬС';
  
  @override
  String get description => 'Пульс показывает частоту сердечных сокращений в минуту. Нормальный пульс в покое — 60-100 ударов в минуту.';
  
  @override
  String get unit => 'уд/мин';
  
  @override
  Gradient get gradient => AppColors.pulseGradient;
  
  @override
  IconData get icon => Icons.favorite_outline;
  
  @override
  EntryType get entryType => EntryType.pulse;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toInt().toString();
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}