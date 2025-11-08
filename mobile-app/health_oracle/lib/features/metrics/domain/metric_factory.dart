import 'metric_interface.dart';
import 'metrics/pressure_metric.dart';
import 'metrics/sugar_metric.dart';
import 'metrics/weight_metric.dart';
import 'metrics/pulse_metric.dart';

enum MetricType { pressure, sugar, weight, pulse }

class MetricFactory {
  static MetricInterface create(MetricType type) {
    switch (type) {
      case MetricType.pressure:
        return PressureMetric();
      case MetricType.sugar:
        return SugarMetric();
      case MetricType.weight:
        return WeightMetric();
      case MetricType.pulse:
        return PulseMetric();
    }
  }

  static List<MetricType> get allTypes => MetricType.values;
}
