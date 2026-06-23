import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class PressureMetric implements MetricInterface {
  @override
  String get title => 'ДАВЛЕНИЕ';
  
  @override
  String get description => 'Артериальное давление — ключевой маркер состояния сердечно-сосудистой системы, отражающий силу воздействия крови на стенки сосудов.';
  
  @override
  String get unit => 'мм рт.ст.';
  
  @override
  Gradient get gradient => AppColors.pressureGradient;
  
  @override
  IconData get icon => Icons.monitor_heart_outlined;
  
  @override
  EntryType get entryType => EntryType.pressure;
  
  @override
  String formatValue(HealthEntry entry) {
    final sys = entry.value.toInt();
    final dia = entry.secondaryValue?.toInt() ?? 0;
    return '$sys/$dia';
  }
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}