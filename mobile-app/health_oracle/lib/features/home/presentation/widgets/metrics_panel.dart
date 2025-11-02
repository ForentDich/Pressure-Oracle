import 'package:flutter/material.dart';
import 'package:health_oracle/features/home/presentation/widgets/metrics_grid.dart';
import 'package:health_oracle/features/home/presentation/widgets/add_record_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/bottom_entry_menu.dart';

class MetricsPanel extends StatelessWidget {
  final double top;
  
  const MetricsPanel({
    super.key,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
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
              const MetricsGrid(),
              const SizedBox(height: 16),
              AddRecordButton(onPressed: () async {
                // Open reusable bottom entry menu from core. It returns selected categories on Save.
                final result = await showBottomEntryMenu(context);
                // For now just print selected categories.
                if (result != null) {
                  // ignore: avoid_print
                  print('Selected categories from bottom sheet: $result');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}