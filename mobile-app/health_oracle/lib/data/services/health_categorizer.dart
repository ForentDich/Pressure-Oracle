/// Категоризация медицинских показателей —
/// точная реплика Python-функций из ноутбуков.
///
/// Категории кодируются целыми числами (LabelEncoder, алфавитный порядок).
class HealthCategorizer {
  // ─── Модель 1: категории давления, пульса, BMI ──────────────

  /// Систолическое АД → категория (int).
  ///
  /// Категории (алфавитный порядок LabelEncoder):
  ///  0 = Высокое нормальное Systolic    (130-139)
  ///  1 = Гипертония ср. тяж. Systolic   (160-179)
  ///  2 = Нормальное Systolic            (120-129)
  ///  3 = Оптимальное Systolic           (100-119)
  ///  4 = Пониженное Systolic            (<100)
  ///  5 = Тяжёлая гипертония Systolic    (>=180)
  ///  6 = Умеренная гипертония Systolic  (140-159)
  static int categorizeSBP(double sbp) {
    if (sbp < 100) return 4; // Пониженное
    if (sbp <= 119) return 3; // Оптимальное
    if (sbp <= 129) return 2; // Нормальное
    if (sbp <= 139) return 0; // Высокое нормальное
    if (sbp <= 159) return 6; // Умеренная гипертония
    if (sbp <= 179) return 1; // Гипертония ср. тяж.
    return 5; // Тяжёлая гипертония
  }

  /// Диастолическое АД → категория (int).
  ///
  /// Python LabelEncoder (из твоего вывода):
  ///  ['Высокое нормальное', 'Гипертония ср. тяж.', 'Нормальное', 'Оптимальное', 'Пониженное', 'Умеренная гипертония']
  ///   -> [0,                   1,                  2,           3,            4,           5]
  ///
  /// ВАЖНО: тут 6 классов (без отдельной категории ">=110").
  static int categorizeDBP(double dbp) {
    if (dbp < 60) return 4; // Пониженное
    if (dbp <= 79) return 3; // Оптимальное
    if (dbp <= 84) return 2; // Нормальное
    if (dbp <= 89) return 0; // Высокое нормальное
    if (dbp <= 99) return 5; // Умеренная гипертония
    return 1; // Гипертония ср. тяж. (>=100)
  }

  /// Пульс → категория (int).
  ///
  ///  0 = Высокий пульс      (>70)
  ///  1 = Нормальный пульс   (60-70)
  ///  2 = Пониженный пульс   (<60)
  static int categorizePulse(double pulse) {
    if (pulse < 60) return 2; // Пониженный
    if (pulse <= 70) return 1; // Нормальный
    return 0; // Высокий
  }

  /// BMI → категория (int) — медицинская.
  ///
  /// Python LabelEncoder (из твоего вывода):
  ///  ['Высокий', 'Низкий', 'Обычный', 'Очень высокий', 'Очень низкий', 'Повышенный']
  ///   -> [0,       1,       2,         3,              4,            5]
  ///
  /// ВАЖНО: тут 6 классов (без отдельной категории ">40").
  static int categorizeBMI(double bmi) {
    if (bmi < 16) return 4; // Очень низкий
    if (bmi < 18.5) return 1; // Низкий
    if (bmi < 25) return 2; // Обычный
    if (bmi < 30) return 5; // Повышенный
    if (bmi < 35) return 0; // Высокий
    return 3; // Очень высокий (>=35, включая >40)
  }

  /// Рассчитывает BMI из роста (см) и веса (кг).
  static double calculateBMI(double heightCm, double weightKg) {
    final heightM = heightCm / 100.0;
    return weightKg / (heightM * heightM);
  }

  /// Пол: Python (в текущей модели): Male = 0, Female = 1
  static int encodeSex(bool isMale) => isMale ? 0 : 1;

  // ─── Модель 2: feature engineering ──────────────────────────

  /// Строит вектор 11 признаков для модели 2 (kidney).
  ///
  /// Порядок признаков совпадает с pipeline (SimpleImputer + RF):
  ///  0: Blood_Pressure_Abnormality (0/1)
  ///  1: Level_of_Hemoglobin
  ///  2: Genetic_Pedigree_Coefficient
  ///  3: Age
  ///  4: BMI
  ///  5: Sex (0=M, 1=F)
  ///  6: Smoking (0/1)
  ///  7: Physical_activity
  ///  8: salt_content_in_the_diet
  ///  9: alcohol_consumption_per_day
  /// 10: Level_of_Stress (0,1,2)
  ///
  /// Imputer добавит 2 indicator-признака (индексы 2 и 9) автоматически.
  static List<double> buildKidneyFeatures({
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
    return [
      bpAbnormality.toDouble(),
      hemoglobin,
      geneticCoef,
      age,
      bmi,
      sex.toDouble(),
      smoking.toDouble(),
      physicalActivity,
      saltIntake,
      alcoholPerDay,
      stressLevel.toDouble(),
    ];
  }

  // ─── Человекочитаемые названия ──────────────────────────────

  static const List<String> sbpLabels = [
    'Высокое нормальное', // 0
    'Гипертония ср. тяж.', // 1
    'Нормальное', // 2
    'Оптимальное', // 3
    'Пониженное', // 4
    'Тяжёлая гипертония', // 5
    'Умеренная гипертония', // 6
  ];

  static const List<String> dbpLabels = [
    'Высокое нормальное', // 0
    'Гипертония ср. тяж.', // 1
    'Нормальное', // 2
    'Оптимальное', // 3
    'Пониженное', // 4
    'Умеренная гипертония', // 5
  ];

  static const List<String> pulseLabels = [
    'Высокий', // 0
    'Нормальный', // 1
    'Пониженный', // 2
  ];

  static const List<String> bmiLabels = [
    'Высокий', // 0
    'Низкий', // 1
    'Обычный', // 2
    'Очень высокий', // 3
    'Очень низкий', // 4
    'Повышенный', // 5
  ];

  static const List<String> hypertensionLabels = [
    'Норма', // 0
    'Предгипертензия', // 1
    'Гипертония 1 ст.', // 2
    'Гипертония 2 ст.', // 3
  ];
}
