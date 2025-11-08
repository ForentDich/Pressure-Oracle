import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';

class MetricStats extends StatelessWidget {
  final MetricInterface metric;

  const MetricStats({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: metric.gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Текущее значение',
                style: TextStyles.labelSmall.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                metric.currentValue,
                style: TextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              Text(
                metric.unit,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Icon(metric.icon, color: Colors.white, size: 40),
        ],
      ),
    );
  }
}