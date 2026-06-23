import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class WeightMetric implements MetricInterface {
  @override
  String get title => 'ВЕС';
  
  @override
  String get description => 'Регулярное отслеживание веса помогает контролировать физическую форму и вовремя замечать изменения в организме.';
  
  @override
  String get unit => 'кг';
  
  @override
  Gradient get gradient => AppColors.weightGradient;
  
  @override
  IconData get icon => Icons.monitor_weight_outlined;
  
  @override
  EntryType get entryType => EntryType.weight;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toStringAsFixed(1);
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}