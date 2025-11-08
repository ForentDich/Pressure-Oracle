import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';

class MetricHistory extends StatelessWidget {
  final MetricInterface metric;

  const MetricHistory({
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
            'История измерений',
            style: TextStyles.titleMedium.copyWith(
              color: AppColors.neutral800,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'История мамбо',
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