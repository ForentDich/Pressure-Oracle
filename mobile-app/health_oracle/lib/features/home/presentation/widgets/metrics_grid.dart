
import 'package:flutter/material.dart';
import '../../../../core/widgets/health_card.dart';
import '../../../../core/theme/colors.dart';

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            padding: EdgeInsets.zero,
            children: [
              HealthCard(
                title: 'ДАВЛЕНИЕ',
                value: '120/80',
                unit: 'мм рт.ст.',
                lastUpdate: 'Сегодня',
                gradient: AppColors.pressureGradient,
                icon: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              HealthCard(
                title: 'ПУЛЬС',
                value: '72',
                unit: 'уд/мин',
                lastUpdate: 'Сегодня',
                gradient: AppColors.pulseGradient,
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              HealthCard(
                title: 'САХАР',
                value: '5.2',
                unit: 'ммоль/л',
                lastUpdate: '2 дня назад',
                gradient: AppColors.sugarGradient,
                icon: const Icon(
                  Icons.bloodtype_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              
              HealthCard(
                title: 'ВЕС',
                value: '75.2',
                unit: 'кг',
                lastUpdate: 'Неделю назад',
                gradient: AppColors.weightGradient,
                icon: const Icon(
                  Icons.monitor_weight_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}