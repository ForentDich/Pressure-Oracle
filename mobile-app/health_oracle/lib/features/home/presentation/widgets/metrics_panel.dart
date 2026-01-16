import 'package:flutter/material.dart';
import 'package:health_oracle/features/home/presentation/widgets/metrics_grid.dart';
import 'package:health_oracle/features/home/presentation/widgets/add_record_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/helpers/modal_helper.dart';

class MetricsPanel extends StatefulWidget {
  final double top;
  
  const MetricsPanel({
    super.key,
    required this.top,
  });

  @override
  State<MetricsPanel> createState() => _MetricsPanelState();
}

class _MetricsPanelState extends State<MetricsPanel> {
  final GlobalKey<MetricsGridState> _metricsGridKey = GlobalKey<MetricsGridState>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              MetricsGrid(key: _metricsGridKey),
              const SizedBox(height: 16),
              AddRecordButton(onPressed: () async {
                final result = await ModalHelper.showBottomEntryMenu(context);
                if (result != null) {
                  // Обновляем данные после добавления записи
                  _metricsGridKey.currentState?.refresh();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}