import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';

class WeightMetric implements MetricInterface {
  @override
  String get title => 'ВЕС';
  
  @override
  String get unit => 'кг';
  
  @override
  Gradient get gradient => AppColors.weightGradient;
  
  @override
  IconData get icon => Icons.monitor_weight_outlined;
  
  @override
  String get currentValue => '75.2';
  
  @override
  String get description => 'Контроль веса помогает следить за общим состоянием здоровья и эффективностью диеты/тренировок';
  
  @override
  String get lastUpdate => '3 дня назад';
}