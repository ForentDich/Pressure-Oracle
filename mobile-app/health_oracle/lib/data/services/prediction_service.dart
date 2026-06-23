import 'random_forest_model.dart';
import 'health_categorizer.dart';
import 'entry_service.dart';
import 'profile_service.dart';
import '../models/health_entry.dart';
import 'hypertension_svc_model.dart';

/// Результат предсказания гипертонии (Модель 1).
class HypertensionResult {
  final int classIndex;          // 0-3
  final String label;            // "Норма", "Предгипертензия", …
  final List<double> probabilities;
  final String sbpCategory;
  final String dbpCategory;
  final String pulseCategory;
  final String bmiCategory;
  final double bmi;

  // DEBUG/trace inputs (optional)
  final double? inputSbp;
  final double? inputDbp;
  final double? inputPulse;
  final bool? inputIsLatest;
  final DateTime? inputPressureAt;
  final DateTime? inputPulseAt;

  // Флаг гипотензии
  final bool isHypotension;

  HypertensionResult({
    required this.classIndex,
    required this.label,
    required this.probabilities,
    required this.sbpCategory,
    required this.dbpCategory,
    required this.pulseCategory,
    required this.bmiCategory,
    required this.bmi,
    this.inputSbp,
    this.inputDbp,
    this.inputPulse,
    this.inputIsLatest,
    this.inputPressureAt,
    this.inputPulseAt,
    this.isHypotension = false, // значение по умолчанию
  });

  /// Уровень серьёзности (0 = норма, 3 = тяжёлая).
  int get severity => classIndex;

  /// Максимальная вероятность (уверенность модели).
  double get confidence =>
      probabilities.isNotEmpty ? probabilities[classIndex] : 0;
}

/// Результат предсказания хрон. болезни почек (Модель 2).
class KidneyResult {
  final int classIndex;          // 0 = No, 1 = Yes
  final String label;
  final List<double> probabilities;

  KidneyResult({
    required this.classIndex,
    required this.label,
    required this.probabilities,
  });

  bool get isRisk => classIndex == 1;
  double get riskProbability =>
      probabilities.length > 1 ? probabilities[1] : 0;
}

/// Сервис предсказаний — загружает модели и делает вывод.
class PredictionService {
  static RandomForestModel? _kidneyModel;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    try {
      _kidneyModel = await RandomForestModel.load(
        'assets/models/kidney_model.json',
      );
      print('PredictionService: kidney model loaded '
          '(${_kidneyModel!.nFeatures} features)');
    } catch (e) {
      print('PredictionService: kidney model not loaded — $e');
    }

