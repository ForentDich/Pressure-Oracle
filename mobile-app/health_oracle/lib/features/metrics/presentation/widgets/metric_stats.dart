import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';

class MetricStats extends StatelessWidget {
  final MetricInterface metric;

  const MetricStats({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    final lastEntry = EntryService.getLastByType(metric.entryType);
    final currentValue = lastEntry != null ? metric.formatValue(lastEntry) : '—';

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
                lastEntry != null ? context.l10n.today : context.l10n.noData,
                style: TextStyles.labelSmall.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentValue,
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