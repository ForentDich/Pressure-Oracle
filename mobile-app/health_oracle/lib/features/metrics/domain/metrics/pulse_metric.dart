import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';

class PulseMetric implements MetricInterface {
  @override
  String get title => 'ПУЛЬС';
  
  @override
  String get unit => 'уд/мин';
  
  @override
  Gradient get gradient => AppColors.pulseGradient;
  
  @override
  IconData get icon => Icons.favorite_outline;
  
  @override
  String get currentValue => '72';
  
  @override
  String get description => 'Частота сердечных сокращений в покое у взрослых: 60-100 ударов в минуту';
  
  @override
  String get lastUpdate => 'Сегодня 09:45';
}