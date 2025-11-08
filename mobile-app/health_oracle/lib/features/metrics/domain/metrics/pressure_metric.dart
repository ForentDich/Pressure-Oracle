import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';

class PressureMetric implements MetricInterface {
  @override
  String get title => 'ДАВЛЕНИЕ';
  
  @override
  String get unit => 'мм рт.ст.';
  
  @override
  Gradient get gradient => AppColors.pressureGradient;
  
  @override
  IconData get icon => Icons.monitor_heart_outlined;
  
  @override
  String get currentValue => '120/80';
  
  @override
  String get description => 'Артериальное давление - важный показатель работы сердечно-сосудистой системы. Нормальные значения: 120/80 мм рт.ст.';
  
  @override
  String get lastUpdate => 'Сегодня 10:30';
}