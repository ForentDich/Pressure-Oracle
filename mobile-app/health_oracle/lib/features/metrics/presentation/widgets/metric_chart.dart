import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';
import '../../../../data/models/health_entry.dart';

class MetricChart extends StatefulWidget {
  final MetricInterface metric;

  const MetricChart({
    super.key,
    required this.metric,
  });

  @override
  State<MetricChart> createState() => _MetricChartState();
}

class _MetricChartState extends State<MetricChart> {
  int _selectedPeriod = 7; // days

  List<HealthEntry> _getEntriesForPeriod() {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: _selectedPeriod));
    return EntryService.getByTypeAndDateRange(
      widget.metric.entryType,
      startDate,
      now,
    );
  }

  List<String> _getLabelsFromEntries(List<HealthEntry> entries) {
    if (entries.isEmpty) return [];
    
    // Показываем до 7 меток равномерно распределённых
    final maxLabels = 7;
    final step = entries.length > maxLabels 
        ? (entries.length / maxLabels).ceil() 
        : 1;
    
    final labels = <String>[];
    for (int i = 0; i < entries.length; i += step) {
      final date = entries[i].createdAt;
      if (_selectedPeriod <= 7) {
        labels.add(DateFormat('E', 'ru').format(date)); // Пн, Вт...
      } else if (_selectedPeriod <= 30) {
        labels.add(DateFormat('d', 'ru').format(date)); // 1, 2, 3...
      } else {
        labels.add(DateFormat('MMM', 'ru').format(date)); // Янв, Фев...
      }
    }
    return labels;
  }

  String _getPeriodName(BuildContext context) {
    if (_selectedPeriod == 7) return context.l10n.week;
    if (_selectedPeriod == 30) return context.l10n.month;
    return context.l10n.year;
  }

  void _showPeriodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(context.l10n.week),
              trailing: _selectedPeriod == 7 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 7);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(context.l10n.month),
              trailing: _selectedPeriod == 30 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 30);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(context.l10n.year),
              trailing: _selectedPeriod == 365 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 365);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getEntriesForPeriod();
    final labels = _getLabelsFromEntries(entries);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.dynamics,
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                ),
              ),
              GestureDetector(
                onTap: () => _showPeriodPicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getPeriodName(context),
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppTheme.textSecondary(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      context.l10n.noDataForPeriod,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textHint(context),
                      ),
                    ),
                  )
                : CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: _ChartPainter(
                      entries: entries,
                      metric: widget.metric,
                      period: _selectedPeriod,
                    ),
                  ),
          ),
          if (labels.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels
                  .map((label) => Text(
                        label,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          color: AppTheme.textHint(context),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<HealthEntry> entries;
  final MetricInterface metric;
  final int period;

  _ChartPainter({
    required this.entries,
    required this.metric,
    required this.period,
  });

  double _getMainValue(HealthEntry entry) {
    return entry.value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (entries.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final gridPaint = Paint()
      ..color = const Color(0xFFE9ECEF)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Calculate normalized points
    final values = entries.map(_getMainValue).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final range = maxVal - minVal;
    
    List<double> points;
    if (range == 0) {
      points = values.map((_) => 0.5).toList();
    } else {
      points = values.map((v) => (v - minVal) / range * 0.8 + 0.1).toList();
    }

    final gradient = const LinearGradient(
      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.shader = gradient;

    if (points.length == 1) {
      // Single point - just draw a dot
      final x = size.width / 2;
      final y = size.height * (1 - points[0]);
      final pointPaint = Paint()
        ..color = const Color(0xFF667eea)
        ..style = PaintingStyle.fill;
      final pointBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 6, pointBorderPaint);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
      return;
    }

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * (1 - points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = size.width * (i - 1) / (points.length - 1);
        final prevY = size.height * (1 - points[i - 1]);
        final controlX = (prevX + x) / 2;
        path.cubicTo(controlX, prevY, controlX, y, x, y);
      }
    }
    canvas.drawPath(path, paint);

    // Draw area under the curve
    final areaPath = Path.from(path);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF667eea).withValues(alpha: 0.3),
          const Color(0xFF667eea).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(areaPath, areaPaint);

    // Draw points
    final pointPaint = Paint()
      ..color = const Color(0xFF667eea)
      ..style = PaintingStyle.fill;
    final pointBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * (1 - points[i]);
      canvas.drawCircle(Offset(x, y), 6, pointBorderPaint);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.entries != entries || oldDelegate.period != period;
  }
}