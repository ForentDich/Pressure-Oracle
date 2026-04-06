import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';

enum _PressurePredictionMode { latest, average }

class AnalysisPressurePage extends StatefulWidget {
  const AnalysisPressurePage({super.key});

  @override
  State<AnalysisPressurePage> createState() => _AnalysisPressurePageState();
}

class _AnalysisPressurePageState extends State<AnalysisPressurePage>
    with WidgetsBindingObserver {
  HypertensionResult? _hypertensionResult;
  bool _loading = true;
  _PressurePredictionMode _mode = _PressurePredictionMode.average;

  DateTime? _debugLastRunAt;
  String? _debugLastError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _runAnalysis();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runAnalysis());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _runAnalysis();
    }
  }

  Future<void> _runAnalysis() async {
    if (!mounted) return;

    _debugLastRunAt = DateTime.now();
    _debugLastError = null;

    setState(() => _loading = true);

    HypertensionResult? nextResult;
    if (PredictionService.isHypertensionModelReady) {
      try {
        // Передаем флаг сервису.
        // ВНИМАНИЕ: Вам нужно зайти в PredictionService и добавить 
        // аргумент {bool isLatest = false} в метод predictHypertension()
        nextResult = PredictionService.predictHypertension(
          isLatest: _mode == _PressurePredictionMode.latest,
        );
      } catch (e) {
        _debugLastError = e.toString();
        if (kDebugMode) debugPrint(_debugLastError);
      }
    }

    if (!mounted) return;
    setState(() {
      if (nextResult != null) {
        _hypertensionResult = nextResult;
      } else if (_hypertensionResult == null) {
        _hypertensionResult = null;
      }
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!PredictionService.isHypertensionModelReady) {
      return _buildNoModel(context);
    }

    if (_hypertensionResult == null) {
      return _buildNoData(context);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModeSwitcher(context),
          const SizedBox(height: 8),
          Text(
            _mode == _PressurePredictionMode.average
                ? 'Прогноз: среднее значение'
                : 'Прогноз: последний показатель',
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textHint(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          _buildHypertensionCard(context, _hypertensionResult!),
          const SizedBox(height: 20),
          _buildCategoriesCard(context, _hypertensionResult!),
          const SizedBox(height: 20),
          _buildProbabilitiesCard(context, _hypertensionResult!),
          if (kDebugMode) ...[
            const SizedBox(height: 16),
            _buildInputsDebug(context, _hypertensionResult!),
          ],
        ],
      ),
    );
  }

  Widget _buildModeSwitcher(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildModeTab(
            context,
            label: 'По последнему',
            icon: Icons.bolt_rounded,
            selected: _mode == _PressurePredictionMode.latest,
            onTap: () {
              if (_mode == _PressurePredictionMode.latest) return;
              setState(() => _mode = _PressurePredictionMode.latest);
              _runAnalysis();
            },
          ),
          _buildModeTab(
            context,
            label: 'Среднее',
            icon: Icons.timeline_rounded,
            selected: _mode == _PressurePredictionMode.average,
            onTap: () {
              if (_mode == _PressurePredictionMode.average) return;
              setState(() => _mode = _PressurePredictionMode.average);
              _runAnalysis();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: selected ? AppTheme.surface(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: selected
                    ? AppTheme.textPrimary(context)
                    : AppTheme.textSecondary(context),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyles.bodyMedium.copyWith(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected
                      ? AppTheme.textPrimary(context)
                      : AppTheme.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoModel(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.model_training,
                size: 40,
                color: AppTheme.textHint(context),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.analysisModelNotLoaded,
              style: TextStyles.headlineLarge.copyWith(
                fontSize: 18,
                color: AppTheme.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoData(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.analytics_outlined,
                size: 40,
                color: AppTheme.textHint(context),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.analysisNoData,
              style: TextStyles.headlineLarge.copyWith(
                fontSize: 18,
                color: AppTheme.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.analysisNoDataHint,
              style: TextStyles.bodyMedium.copyWith(
                color: AppTheme.textHint(context),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: _runAnalysis,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Обновить анализ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.actionPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
            ),
            if (kDebugMode) ...[
              const SizedBox(height: 16),
              _buildDebugCard(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDebugCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border(context)),
      ),
      child: DefaultTextStyle(
        style: TextStyles.bodyMedium.copyWith(
          color: AppTheme.textSecondary(context),
          fontSize: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DEBUG'),
            const SizedBox(height: 6),
            Text('modelReady: ${PredictionService.isHypertensionModelReady}'),
            Text('mode: $_mode'),
            Text('lastRunAt: ${_debugLastRunAt?.toIso8601String() ?? '-'}'),
            Text('error: ${_debugLastError ?? '-'}'),
          ],
        ),
      ),
    );
  }

  Widget _buildHypertensionCard(BuildContext context, HypertensionResult result) {
    final severityColor = _severityColor(result.severity);
    final severityBgColor = _severityBgColor(result.severity);
    final confidencePercent = (result.confidence * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: severityBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.favorite_rounded, color: severityColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.analysisHypertension,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textHint(context),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.label,
                      style: TextStyles.headlineLarge.copyWith(
                        fontSize: 20,
                        color: severityColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.analysisConfidence,
                style: TextStyles.bodyMedium.copyWith(
                  color: AppTheme.textSecondary(context),
                  fontSize: 13,
                ),
              ),
              Text(
                '$confidencePercent%',
                style: TextStyles.bodyMedium.copyWith(
                  color: severityColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: result.confidence,
              minHeight: 8,
              backgroundColor: AppTheme.border(context),
              color: severityColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesCard(BuildContext context, HypertensionResult result) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.analysisCategories,
            style: TextStyles.headlineLarge.copyWith(
              fontSize: 16,
              color: AppTheme.textPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoryRow(context.l10n.analysisSBP, result.sbpCategory, Icons.arrow_upward_rounded),
          _buildCategoryRow(context.l10n.analysisDBP, result.dbpCategory, Icons.arrow_downward_rounded),
          _buildCategoryRow(context.l10n.analysisPulse, result.pulseCategory, Icons.monitor_heart_outlined),
          _buildCategoryRow(
            context.l10n.analysisBMI,
            '${result.bmiCategory} (${result.bmi.toStringAsFixed(1)})',
            Icons.accessibility_new_rounded,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(
    String label,
    String value,
    IconData icon, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppTheme.textSecondary(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: AppTheme.textSecondary(context),
                fontSize: 14,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyles.bodyMedium.copyWith(
                color: AppTheme.textPrimary(context),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProbabilitiesCard(BuildContext context, HypertensionResult result) {
    final labels = [
      context.l10n.analysisNormal,
      context.l10n.analysisPrehypertension,
      context.l10n.analysisStage1,
      context.l10n.analysisStage2,
    ];

    final colors = [
      AppColors.success500,
      AppColors.warning500,
      const Color(0xFFFF8C00),
      AppColors.error500,
    ];

    final length = result.probabilities.length.clamp(0, 4);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.analysisSubtitle,
            style: TextStyles.headlineLarge.copyWith(
              fontSize: 16,
              color: AppTheme.textPrimary(context),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(length, (i) {
            final prob = result.probabilities[i];
            final percent = (prob * 100).toStringAsFixed(1);
            final isActive = i == result.classIndex;

            return Padding(
              padding: EdgeInsets.only(bottom: i < length - 1 ? 12 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (isActive)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: colors[i],
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            labels[i],
                            style: TextStyles.bodyMedium.copyWith(
                              color: isActive
                                  ? AppTheme.textPrimary(context)
                                  : AppTheme.textSecondary(context),
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$percent%',
                        style: TextStyles.bodyMedium.copyWith(
                          color: colors[i],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: prob,
                      minHeight: 6,
                      backgroundColor: AppTheme.border(context),
                      color: colors[i],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInputsDebug(BuildContext context, HypertensionResult r) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border(context)),
      ),
      child: DefaultTextStyle(
        style: TextStyles.bodyMedium.copyWith(
          color: AppTheme.textSecondary(context),
          fontSize: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DEBUG'),
            const SizedBox(height: 6),
            Text('mode(UI): $_mode'),
            Text('label: ${r.label}'),
            Text('classIndex: ${r.classIndex}'),
            Text('confidence: ${(r.confidence * 100).toStringAsFixed(1)}%'),
            Text('cats: ${r.sbpCategory} | ${r.dbpCategory} | ${r.pulseCategory} | ${r.bmiCategory}'),
            Text('lastRunAt: ${_debugLastRunAt?.toIso8601String() ?? '-'}'),
            Text('error: ${_debugLastError ?? '-'}'),
          ],
        ),
      ),
    );
  }

  Color _severityColor(int severity) {
    switch (severity) {
      case 0:
        return AppColors.success500;
      case 1:
        return AppColors.warning500;
      case 2:
        return const Color(0xFFFF8C00);
      case 3:
        return AppColors.error500;
      default:
        return AppTheme.textHint(context);
    }
  }

  Color _severityBgColor(int severity) {
    switch (severity) {
      case 0:
        return AppColors.success500.withValues(alpha: 0.1);
      case 1:
        return AppColors.warning500.withValues(alpha: 0.1);
      case 2:
        return const Color(0xFFFF8C00).withValues(alpha: 0.1);
      case 3:
        return AppColors.error500.withValues(alpha: 0.1);
      default:
        return AppTheme.border(context);
    }
  }
}