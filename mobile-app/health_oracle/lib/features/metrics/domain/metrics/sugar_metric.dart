import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class SugarMetric implements MetricInterface {
  @override
  String get title => 'САХАР';
  
  @override
  String get description => 'Уровень глюкозы в крови отражает концентрацию сахара и является главным показателем углеводного обмена в организме.';
  
  @override
  String get unit => 'ммоль/л';
  
  @override
  Gradient get gradient => AppColors.sugarGradient;
  
  @override
  IconData get icon => Icons.bloodtype_outlined;
  
  @override
  EntryType get entryType => EntryType.sugar;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toStringAsFixed(1);
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}