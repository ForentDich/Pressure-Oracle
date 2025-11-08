import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/metric_factory.dart';
import 'metric_tab_content.dart';

class MetricsContainerPage extends StatefulWidget {
  final MetricType initialTab;

  const MetricsContainerPage({
    super.key,
    this.initialTab = MetricType.pressure,
  });

  @override
  State<MetricsContainerPage> createState() => _MetricsContainerPageState();
}

class _MetricsContainerPageState extends State<MetricsContainerPage> {
  MetricType _selectedMetric = MetricType.pressure;

  @override
  void initState() {
    super.initState();
    _selectedMetric = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Метрики здоровья', style: TextStyles.titleMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: MetricFactory.allTypes.map((metricType) {
                final metric = MetricFactory.create(metricType);
                final isSelected = _selectedMetric == metricType;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMetric = metricType),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.surface : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: Text(
                        metric.title.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyles.bodyMedium.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppColors.neutral900 : AppColors.neutral600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),


          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: MetricTabContent(
                key: ValueKey(_selectedMetric),
                metricType: _selectedMetric,
              ),
            ),
          ),
        ],
      ),
    );
  }
}