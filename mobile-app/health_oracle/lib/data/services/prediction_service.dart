import 'random_forest_model.dart';
import 'health_categorizer.dart';
import 'entry_service.dart';
import 'profile_service.dart';
import '../models/health_entry.dart';

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
  static RandomForestModel? _hypertensionModel;
  static RandomForestModel? _kidneyModel;
  static bool _initialized = false;

  /// Инициализация: загружает JSON-модели из assets.
  static Future<void> init() async {
    if (_initialized) return;
    try {
      _hypertensionModel = await RandomForestModel.load(
        'assets/models/hypertension_model.json',
      );
      print('PredictionService: hypertension model loaded '
          '(${_hypertensionModel!.nFeatures} features, '
          '${_hypertensionModel!.classNames.length} classes)');
    } catch (e) {
      print('PredictionService: hypertension model not loaded — $e');
    }

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

  static bool get isHypertensionModelReady => _hypertensionModel != null;
  static bool get isKidneyModelReady => _kidneyModel != null;

  // ─── Модель 1: гипертония ───────────────────────────────────

  /// Предсказание гипертонии.
  /// Если [isLatest] = true, использует самую свежую запись.
  /// Иначе — средние значения за последние 7 дней.
  /// Возвращает null если недостаточно данных.
  static ({double sbp, double dbp}) _extractPressurePair(HealthEntry e) {
    final a = e.value;
    final b = e.secondaryValue;

    // если второе значение отсутствует — используем одно значение для обоих,
    // чтобы НЕ подставлять "80" и не ломать прогноз.
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

  static HypertensionResult? predictHypertension({bool isLatest = false}) {
    if (_hypertensionModel == null) return null;

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

      final catSBP = HealthCategorizer.categorizeSBP(sbp);
      final catDBP = HealthCategorizer.categorizeDBP(dbp);
      final catPulse = HealthCategorizer.categorizePulse(pulse);
      final catBMI = HealthCategorizer.categorizeBMI(bmi);
      final sexEncoded = HealthCategorizer.encodeSex(sex);

      final features = [
        sexEncoded.toDouble(),
        catSBP.toDouble(),
        catDBP.toDouble(),
        catBMI.toDouble(),
        catPulse.toDouble(),
        age.toDouble(),
      ];

      final classIdx = _hypertensionModel!.predict(features);
      final probs = _hypertensionModel!.predictProbabilities(features);

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

    final catSBP = HealthCategorizer.categorizeSBP(sbp);
    final catDBP = HealthCategorizer.categorizeDBP(dbp);
    final catPulse = HealthCategorizer.categorizePulse(pulse);
    final catBMI = HealthCategorizer.categorizeBMI(bmi);
    final sexEncoded = HealthCategorizer.encodeSex(sex);

    final features = [
      sexEncoded.toDouble(),
      catSBP.toDouble(),
      catDBP.toDouble(),
      catBMI.toDouble(),
      catPulse.toDouble(),
      age.toDouble(),
    ];

    final classIdx = _hypertensionModel!.predict(features);
    final probs = _hypertensionModel!.predictProbabilities(features);

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
    );
  }

  /// Предсказание гипертонии из ручных значений.
  static HypertensionResult? predictHypertensionManual({
    required double systolic,
    required double diastolic,
    required double pulse,
    required double heightCm,
    required double weightKg,
    required int age,
    required bool isMale,
  }) {
    if (_hypertensionModel == null) return null;

    final bmi = HealthCategorizer.calculateBMI(heightCm, weightKg);

    final features = [
      HealthCategorizer.encodeSex(isMale).toDouble(),
      HealthCategorizer.categorizeSBP(systolic).toDouble(),
      HealthCategorizer.categorizeDBP(diastolic).toDouble(),
      HealthCategorizer.categorizeBMI(bmi).toDouble(),
      HealthCategorizer.categorizePulse(pulse).toDouble(),
      age.toDouble(),
    ];

    final classIdx = _hypertensionModel!.predict(features);
    final probs = _hypertensionModel!.predictProbabilities(features);

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
    );
  }

  // ─── Модель 2: хрон. болезни почек ──────────────────────────

  /// Предсказание риска хрон. болезни почек из анкеты.
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
