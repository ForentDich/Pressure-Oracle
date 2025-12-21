import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

enum MetricType {
  pressure,
  pulse,
  weight,
  sugar,
}

class HistoryCard extends StatelessWidget {
  final MetricType type;
  final String value;
  final String unit;
  final DateTime date;
  final String? secondaryValue;
  final String? secondaryUnit;
  final String? status;
  final Color? statusColor;

  const HistoryCard({
    super.key,
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
    this.secondaryValue,
    this.secondaryUnit,
    this.status,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final metricInfo = _getMetricInfo();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutral900.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (statusColor ?? metricInfo.color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              metricInfo.icon,
              size: 24,
              color: statusColor ?? metricInfo.color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      metricInfo.name,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppColors.neutral600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _formatTime(date),
                      style: TextStyles.labelSmall.copyWith(
                        color: AppColors.neutral500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          value,
                          style: TextStyles.headlineLarge.copyWith(
                            color: AppColors.neutral900,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyles.labelSmall.copyWith(
                            color: AppColors.neutral500,
                          ),
                        ),
                      ],
                    ),
                    if (secondaryValue != null)
                      _buildSecondaryValue()
                    else if (status != null)
                      _buildStatusChip(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (statusColor ?? AppColors.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status!,
        style: TextStyles.labelSmall.copyWith(
          color: statusColor ?? AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _MetricInfo _getMetricInfo() {
    switch (type) {
      case MetricType.pressure:
        return _MetricInfo('Давление', Icons.favorite_border, AppColors.primary);
      case MetricType.pulse:
        return _MetricInfo('Пульс', Icons.monitor_heart_outlined, const Color(0xFFEF4444));
      case MetricType.weight:
        return _MetricInfo('Вес', Icons.monitor_weight_outlined, const Color(0xFF3B82F6));
      case MetricType.sugar:
        return _MetricInfo('Сахар', Icons.water_drop_outlined, const Color(0xFFEAB308));
    }
  }



  Widget _buildSecondaryValue() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == MetricType.pressure ? Icons.favorite : Icons.show_chart,
            size: 12,
            color: AppColors.neutral600,
          ),
          const SizedBox(width: 4),
          Text(
            '$secondaryValue ${secondaryUnit ?? ''}',
            style: TextStyles.labelSmall.copyWith(
              color: AppColors.neutral700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _MetricInfo {
  final String name;
  final IconData icon;
  final Color color;

  _MetricInfo(this.name, this.icon, this.color);
}
