import 'package:flutter/material.dart';
import '../../../../core/widgets/health_card.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../../../metrics/presentation/pages/metrics_container_page.dart';
import '../../../metrics/domain/metric_factory.dart';

class MetricsGrid extends StatefulWidget {
  const MetricsGrid({super.key});

  @override
  State<MetricsGrid> createState() => MetricsGridState();
}

class MetricsGridState extends State<MetricsGrid> {
  HealthEntry? _lastPressure;
  HealthEntry? _lastPulse;
  HealthEntry? _lastSugar;
  HealthEntry? _lastWeight;

  @override
  void initState() {
    super.initState();
    _loadLastEntries();
  }

  void refresh() {
    _loadLastEntries();
  }

  void _loadLastEntries() {
    setState(() {
      _lastPressure = EntryService.getLastByType(EntryType.pressure);
      _lastPulse = EntryService.getLastByType(EntryType.pulse);
      _lastSugar = EntryService.getLastByType(EntryType.sugar);
      _lastWeight = EntryService.getLastByType(EntryType.weight);
    });
  }

  String _formatLastUpdate(BuildContext context, DateTime? date) {
    if (date == null) return context.l10n.noData;
    
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0 && date.day == now.day) {
      return context.l10n.today;
    } else if (diff.inDays <= 1 && date.day == now.subtract(const Duration(days: 1)).day) {
      return context.l10n.yesterday;
    } else if (diff.inDays < 7) {
      return '${diff.inDays} дн. назад';
    } else {
      return '${date.day}.${date.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            padding: EdgeInsets.zero,
            children: [
              HealthCard(
                title: context.l10n.metricPressureUpper,
                value: _lastPressure?.displayValue ?? '—/—',
                unit: context.l10n.unitMmHg,
                lastUpdate: _formatLastUpdate(context, _lastPressure?.createdAt),
                gradient: AppColors.pressureGradient,
                icon: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.pressure,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricPulseUpper,
                value: _lastPulse?.displayValue ?? '—',
                unit: context.l10n.unitBpm,
                lastUpdate: _formatLastUpdate(context, _lastPulse?.createdAt),
                gradient: AppColors.pulseGradient,
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.pulse,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricSugarUpper,
                value: _lastSugar?.displayValue ?? '—',
                unit: context.l10n.unitMmol,
                lastUpdate: _formatLastUpdate(context, _lastSugar?.createdAt),
                gradient: AppColors.sugarGradient,
                icon: const Icon(
                  Icons.bloodtype_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.sugar,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricWeightUpper,
                value: _lastWeight?.displayValue ?? '—',
                unit: context.l10n.unitKg,
                lastUpdate: _formatLastUpdate(context, _lastWeight?.createdAt),
                gradient: AppColors.weightGradient,
                icon: const Icon(
                  Icons.monitor_weight_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.weight,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}