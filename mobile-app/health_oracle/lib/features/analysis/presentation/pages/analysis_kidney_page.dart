import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';

enum _KidneyPredictionMode { latest, average }

class AnalysisKidneyPage extends StatefulWidget {
  const AnalysisKidneyPage({super.key});

  @override
  State<AnalysisKidneyPage> createState() => _AnalysisKidneyPageState();
}

class _AnalysisKidneyPageState extends State<AnalysisKidneyPage> {
  bool _loading = true;
  KidneyResult? _kidneyResult;
  bool _usesEstimatedInputs = false;
  _KidneyPredictionMode _mode = _KidneyPredictionMode.average;

  @override
  void initState() {
    super.initState();
    _runKidneyAnalysis();
  }

  Future<void> _runKidneyAnalysis() async {
    setState(() => _loading = true);

    if (!PredictionService.isKidneyModelReady) {
      if (mounted) {
        setState(() {
          _kidneyResult = null;
          _loading = false;
        });
      }
      return;
    }

    final inputs = _buildKidneyInputs();
    final result = PredictionService.predictKidney(
      bpAbnormality: inputs.bpAbnormality,
      hemoglobin: inputs.hemoglobin,
      geneticCoef: inputs.geneticCoef,
      age: inputs.age,
      bmi: inputs.bmi,
      sex: inputs.sex,
      smoking: inputs.smoking,
      physicalActivity: inputs.physicalActivity,
      saltIntake: inputs.saltIntake,
      alcoholPerDay: inputs.alcoholPerDay,
      stressLevel: inputs.stressLevel,
    );

    if (mounted) {
      setState(() {
        _kidneyResult = result;
        _usesEstimatedInputs = inputs.usesEstimatedInputs;
        _loading = false;
      });
    }
  }

  ({
    int bpAbnormality,
    double hemoglobin,
    double geneticCoef,
    double age,
    double bmi,
    int sex,
    int smoking,
    double physicalActivity,
    double saltIntake,
    double alcoholPerDay,
    int stressLevel,
    bool usesEstimatedInputs,
  }) _buildKidneyInputs() {
    const defaults = (
      hemoglobin: 11.3,
      geneticCoef: 0.5,
      age: 47.0,
      bmi: 30.0,
      sex: 0,
      smoking: 1,
      physicalActivity: 25734.0,
      saltIntake: 25130.5,
      alcoholPerDay: 253.0,
      stressLevel: 2,
    );

    final profile = ProfileService.getProfile();
    var usesEstimated = true;

    var age = defaults.age;
    var sex = defaults.sex;

    if (profile != null) {
      if (profile.age != null) {
        age = profile.age!.toDouble();
      }
      if (profile.sex != null) {
        // Модель 2 обучалась с Sex: male=0, female=1
        sex = profile.sex! ? 0 : 1;
      }
    }

    final pressureEntries = EntryService.getByType(EntryType.pressure);
    final weightEntries = EntryService.getByType(EntryType.weight);

    final pressurePair = _selectPressurePair(pressureEntries);
    final pressureAvailable = pressurePair != null;

    var bpAbnormality = 0;
    if (pressurePair != null) {
      bpAbnormality =
          (pressurePair.sbp >= 140 || pressurePair.dbp >= 90) ? 1 : 0;
    }

    var bmi = defaults.bmi;
    final weight = _selectWeight(weightEntries);
    if (profile?.height != null && weight != null) {
      bmi = HealthCategorizer.calculateBMI(profile!.height!, weight);
    }

    if (pressureAvailable || (profile?.height != null && weight != null)) {
      usesEstimated = true;
    }

    return (
      bpAbnormality: bpAbnormality,
      hemoglobin: defaults.hemoglobin,
      geneticCoef: defaults.geneticCoef,
      age: age,
      bmi: bmi,
      sex: sex,
      smoking: defaults.smoking,
      physicalActivity: defaults.physicalActivity,
      saltIntake: defaults.saltIntake,
      alcoholPerDay: defaults.alcoholPerDay,
      stressLevel: defaults.stressLevel,
      usesEstimatedInputs: usesEstimated,
    );
  }

  ({double sbp, double dbp})? _selectPressurePair(
      Iterable<HealthEntry> entries) {
    final list = entries.toList();
    if (list.isEmpty) return null;

    if (_mode == _KidneyPredictionMode.latest) {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return _extractPressurePair(list.first);
    }

    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final week = list.where((e) => e.createdAt.isAfter(weekAgo)).toList();
    final source = week.isNotEmpty ? week : list;
    final pairs = source.map(_extractPressurePair).toList();

    final sbp = pairs.map((p) => p.sbp).reduce((a, b) => a + b) / pairs.length;
    final dbp = pairs.map((p) => p.dbp).reduce((a, b) => a + b) / pairs.length;
    return (sbp: sbp, dbp: dbp);
  }

