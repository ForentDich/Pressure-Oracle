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

  // Моковые данные для истории веса
  static const List<Map<String, dynamic>> _mockHistoryData = [
    {'date': '29 нояб', 'time': '08:15', 'value': '72.5', 'unit': 'кг', 'change': -0.3},
    {'date': '28 нояб', 'time': '08:20', 'value': '72.8', 'unit': 'кг', 'change': 0.1},
    {'date': '27 нояб', 'time': '07:45', 'value': '72.7', 'unit': 'кг', 'change': -0.2},
    {'date': '26 нояб', 'time': '08:30', 'value': '72.9', 'unit': 'кг', 'change': 0.0},
    {'date': '25 нояб', 'time': '08:10', 'value': '72.9', 'unit': 'кг', 'change': -0.4},
  ];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'История измерений',
                style: TextStyles.titleMedium.copyWith(
                  color: AppColors.neutral800,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Все записи',
                  style: TextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._mockHistoryData.map((item) => _HistoryItem(
            date: item['date'] as String,
            time: item['time'] as String,
            value: item['value'] as String,
            unit: item['unit'] as String,
            change: item['change'] as double,
          )),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String date;
  final String time;
  final String value;
  final String unit;
  final double change;

  const _HistoryItem({
    required this.date,
    required this.time,
    required this.value,
    required this.unit,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.neutral50,
            AppColors.neutral100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neutral200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Иконка весов
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.weightGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.monitor_weight_outlined,
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
                  date,
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppColors.neutral800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyles.labelSmall.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ],
            ),
          ),
          // Значение
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: TextStyles.titleMedium.copyWith(
                      color: AppColors.neutral900,
                      fontWeight: FontWeight.bold,
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
              const SizedBox(height: 2),
              // Изменение
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    change < 0 
                        ? Icons.trending_down 
                        : change > 0 
                            ? Icons.trending_up 
                            : Icons.trending_flat,
                    size: 14,
                    color: change < 0 
                        ? AppColors.success500 
                        : change > 0 
                            ? AppColors.error500 
                            : AppColors.neutral500,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    change == 0 
                        ? '0.0' 
                        : '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}',
                    style: TextStyles.labelXSmall.copyWith(
                      color: change < 0 
                          ? AppColors.success500 
                          : change > 0 
                              ? AppColors.error500 
                              : AppColors.neutral500,
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