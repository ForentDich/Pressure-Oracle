import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';

class SugarMetric implements MetricInterface {
  @override
  String get title => 'САХАР';
  
  @override
  String get unit => 'ммоль/л';
  
  @override
  Gradient get gradient => AppColors.sugarGradient;
  
  @override
  IconData get icon => Icons.bloodtype_outlined;
  
  @override
  String get currentValue => '5.2';
  
  @override
  String get description => 'Уровень глюкозы в крови показывает эффективность углеводного обмена. Норма натощак: 3.3-5.5 ммоль/л';
  
  @override
  String get lastUpdate => 'Вчера 08:15';
}