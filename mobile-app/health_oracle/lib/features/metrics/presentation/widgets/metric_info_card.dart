import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class MetricInfoCard extends StatelessWidget {
  final MetricInterface metric;

  const MetricInfoCard({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'О метрике',
            style: TextStyles.titleMedium.copyWith(
              color: AppTheme.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            metric.description,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}