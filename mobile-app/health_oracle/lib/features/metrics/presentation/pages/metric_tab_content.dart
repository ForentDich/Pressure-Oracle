import 'package:flutter/material.dart';
import '../../domain/metric_factory.dart';
import '../widgets/metric_chart.dart';
import '../widgets/metric_history.dart';
import '../widgets/metric_info_card.dart';
import '../widgets/metric_stats.dart';

class MetricTabContent extends StatelessWidget {
  final MetricType metricType;

  const MetricTabContent({
    super.key,
    required this.metricType,
  });

  @override
  Widget build(BuildContext context) {
    final metric = MetricFactory.create(metricType);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MetricStats(metric: metric),
          const SizedBox(height: 16),
          MetricChart(metric: metric),
          const SizedBox(height: 16),
          MetricHistory(metric: metric),
          const SizedBox(height: 16),
          MetricInfoCard(metric: metric),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}