    _initialized = true;
  }

  static bool get isHypertensionModelReady => true;
  static bool get isKidneyModelReady => _kidneyModel != null;

  // ─── Модель 1: гипертония ───────────────────────────────────

  static ({double sbp, double dbp}) _extractPressurePair(HealthEntry e) {
    final a = e.value;
    final b = e.secondaryValue;
    final x = b ?? a;
    final sbp = a >= x ? a : x;
    final dbp = a >= x ? x : a;
    return (sbp: sbp, dbp: dbp);
  }

  static HealthEntry? _latestByCreatedAt(Iterable<HealthEntry> entries) {
    final list = entries.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.isEmpty ? null : list.first;
  }

  // ─── Вспомогательные методы для гипотензии ──────────────────

  static bool _isHypotension(double sbp, double dbp) {
    return sbp < 100 || dbp < 60;
  }

  static HypertensionResult _buildHypotensionResult({
    required double sbp,
    required double dbp,
    required double pulse,
    required double bmi,
    required bool isLatest,
  }) {
    return HypertensionResult(
      classIndex: 0,
      label: 'Гипотензия',
      probabilities: [1.0, 0.0, 0.0, 0.0],
      sbpCategory: HealthCategorizer.sbpLabels[HealthCategorizer.categorizeSBP(sbp)],
      dbpCategory: HealthCategorizer.dbpLabels[HealthCategorizer.categorizeDBP(dbp)],
      pulseCategory: HealthCategorizer.pulseLabels[HealthCategorizer.categorizePulse(pulse)],
      bmiCategory: HealthCategorizer.bmiLabels[HealthCategorizer.categorizeBMI(bmi)],
      bmi: bmi,
      inputSbp: sbp,
      inputDbp: dbp,
      inputPulse: pulse,
      inputIsLatest: isLatest,
      isHypotension: true,
    );
  }

  // ─── Основной метод прогноза гипертонии (с гипотензией) ──────

  static HypertensionResult? predictHypertension({bool isLatest = false}) {
    if (!isHypertensionModelReady) return null;

    final profile = ProfileService.getProfile();
    if (profile == null) return null;
    if (profile.height == null || profile.age == null) return null;

    final allPressure = EntryService.getByType(EntryType.pressure);
    final allPulse = EntryService.getByType(EntryType.pulse);

    HealthEntry? pressureSource;
    HealthEntry? pulseSource;

    if (isLatest) {
      pressureSource = _latestByCreatedAt(allPressure);
      pulseSource = _latestByCreatedAt(allPulse);
      if (pressureSource == null || pulseSource == null) return null;

      final pair = _extractPressurePair(pressureSource);
      final sbp = pair.sbp;
      final dbp = pair.dbp;
      final pulse = pulseSource.value;

      final allWeight = EntryService.getByType(EntryType.weight).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final weight = allWeight.isNotEmpty ? allWeight.first.value : 70.0;

      final height = profile.height!;
      final age = profile.age!;
      final sex = profile.sex ?? true;
      final bmi = HealthCategorizer.calculateBMI(height, weight);

      // Проверка на гипотензию
      if (_isHypotension(sbp, dbp)) {
        return _buildHypotensionResult(
          sbp: sbp,
          dbp: dbp,
          pulse: pulse,
          bmi: bmi,
          isLatest: true,
        );
      }

      final catSBP = HealthCategorizer.categorizeSBP(sbp);
      final catDBP = HealthCategorizer.categorizeDBP(dbp);
      final catPulse = HealthCategorizer.categorizePulse(pulse);
      final catBMI = HealthCategorizer.categorizeBMI(bmi);
      final sexEncoded = HealthCategorizer.encodeSex(sex);

      final features = [
        sexEncoded.toDouble(),
        age.toDouble(),
        sbp,
        dbp,
        pulse,
        bmi,
      ];

      final classIdx = HypertensionSvcModel.predict(features);
      final probs = HypertensionSvcModel.predictProbabilities(features);

      return HypertensionResult(
        classIndex: classIdx,
        label: HealthCategorizer.hypertensionLabels[classIdx],
        probabilities: probs,
        sbpCategory: HealthCategorizer.sbpLabels[catSBP],
        dbpCategory: HealthCategorizer.dbpLabels[catDBP],
        pulseCategory: HealthCategorizer.pulseLabels[catPulse],
        bmiCategory: HealthCategorizer.bmiLabels[catBMI],
        bmi: bmi,
        inputSbp: sbp,
        inputDbp: dbp,
        inputPulse: pulse,
        inputIsLatest: true,
        inputPressureAt: pressureSource.createdAt,
        inputPulseAt: pulseSource.createdAt,
        isHypotension: false,
      );
    }

    // average (last 7 days, fallback to latest if empty)
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final pressureWeek = allPressure.where((e) => e.createdAt.isAfter(weekAgo)).toList();
    final pulseWeek = allPulse.where((e) => e.createdAt.isAfter(weekAgo)).toList();

    final pressureList = pressureWeek.isNotEmpty ? pressureWeek : allPressure.toList();
    final pulseList = pulseWeek.isNotEmpty ? pulseWeek : allPulse.toList();

    if (pressureList.isEmpty || pulseList.isEmpty) return null;

    final pairs = pressureList.map(_extractPressurePair).toList();
    final sbp = pairs.map((p) => p.sbp).reduce((a, b) => a + b) / pairs.length;
    final dbp = pairs.map((p) => p.dbp).reduce((a, b) => a + b) / pairs.length;
    final pulse = pulseList.map((e) => e.value).reduce((a, b) => a + b) / pulseList.length;

    final allWeight = EntryService.getByType(EntryType.weight).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final weight = allWeight.isNotEmpty ? allWeight.first.value : 70.0;

    final height = profile.height!;
    final age = profile.age!;
    final sex = profile.sex ?? true;
    final bmi = HealthCategorizer.calculateBMI(height, weight);

    // Проверка на гипотензию
    if (_isHypotension(sbp, dbp)) {
      return _buildHypotensionResult(
        sbp: sbp,
        dbp: dbp,
        pulse: pulse,
        bmi: bmi,
        isLatest: false,
      );
    }

    final catSBP = HealthCategorizer.categorizeSBP(sbp);
    final catDBP = HealthCategorizer.categorizeDBP(dbp);
    final catPulse = HealthCategorizer.categorizePulse(pulse);
    final catBMI = HealthCategorizer.categorizeBMI(bmi);
    final sexEncoded = HealthCategorizer.encodeSex(sex);

    final features = [
      sexEncoded.toDouble(),
      age.toDouble(),
      sbp,
      dbp,
      pulse,
      bmi,
    ];

    final classIdx = HypertensionSvcModel.predict(features);
    final probs = HypertensionSvcModel.predictProbabilities(features);

    return HypertensionResult(
      classIndex: classIdx,
      label: HealthCategorizer.hypertensionLabels[classIdx],
      probabilities: probs,
      sbpCategory: HealthCategorizer.sbpLabels[catSBP],
      dbpCategory: HealthCategorizer.dbpLabels[catDBP],
      pulseCategory: HealthCategorizer.pulseLabels[catPulse],
      bmiCategory: HealthCategorizer.bmiLabels[catBMI],
      bmi: bmi,
      inputSbp: sbp,
      inputDbp: dbp,
      inputPulse: pulse,
      inputIsLatest: false,
      inputPressureAt: _latestByCreatedAt(pressureList)?.createdAt,
      inputPulseAt: _latestByCreatedAt(pulseList)?.createdAt,
      isHypotension: false,
    );
  }

  /// Предсказание гипертонии из ручных значений (с гипотензией).
  static HypertensionResult? predictHypertensionManual({
    required double systolic,
    required double diastolic,
    required double pulse,
    required double heightCm,
    required double weightKg,
    required int age,
    required bool isMale,
  }) {
    if (!isHypertensionModelReady) return null;

    final bmi = HealthCategorizer.calculateBMI(heightCm, weightKg);

    if (_isHypotension(systolic, diastolic)) {
      return _buildHypotensionResult(
        sbp: systolic,
        dbp: diastolic,
        pulse: pulse,
        bmi: bmi,
        isLatest: false,
      );
    }

    final features = [
      HealthCategorizer.encodeSex(isMale).toDouble(),
      age.toDouble(),
      systolic,
      diastolic,
      pulse,
      bmi,
    ];

    final classIdx = HypertensionSvcModel.predict(features);
    final probs = HypertensionSvcModel.predictProbabilities(features);

    return HypertensionResult(
      classIndex: classIdx,
      label: HealthCategorizer.hypertensionLabels[classIdx],
      probabilities: probs,
      sbpCategory: HealthCategorizer.sbpLabels[
          HealthCategorizer.categorizeSBP(systolic)],
      dbpCategory: HealthCategorizer.dbpLabels[
          HealthCategorizer.categorizeDBP(diastolic)],
      pulseCategory: HealthCategorizer.pulseLabels[
          HealthCategorizer.categorizePulse(pulse)],
      bmiCategory: HealthCategorizer.bmiLabels[
          HealthCategorizer.categorizeBMI(bmi)],
      bmi: bmi,
      isHypotension: false,
    );
  }

  // ─── Модель 2: хрон. болезни почек ──────────────────────────

  static KidneyResult? predictKidney({
    required int bpAbnormality,
    required double hemoglobin,
    required double geneticCoef,
    required double age,
    required double bmi,
    required int sex,
    required int smoking,
    required double physicalActivity,
    required double saltIntake,
    required double alcoholPerDay,
    required int stressLevel,
  }) {
    if (_kidneyModel == null) return null;

    final features = HealthCategorizer.buildKidneyFeatures(
      bpAbnormality: bpAbnormality,
      hemoglobin: hemoglobin,
      geneticCoef: geneticCoef,
      age: age,
      bmi: bmi,
      sex: sex,
      smoking: smoking,
      physicalActivity: physicalActivity,
      saltIntake: saltIntake,
      alcoholPerDay: alcoholPerDay,
      stressLevel: stressLevel,
    );

    final classIdx = _kidneyModel!.predict(features);
    final probs = _kidneyModel!.predictProbabilities(features);

    return KidneyResult(
      classIndex: classIdx,
      label: classIdx == 1 ? 'Повышенный риск' : 'Низкий риск',
      probabilities: probs,
    );
  }
}