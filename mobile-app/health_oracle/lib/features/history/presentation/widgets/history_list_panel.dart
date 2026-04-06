import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import 'history_filters.dart';
import 'history_card.dart';

class HistoryListPanel extends StatefulWidget {
  const HistoryListPanel({super.key});

  @override
  State<HistoryListPanel> createState() => _HistoryListPanelState();
}

class _HistoryListPanelState extends State<HistoryListPanel> {
  List<HealthEntry> _entries = [];
  Set<MetricType> _selectedTypes = {};

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    final entries = EntryService.getAll();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    setState(() {
      _entries = entries;
    });
  }

  List<HealthEntry> get _filteredEntries {
    if (_selectedTypes.isEmpty) return _entries;
    
    return _entries.where((entry) {
      return _selectedTypes.contains(_entryTypeToMetricType(entry.type));
    }).toList();
  }

  MetricType _entryTypeToMetricType(EntryType type) {
    switch (type) {
      case EntryType.pressure:
        return MetricType.pressure;
      case EntryType.pulse:
        return MetricType.pulse;
      case EntryType.weight:
        return MetricType.weight;
      case EntryType.sugar:
        return MetricType.sugar;
    }
  }

  void _handleFilterChange(String filterString) {
    final newSelectedTypes = <MetricType>{};
    if (filterString.isNotEmpty) {
      final filters = filterString.split(',');
      for (final filter in filters) {
        switch (filter) {
          case 'Давление':
            newSelectedTypes.add(MetricType.pressure);
            break;
          case 'Пульс':
            newSelectedTypes.add(MetricType.pulse);
            break;
          case 'Вес':
            newSelectedTypes.add(MetricType.weight);
            break;
          case 'Сахар':
            newSelectedTypes.add(MetricType.sugar);
            break;
        }
      }
    }
    
    setState(() {
      _selectedTypes = newSelectedTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredEntries;

    if (filteredList.isEmpty) {
      return Column(
        children: [
          HistoryFilters(
            onFilterChanged: _handleFilterChange,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: AppTheme.textHint(context),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.historyNoRecords,
                    style: TextStyles.titleMedium.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.historyAddFirst,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        HistoryFilters(
          onFilterChanged: _handleFilterChange,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final entry = filteredList[index];
              final showHeader = index == 0 || !_isSameDay(filteredList[index - 1].createdAt, entry.createdAt);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) _buildDateHeader(entry.createdAt),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HistoryCard(
                      type: _entryTypeToMetricType(entry.type),
                      value: entry.displayValue,
                      unit: entry.unit(context),
                      date: entry.createdAt,
                      onDelete: () => _showDeleteConfirmation(context, entry),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, HealthEntry entry) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.deleteEntry),
        content: Text('${entry.typeName(context)}: ${entry.displayValue} ${entry.unit(context)}'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppTheme.textSecondary(context)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l10n.delete,
              style: TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      await EntryService.delete(entry.id);
      _loadEntries();
    }
  }

  Widget _buildDateHeader(DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDateHeader(date),
            style: TextStyles.titleMedium.copyWith(
              color: AppColors.neutral800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0 && date.day == now.day) {
      return context.l10n.today;
    } else if (diff.inDays <= 1 && date.day == now.subtract(const Duration(days: 1)).day) {
      return context.l10n.yesterday;
    }
    
    return '${date.day}.${date.month}.${date.year}';
  }
}
