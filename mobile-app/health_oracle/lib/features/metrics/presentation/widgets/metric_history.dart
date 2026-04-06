import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';
import '../../../../data/models/health_entry.dart';

class MetricHistory extends StatelessWidget {
  final MetricInterface metric;
  final VoidCallback? onViewAll;

  const MetricHistory({
    super.key,
    required this.metric,
    this.onViewAll,
  });

  List<HealthEntry> _getRecentEntries() {
    final entries = EntryService.getByType(metric.entryType);
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries.take(3).toList(); // Только 3 последних
  }

  int _getTotalCount() {
    return EntryService.getByType(metric.entryType).length;
  }

  double _getChange(List<HealthEntry> entries, int index) {
    if (index >= entries.length - 1) return 0;
    final current = _getMainValue(entries[index]);
    final previous = _getMainValue(entries[index + 1]);
    return current - previous;
  }

  double _getMainValue(HealthEntry entry) {
    return entry.value;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getRecentEntries();
    final totalCount = _getTotalCount();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.historyYourMeasurements,
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                ),
              ),
              if (totalCount > 3 && onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    context.l10n.allRecords,
                    style: TextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      size: 48,
                      color: AppTheme.textHint(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.historyNoRecords,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textHint(context),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...entries.asMap().entries.map((e) {
              final index = e.key;
              final entry = e.value;
              final change = _getChange(entries, index);
              return _HistoryItem(
                entry: entry,
                metric: metric,
                change: change,
              );
            }),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final HealthEntry entry;
  final MetricInterface metric;
  final double change;

  const _HistoryItem({
    required this.entry,
    required this.metric,
    required this.change,
  });

  String _formatDate(DateTime date) {
    return DateFormat('d MMM', 'ru').format(date);
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceVariant(context),
            AppTheme.surface(context),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border(context),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Иконка
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: metric.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              metric.icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Дата и время
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(entry.createdAt),
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textPrimary(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTime(entry.createdAt),
                  style: TextStyles.labelSmall.copyWith(
                    color: AppTheme.textHint(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    metric.formatValueShort(entry),
                    style: TextStyles.titleMedium.copyWith(
                      color: AppTheme.textPrimary(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    metric.unit,
                    style: TextStyles.labelSmall.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // Изменение
              if (change != 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      change < 0 
                          ? Icons.trending_down 
                          : Icons.trending_up,
                      size: 14,
                      color: change < 0 
                          ? AppColors.success500 
                          : AppColors.error500,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}',
                      style: TextStyles.labelXSmall.copyWith(
                        color: change < 0 
                            ? AppColors.success500 
                            : AppColors.error500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}