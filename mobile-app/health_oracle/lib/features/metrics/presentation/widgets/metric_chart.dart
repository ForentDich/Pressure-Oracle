import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';

class MetricChart extends StatelessWidget {
  final MetricInterface metric;

  const MetricChart({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'График ${metric.title.toLowerCase()}',
            style: TextStyles.titleMedium.copyWith(
              color: AppColors.neutral800,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'График мамбо',
                style: TextStyles.bodyMedium.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}