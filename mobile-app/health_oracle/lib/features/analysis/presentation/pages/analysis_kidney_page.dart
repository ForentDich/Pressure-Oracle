import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';

enum _KidneyPredictionMode { latest, average }

/// Модель для хранения пользовательских данных формы почек.
class _KidneyFormData {
  final double hemoglobin;
  final double geneticCoef;
  final int smoking;
  final double physicalActivity;
  final double saltIntake;
  final double alcoholPerDay;
  final int stressLevel;

  const _KidneyFormData({
    this.hemoglobin = 11.3,
    this.geneticCoef = 0.5,
    this.smoking = 1,
    this.physicalActivity = 25734.0,
    this.saltIntake = 25130.5,
    this.alcoholPerDay = 253.0,
    this.stressLevel = 2,
  });
}

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
  _KidneyFormData _formData = const _KidneyFormData();

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
  })
  _buildKidneyInputs() {
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
      bpAbnormality = (pressurePair.sbp >= 140 || pressurePair.dbp >= 90)
          ? 1
          : 0;
    }

    var bmi = defaults.bmi;
    final weight = _selectWeight(weightEntries);
    if (profile?.height != null && weight != null) {
      bmi = HealthCategorizer.calculateBMI(profile!.height!, weight);
    }

    if (pressureAvailable || (profile?.height != null && weight != null)) {
      usesEstimated = true;
    }

    // Используем данные из формы, если они были заполнены пользователем,
    // иначе — значения по умолчанию
    return (
      bpAbnormality: bpAbnormality,
      hemoglobin: _formData.hemoglobin,
      geneticCoef: _formData.geneticCoef,
      age: age,
      bmi: bmi,
      sex: sex,
      smoking: _formData.smoking,
      physicalActivity: _formData.physicalActivity,
      saltIntake: _formData.saltIntake,
      alcoholPerDay: _formData.alcoholPerDay,
      stressLevel: _formData.stressLevel,
      usesEstimatedInputs: usesEstimated,
    );
  }

  ({double sbp, double dbp})? _selectPressurePair(
    Iterable<HealthEntry> entries,
  ) {
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

  Future<void> _openForm() async {
    final result = await showModalBottomSheet<_KidneyFormData>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _KidneyFormSheet(initialData: _formData),
    );

    if (result != null && mounted) {
      setState(() {
        _formData = result;
      });
      _runKidneyAnalysis();
    }
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

    final statusColor = hasKidneyDisease
        ? AppColors.error500
        : AppColors.success500;
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
          // Кнопка "Заполнить форму"
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: OutlinedButton.icon(
                onPressed: _openForm,
                icon: const Icon(Icons.edit_note_rounded, size: 20),
                label: const Text(
                  'Заполнить форму',
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
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
                      child: Icon(
                        Icons.health_and_safety_rounded,
                        color: statusColor,
                        size: 24,
                      ),
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
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                Text(
                  label,
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

// ─── Bottom Sheet форма для ввода параметров ─────────────────────

class _KidneyFormSheet extends StatefulWidget {
  final _KidneyFormData initialData;

  const _KidneyFormSheet({required this.initialData});

  @override
  State<_KidneyFormSheet> createState() => _KidneyFormSheetState();
}

class _KidneyFormSheetState extends State<_KidneyFormSheet> {
  late TextEditingController _hemoglobinController;
  late TextEditingController _geneticCoefController;
  late TextEditingController _physicalActivityController;
  late TextEditingController _saltIntakeController;
  late TextEditingController _alcoholController;
  int _smoking = 1;
  int _stressLevel = 2;

  @override
  void initState() {
    super.initState();
    _hemoglobinController = TextEditingController(
      text: widget.initialData.hemoglobin.toString(),
    );
    _geneticCoefController = TextEditingController(
      text: widget.initialData.geneticCoef.toString(),
    );
    _physicalActivityController = TextEditingController(
      text: widget.initialData.physicalActivity.toString(),
    );
    _saltIntakeController = TextEditingController(
      text: widget.initialData.saltIntake.toString(),
    );
    _alcoholController = TextEditingController(
      text: widget.initialData.alcoholPerDay.toString(),
    );
    _smoking = widget.initialData.smoking;
    _stressLevel = widget.initialData.stressLevel;
  }

  @override
  void dispose() {
    _hemoglobinController.dispose();
    _geneticCoefController.dispose();
    _physicalActivityController.dispose();
    _saltIntakeController.dispose();
    _alcoholController.dispose();
    super.dispose();
  }

  void _save() {
    final data = _KidneyFormData(
      hemoglobin: double.tryParse(_hemoglobinController.text) ?? 11.3,
      geneticCoef: double.tryParse(_geneticCoefController.text) ?? 0.5,
      smoking: _smoking,
      physicalActivity:
          double.tryParse(_physicalActivityController.text) ?? 25734.0,
      saltIntake: double.tryParse(_saltIntakeController.text) ?? 25130.5,
      alcoholPerDay: double.tryParse(_alcoholController.text) ?? 253.0,
      stressLevel: _stressLevel,
    );
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: AppTheme.surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.divider(context),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Параметры анализа почек',
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Заполните данные для более точного прогноза',
                style: TextStyles.bodyMedium.copyWith(
                  color: AppTheme.textHint(context),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // Гемоглобин
              _buildField(
                label: 'Уровень гемоглобина',
                hint: '11.3',
                unit: 'г/дл',
                controller: _hemoglobinController,
              ),
              const SizedBox(height: 16),

              // Генетический коэффициент
              _buildField(
                label: 'Генетический коэффициент',
                hint: '0.5',
                unit: '',
                controller: _geneticCoefController,
              ),
              const SizedBox(height: 16),

              // Курение
              _buildSwitchRow(
                label: 'Курение',
                value: _smoking == 1,
                onChanged: (v) => setState(() => _smoking = v ? 1 : 0),
                subtitle: _smoking == 1 ? 'Курит' : 'Не курит',
              ),
              const SizedBox(height: 16),

              // Физ. активность
              _buildField(
                label: 'Физическая активность',
                hint: '25734',
                unit: 'шагов/день',
                controller: _physicalActivityController,
              ),
              const SizedBox(height: 16),

              // Потребление соли
              _buildField(
                label: 'Потребление соли в диете',
                hint: '25130.5',
                unit: 'мг/день',
                controller: _saltIntakeController,
              ),
              const SizedBox(height: 16),

              // Алкоголь
              _buildField(
                label: 'Потребление алкоголя в день',
                hint: '253.0',
                unit: 'мл/день',
                controller: _alcoholController,
              ),
              const SizedBox(height: 16),

              // Уровень стресса
              _buildStressSelector(),
              const SizedBox(height: 24),

              // Кнопки
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textSecondary(context),
                        side: BorderSide(color: AppTheme.border(context)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Отмена'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF8E2DE2,
                            ).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Применить',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required String unit,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            color: AppTheme.textSecondary(context),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppTheme.surfaceVariant(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border(context)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    color: AppTheme.textPrimary(context),
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textHint(context),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              if (unit.isNotEmpty) ...[
                Container(
                  width: 1,
                  height: 20,
                  color: AppTheme.divider(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    unit,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textHint(context),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textSecondary(context),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textPrimary(context),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildStressSelector() {
    const levels = ['Низкий', 'Средний', 'Высокий'];
    final colors = [
      AppColors.success500,
      AppColors.warning500,
      AppColors.error500,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Уровень стресса',
          style: TextStyles.bodyMedium.copyWith(
            color: AppTheme.textSecondary(context),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(3, (index) {
            final isSelected = _stressLevel == index;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                child: GestureDetector(
                  onTap: () => setState(() => _stressLevel = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colors[index].withValues(alpha: 0.1)
                          : AppTheme.surfaceVariant(context),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? colors[index]
                            : AppTheme.border(context),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          index == 0
                              ? Icons.sentiment_very_satisfied
                              : index == 1
                              ? Icons.sentiment_neutral
                              : Icons.sentiment_very_dissatisfied,
                          size: 24,
                          color: isSelected
                              ? colors[index]
                              : AppTheme.textHint(context),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          levels[index],
                          style: TextStyles.labelSmall.copyWith(
                            fontSize: 13,
                            color: isSelected
                                ? colors[index]
                                : AppTheme.textSecondary(context),
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
