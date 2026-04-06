import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';

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
  final VoidCallback? onDelete;

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
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final metricInfo = _getMetricInfo(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context, shadowAlpha: 0.1, blurRadius: 8, shadowOffset: const Offset(0, 4)),
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (onDelete != null)
            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.error500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.error500,
                  ),
                ),
              ),
            ),
          Row(
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
                    Text(
                      metricInfo.name,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          value,
                          style: TextStyles.headlineLarge.copyWith(
                            color: AppTheme.textPrimary(context),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyles.labelSmall.copyWith(
                            color: AppTheme.textHint(context),
                          ),
                        ),
                        const Spacer(),
                        if (secondaryValue != null)
                          _buildSecondaryValue(context)
                        else if (status != null)
                          _buildStatusChip(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              _formatTime(date),
              style: TextStyles.bodyMedium.copyWith(
                color: AppColors.neutral700,
                fontWeight: FontWeight.w600,
              ),
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

  _MetricInfo _getMetricInfo(BuildContext context) {
    switch (type) {
      case MetricType.pressure:
        return _MetricInfo(context.l10n.metricPressure, Icons.favorite_border, AppColors.primary);
      case MetricType.pulse:
        return _MetricInfo(context.l10n.metricPulse, Icons.monitor_heart_outlined, const Color(0xFFEF4444));
      case MetricType.weight:
        return _MetricInfo(context.l10n.metricWeight, Icons.monitor_weight_outlined, const Color(0xFF3B82F6));
      case MetricType.sugar:
        return _MetricInfo(context.l10n.metricSugar, Icons.water_drop_outlined, const Color(0xFFEAB308));
    }
  }



  Widget _buildSecondaryValue(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == MetricType.pressure ? Icons.favorite : Icons.show_chart,
            size: 12,
            color: AppTheme.textSecondary(context),
          ),
          const SizedBox(width: 4),
          Text(
            '$secondaryValue ${secondaryUnit ?? ''}',
            style: TextStyles.labelSmall.copyWith(
              color: AppTheme.textSecondary(context),
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
