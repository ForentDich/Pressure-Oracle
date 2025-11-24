import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'history_filters.dart';
import 'history_card.dart';

class HistoryListPanel extends StatefulWidget {
  const HistoryListPanel({super.key});

  @override
  State<HistoryListPanel> createState() => _HistoryListPanelState();
}

class _HistoryListPanelState extends State<HistoryListPanel> {
  final List<_HistoryItem> _items = [];
  Set<MetricType> _selectedTypes = {};

  @override
  void initState() {
    super.initState();
    _generateMockData();
  }

  void _generateMockData() {
    final now = DateTime.now();
    _items.addAll([
      _HistoryItem(
        type: MetricType.pressure,
        value: '120/80',
        unit: 'мм рт.ст.',
        date: now.subtract(const Duration(hours: 2)),
        status: 'Норма',
        statusColor: AppColors.success500,
      ),
      _HistoryItem(
        type: MetricType.pulse,
        value: '64',
        unit: 'уд/мин',
        date: now.subtract(const Duration(hours: 2)),
        status: 'Норма',
        statusColor: AppColors.success500,
      ),
      _HistoryItem(
        type: MetricType.pulse,
        value: '98',
        unit: 'уд/мин',
        date: now.subtract(const Duration(hours: 2, minutes: 30)),
        status: 'Высокий',
        statusColor: AppColors.warning500,
      ),
      _HistoryItem(
        type: MetricType.pressure,
        value: '115/75',
        unit: 'мм рт.ст.',
        date: now.subtract(const Duration(hours: 3)),
        status: 'Оптимальное',
        statusColor: AppColors.success500,
      ),
      _HistoryItem(
        type: MetricType.weight,
        value: '75.5',
        unit: 'кг',
        date: now.subtract(const Duration(hours: 4)),
        secondaryValue: '-0.5',
        secondaryUnit: 'кг',
      ),
      _HistoryItem(
        type: MetricType.sugar,
        value: '5.5',
        unit: 'ммоль/л',
        date: now.subtract(const Duration(hours: 5)),
        status: 'Норма',
        statusColor: AppColors.success500,
      ),
      _HistoryItem(
        type: MetricType.pressure,
        value: '135/85',
        unit: 'мм рт.ст.',
        date: now.subtract(const Duration(days: 1, hours: 4)),
        status: 'Повышенное',
        statusColor: AppColors.warning500,
      ),
      _HistoryItem(
        type: MetricType.pulse,
        value: '72',
        unit: 'уд/мин',
        date: now.subtract(const Duration(days: 1, hours: 4)),
        status: 'Норма',
        statusColor: AppColors.success500,
      ),
      _HistoryItem(
        type: MetricType.pressure,
        value: '150/95',
        unit: 'мм рт.ст.',
        date: now.subtract(const Duration(days: 2, hours: 3)),
        status: 'Высокое',
        statusColor: AppColors.error500,
      ),
      _HistoryItem(
        type: MetricType.pulse,
        value: '88',
        unit: 'уд/мин',
        date: now.subtract(const Duration(days: 2, hours: 3)),
        status: 'Высокий',
        statusColor: AppColors.warning500,
      ),
    ]);
  }

  List<_HistoryItem> get _filteredItems {
    if (_selectedTypes.isEmpty) return _items;
    
    return _items.where((item) {
      return _selectedTypes.contains(item.type);
    }).toList();
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
    final filteredList = _filteredItems;

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
              final item = filteredList[index];
              final showHeader = index == 0 || !_isSameDay(filteredList[index - 1].date, item.date);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) _buildDateHeader(item.date),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HistoryCard(
                      type: item.type,
                      value: item.value,
                      unit: item.unit,
                      date: item.date,
                      secondaryValue: item.secondaryValue,
                      secondaryUnit: item.secondaryUnit,
                      status: item.status,
                      statusColor: item.statusColor,
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
      return 'Сегодня';
    } else if (diff.inDays <= 1 && date.day == now.subtract(const Duration(days: 1)).day) {
      return 'Вчера';
    }
    
    return '${date.day}.${date.month}.${date.year}';
  }
}

class _HistoryItem {
  final MetricType type;
  final String value;
  final String unit;
  final DateTime date;
  final String? secondaryValue;
  final String? secondaryUnit;
  final String? status;
  final Color? statusColor;

  _HistoryItem({
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
    this.secondaryValue,
    this.secondaryUnit,
    this.status,
    this.statusColor,
  });
}
