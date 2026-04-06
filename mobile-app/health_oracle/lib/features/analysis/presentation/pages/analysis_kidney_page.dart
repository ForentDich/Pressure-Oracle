import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

enum _KidneyPredictionMode { latest, average }

class AnalysisKidneyPage extends StatefulWidget {
  const AnalysisKidneyPage({super.key});

  @override
  State<AnalysisKidneyPage> createState() => _AnalysisKidneyPageState();
}

class _AnalysisKidneyPageState extends State<AnalysisKidneyPage> {
  bool _loading = true;
  bool _hasKidneyDisease = false;
  double _confidence = 0.86;
  _KidneyPredictionMode _mode = _KidneyPredictionMode.average;

  @override
  void initState() {
    super.initState();
    _runKidneyAnalysis();
  }

  Future<void> _runKidneyAnalysis() async {
    setState(() => _loading = true);

    // TODO: Подключить реальную логику PredictionService.predictKidney,
    // когда будут доступны данные анкеты.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    
    // Имитация разных результатов для разных режимов
    _hasKidneyDisease = false;
    _confidence = _mode == _KidneyPredictionMode.average ? 0.86 : 0.79;

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final risk = _hasKidneyDisease ? _confidence : (1 - _confidence);
    final normal = 1 - risk;
    final statusColor = _hasKidneyDisease ? AppColors.error500 : AppColors.success500;
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
                            _hasKidneyDisease ? 'Есть признаки заболевания' : 'Заболевание не выявлено',
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
                      '${(_confidence * 100).toStringAsFixed(0)}%',
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
                    value: _confidence,
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
                  isActive: !_hasKidneyDisease,
                ),
                const SizedBox(height: 12),
                _buildProbabilityRow(
                  context,
                  label: 'Есть заболевание',
                  value: risk,
                  color: AppColors.error500,
                  isActive: _hasKidneyDisease,
                ),
              ],
            ),
          ),
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