  double? _selectWeight(Iterable<HealthEntry> entries) {
    final list = entries.toList();
    if (list.isEmpty) return null;

    if (_mode == _KidneyPredictionMode.latest) {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list.first.value;
    }

    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final week = list.where((e) => e.createdAt.isAfter(weekAgo)).toList();
    final source = week.isNotEmpty ? week : list;
    return source.map((e) => e.value).reduce((a, b) => a + b) / source.length;
  }

  ({double sbp, double dbp}) _extractPressurePair(HealthEntry entry) {
    final primary = entry.value;
    final secondary = entry.secondaryValue ?? primary;
    final sbp = primary >= secondary ? primary : secondary;
    final dbp = primary >= secondary ? secondary : primary;
    return (sbp: sbp, dbp: dbp);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!PredictionService.isKidneyModelReady) {
      return _buildNoModel(context);
    }

    if (_kidneyResult == null) {
      return _buildNoData(context);
    }

    final risk = _kidneyResult!.riskProbability.clamp(0.0, 1.0);
    final normal = (1.0 - risk).clamp(0.0, 1.0);
    // UI status is derived from probability, so label and bars stay consistent.
    final hasKidneyDisease = risk >= 0.5;
    final confidence = hasKidneyDisease ? risk : normal;

    final statusColor = hasKidneyDisease ? AppColors.error500 : AppColors.success500;
    final statusBg = statusColor.withValues(alpha: 0.1);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModeSwitcher(context),
          const SizedBox(height: 8),
          Text(
            _mode == _KidneyPredictionMode.average
                ? 'Прогноз: среднее значение'
                : 'Прогноз: последний показатель',
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textHint(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDecoration(
              context,
              radius: 20,
              blurRadius: 16,
              shadowOffset: const Offset(0, 4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.health_and_safety_rounded, color: statusColor, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Анализ почек',
                            style: TextStyles.bodyMedium.copyWith(
                              color: AppTheme.textHint(context),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasKidneyDisease
                                ? 'Есть признаки заболевания'
                                : 'Заболевание не выявлено',
                            style: TextStyles.headlineLarge.copyWith(
                              fontSize: 20,
                              color: statusColor,
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
                      'Уверенность модели',
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textSecondary(context),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${(confidence * 100).toStringAsFixed(0)}%',
                      style: TextStyles.bodyMedium.copyWith(
                        color: statusColor,
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
                    value: confidence,
                    minHeight: 8,
                    backgroundColor: AppTheme.border(context),
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.cardDecoration(
              context,
              radius: 20,
              blurRadius: 16,
              shadowOffset: const Offset(0, 4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Вероятности',
                  style: TextStyles.headlineLarge.copyWith(
                    fontSize: 16,
                    color: AppTheme.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 16),
                _buildProbabilityRow(
                  context,
                  label: 'Нет заболевания',
                  value: normal,
                  color: AppColors.success500,
                  isActive: !hasKidneyDisease,
                ),
                const SizedBox(height: 12),
                _buildProbabilityRow(
                  context,
                  label: 'Есть заболевание',
                  value: risk,
                  color: AppColors.error500,
                  isActive: hasKidneyDisease,
                ),
              ],
            ),
          ),
        ],
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
                onPressed: _runKidneyAnalysis,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Обновить анализ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.actionPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
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
            selected: _mode == _KidneyPredictionMode.latest,
            onTap: () {
              if (_mode == _KidneyPredictionMode.latest) return;
              setState(() => _mode = _KidneyPredictionMode.latest);
              _runKidneyAnalysis();
            },
          ),
          _buildModeTab(
            context,
            label: 'Среднее',
            icon: Icons.timeline_rounded,
            selected: _mode == _KidneyPredictionMode.average,
            onTap: () {
              if (_mode == _KidneyPredictionMode.average) return;
              setState(() => _mode = _KidneyPredictionMode.average);
              _runKidneyAnalysis();
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

  Widget _buildProbabilityRow(
    BuildContext context, {
    required String label,
    required double value,
    required Color color,
    required bool isActive,
  }) {
    return Column(
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
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                Text(
                  label,
                  style: TextStyles.bodyMedium.copyWith(
                    color: isActive ? AppTheme.textPrimary(context) : AppTheme.textSecondary(context),
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              '${(value * 100).toStringAsFixed(1)}%',
              style: TextStyles.bodyMedium.copyWith(
                color: color,
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
            value: value,
            minHeight: 6,
            backgroundColor: AppTheme.border(context),
            color: color,
          ),
        ),
      ],
    );
  }
}
