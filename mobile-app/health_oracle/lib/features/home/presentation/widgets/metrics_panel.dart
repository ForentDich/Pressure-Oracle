import 'package:flutter/material.dart';
import 'package:health_oracle/features/home/presentation/widgets/metrics_grid.dart';
import 'package:health_oracle/features/home/presentation/widgets/add_record_button.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/helpers/modal_helper.dart';
import '../../../../data/data.dart';
import '../../../analysis/presentation/pages/analysis_page.dart';

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
        decoration: BoxDecoration(
          color: AppTheme.background(context),
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
              const SizedBox(height: 12),
              _AnalysisButton(),
              const SizedBox(height: 12),
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

class _AnalysisButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AnalysisPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.analytics_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.analysisTitle,
                    style: TextStyles.headlineLarge.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    PredictionService.isHypertensionModelReady
                        ? context.l10n.analysisBased
                        : context.l10n.analysisModelNotLoaded,
                    style: TextStyles.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}