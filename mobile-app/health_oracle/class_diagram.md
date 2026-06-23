# Health Oracle — Диаграмма классов (core)

```mermaid
---
config:
  class:
    hideEmptyMembersBox: false
  layout: elk
  look: classic
  theme: redux
---
classDiagram
direction TB

    %% ======================== МОДЕЛИ ДАННЫХ ========================

    class UserProfile {
        +String firstName
        +DateTime? birthDate
        +double? height
        +bool? sex
        +int? get age
        +UserProfile copyWith(...)
    }

    class EntryType {
        <<enumeration>>
        pressure
        pulse
        weight
        sugar
    }

    class HealthEntry {
        +String id
        +EntryType type
        +DateTime createdAt
        +double value
        +double? secondaryValue
        +String? note
        +String get displayValue
        +String unit(BuildContext)
        +String typeName(BuildContext)
    }

    class RepeatType {
        <<enumeration>>
        daily
        weekly
        monthly
        weekdays
    }

    class ReminderCategory {
        <<enumeration>>
        pressure
        pulse
        weight
        sugar
        other
    }

    class Reminder {
        +String id
        +String title
        +String? description
        +int hour
        +int minute
        +RepeatType repeatType
        +ReminderCategory category
        +bool isActive
        +DateTime createdAt
        +String get timeString
    }

    class AppThemeMode {
        <<enumeration>>
        light
        dark
        system
    }

    %% ======================== СЕРВИСЫ ========================

    class ProfileService {
        +static Future~void~ init()
        +static UserProfile? getProfile()
        +static Future~void~ saveProfile(UserProfile)
        +static bool hasProfile()
        +static Future~void~ deleteProfile()
        +static Stream~BoxEvent~? watchProfile()
    }

    class EntryService {
        +static Future~void~ init()
        +static List~HealthEntry~ getAll()
        +static List~HealthEntry~ getByType(EntryType)
        +static HealthEntry? getLastByType(EntryType)
        +static List~HealthEntry~ getByDateRange(DateTime, DateTime)
        +static List~HealthEntry~ getByTypeAndDateRange(EntryType, DateTime, DateTime)
        +static Future~HealthEntry~ add(...)
        +static Future~void~ update(HealthEntry)
        +static Future~void~ delete(String)
        +static Future~void~ deleteAll()
        +static int get count
        +static Stream~BoxEvent~? watch()
    }

    class ReminderService {
        +static Future~void~ init()
        +static Future~Reminder~ add(...)
        +static Future~void~ update(Reminder)
        +static Future~void~ delete(String)
        +static Future~void~ toggleActive(String)
        +static List~Reminder~ getAll()
        +static List~Reminder~ getActive()
        +static List~Reminder~ getInactive()
        +static Reminder? getById(String)
        +static int get activeCount
        +static int get totalCount
    }

    class NotificationService {
        +static Future~void~ init()
        +static Future~bool~ requestPermissions()
        +static Future~bool~ hasPermissions()
        +static Future~void~ scheduleReminder(Reminder)
        +static Future~void~ cancelReminder(Reminder)
        +static Future~void~ cancelAll()
        +static Future~void~ rescheduleAllReminders(List~Reminder~)
    }

    class ThemeService {
        +static ThemeService get instance
        +static Future~void~ init()
        +AppThemeMode get mode
        +Future~void~ setMode(AppThemeMode)
        +ThemeMode get themeMode
        +String label(AppThemeMode)
    }

    class HealthCategorizer {
        +static int categorizeSBP(double)$
        +static int categorizeDBP(double)$
        +static int categorizePulse(double)$
        +static int categorizeBMI(double)$
        +static double calculateBMI(double, double)$
        +static int encodeSex(bool)$
        +static List~double~ buildKidneyFeatures(...)$
        +static const List~String~ sbpLabels
        +static const List~String~ dbpLabels
        +static const List~String~ pulseLabels
        +static const List~String~ bmiLabels
        +static const List~String~ hypertensionLabels
    }

    class RandomForestModel {
        +String id
        +int nClasses
        +int nFeatures
        +List~String~ featureNames
        +List~String~ classNames
        +static Future~RandomForestModel~ load(String)$
        +int predict(List~double~)
        +List~double~ predictProbabilities(List~double~)
    }

    class HypertensionSvcModel {
        +static int predict(List~double~)$
        +static List~double~ predictProbabilities(List~double~)$
    }

    class HypertensionResult {
        +int classIndex
        +String label
        +List~double~ probabilities
        +String sbpCategory
        +String dbpCategory
        +String pulseCategory
        +String bmiCategory
        +double bmi
        +int get severity
        +double get confidence
    }

    class KidneyResult {
        +int classIndex
        +String label
        +List~double~ probabilities
        +bool get isRisk
        +double get riskProbability
    }

    class PredictionService {
        +static Future~void~ init()$
        +static bool isHypertensionModelReady$
        +static bool isKidneyModelReady$
        +static HypertensionResult? predictHypertension([bool isLatest])$
        +static HypertensionResult? predictHypertensionManual(...)$
        +static KidneyResult? predictKidney(...)$
    }

    %% ======================== CORE ========================

    class AppColors {
        +static const Color background$
        +static const Color surface$
        +static const Color primary$
        +static const Gradient pressureGradient$
        +static const Gradient pulseGradient$
        +static const Gradient weightGradient$
        +static const Gradient sugarGradient$
        +static const Gradient purpleGradient$
        +static const Gradient greenGradient$
    }

    class AppTheme {
        +static ThemeData get light$
        +static ThemeData get dark$
        +static Color background(BuildContext)$
        +static Color surface(BuildContext)$
        +static Color surfaceVariant(BuildContext)$
        +static Color textPrimary(BuildContext)$
        +static Color textSecondary(BuildContext)$
        +static Color textHint(BuildContext)$
        +static BoxDecoration cardDecoration(BuildContext)$
        +static BoxDecoration nestedCardDecoration(BuildContext)$
    }

    class TextStyles {
        +static const TextStyle headlineLarge$
        +static const TextStyle titleMedium$
        +static const TextStyle bodyMedium$
        +static const TextStyle labelSmall$
        +static const TextStyle labelXSmall$
    }

    class ModalHelper {
        +static Future~Map~? showBottomEntryMenu(BuildContext)$
    }

    class Strings {
        +static const String cancel$
        +static const String save$
        +static const String home$
        +static const String history$
        +static const String schedule$
        +static const String profile$
        +... (статические константы)
    }

    %% ======================== CORE WIDGETS ========================

    class HealthCard {
        +String title
        +String value
        +String unit
        +String lastUpdate
        +Gradient gradient
        +Widget icon
        +VoidCallback? onTap
        +Widget build(BuildContext)
    }

    class BottomEntryMenu {
        +void Function(Map)? onSave
        +VoidCallback? onCancel
        +ValueNotifier~Set~String~~? selectedNotifier
        +State createState()
    }

    class BottomEntryCategoryTile {
        +String title
        +bool selected
        +Gradient? gradient
        +VoidCallback? onTap
        +Widget build(BuildContext)
    }

    class BottomEntryCategoryContainer {
        +Set~String~ selectedCategories
        +Map~String, Map~String, TextEditingController~~ controllers
        +Widget build(BuildContext)
    }

    class BottomEntryInputField {
        +String label
        +String? unit
        +TextEditingController controller
        +String? hintText
        +bool isRequired
        +Widget build(BuildContext)
    }

    class BottomEntryActions {
        +VoidCallback? onCancel
        +VoidCallback? onSave
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — HOME ========================

    class HomePage {
        +Widget build(BuildContext)
    }

    class MetricsPanel {
        +double top
        +State createState()
    }

    class MetricsGrid {
        +State createState()
        +void refresh()
    }

    %% ======================== FEATURES — METRICS ========================

    class MetricInterface {
        <<interface>>
        +String get title
        +String get description
        +String get unit
        +Gradient get gradient
        +IconData get icon
        +EntryType get entryType
        +String formatValue(HealthEntry)
        +String formatValueShort(HealthEntry)
    }

    class MetricType {
        <<enumeration>>
        pressure
        sugar
        weight
        pulse
    }

    class MetricFactory {
        +static MetricInterface create(MetricType)$
        +static List~MetricType~ get allTypes$
    }

    class PressureMetric {
        +String get title
        +String get description
        +String get unit
        +Gradient get gradient
        +IconData get icon
        +EntryType get entryType
        +String formatValue(HealthEntry)
        +String formatValueShort(HealthEntry)
    }

    class PulseMetric {
        +String get title
        +String get description
        +String get unit
        +Gradient get gradient
        +IconData get icon
        +EntryType get entryType
        +String formatValue(HealthEntry)
        +String formatValueShort(HealthEntry)
    }

    class SugarMetric {
        +String get title
        +String get description
        +String get unit
        +Gradient get gradient
        +IconData get icon
        +EntryType get entryType
        +String formatValue(HealthEntry)
        +String formatValueShort(HealthEntry)
    }

    class WeightMetric {
        +String get title
        +String get description
        +String get unit
        +Gradient get gradient
        +IconData get icon
        +EntryType get entryType
        +String formatValue(HealthEntry)
        +String formatValueShort(HealthEntry)
    }

    class MetricsContainerPage {
        +MetricType initialTab
        +State createState()
    }

    class MetricTabContent {
        +MetricType metricType
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — HISTORY ========================

    class HistoryPage {
        +Widget build(BuildContext)
    }

    class HistoryListPanel {
        +State createState()
    }

    class HistoryCard {
        +HealthEntry entry
        +Widget build(BuildContext)
    }

    class HistoryFilters {
        +Set~EntryType~ selectedTypes
        +ValueNotifier~Set~EntryType~~ onChanged
        +Widget build(BuildContext)
    }

    class DateSelector {
        +DateTime selectedDate
        +ValueChanged~DateTime~ onDateChanged
        +Widget build(BuildContext)
    }

    class HistoryHeader {
        +Widget build(BuildContext)
    }

    class ExportButton {
        +Widget build(BuildContext)
    }

    class ExportPage {
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — SCHEDULE ========================

    class SchedulePage {
        +State createState()
    }

    class ScheduleEditPage {
        +bool isNew
        +Reminder? reminder
        +State createState()
    }

    class ScheduleHeader {
        +VoidCallback onAddPressed
        +Widget build(BuildContext)
    }

    class ScheduleItem {
        +String title
        +String time
        +String repeat
        +String category
        +IconData icon
        +Gradient gradient
        +bool isActive
        +VoidCallback? onTap
        +ValueChanged~bool~? onToggle
        +Widget build(BuildContext)
    }

    class ScheduleSection {
        +String title
        +List~Widget~ children
        +Widget build(BuildContext)
    }

    class ScheduleStatCard {
        +String label
        +String value
        +IconData icon
        +Gradient gradient
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — PROFILE ========================

    class ProfilePage {
        +State createState()
    }

    class EditProfilePage {
        +Widget build(BuildContext)
    }

    class SettingsPage {
        +Widget build(BuildContext)
    }

    class ProfileHeader {
        +UserProfile profile
        +VoidCallback onEditComplete
        +Widget build(BuildContext)
    }

    class ProfileCard {
        +IconData icon
        +String title
        +List~ProfileItem~ items
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — ONBOARDING ========================

    class OnboardingPage {
        +State createState()
    }

    class NamePage {
        +TextEditingController controller
        +VoidCallback onChanged
        +Widget build(BuildContext)
    }

    class BirthDatePage {
        +DateTime? selectedDate
        +ValueChanged~DateTime~ onDateSelected
        +Widget build(BuildContext)
    }

    class SexPage {
        +bool? selectedSex
        +ValueChanged~bool~ onSexSelected
        +Widget build(BuildContext)
    }

    class HeightPage {
        +TextEditingController controller
        +VoidCallback onChanged
        +Widget build(BuildContext)
    }

    %% ======================== FEATURES — ANALYSIS ========================

    class AnalysisPage {
        +State createState()
    }

    class AnalysisPressurePage {
        +Widget build(BuildContext)
    }

    class AnalysisKidneyPage {
        +Widget build(BuildContext)
    }

    %% ======================== MAIN ========================

    class MyApp {
        +Widget build(BuildContext)
    }

    class MainNavigator {
        +static GlobalKey navigatorKey$
        +static void goToHistory()$
        +State createState()
    }

    %% ======================== СВЯЗИ ========================

    %% Main
    MyApp --> MainNavigator
    MyApp --> OnboardingPage : "если нет профиля"
    MyApp --> ThemeService : "слушает тему"
    MainNavigator --> HomePage
    MainNavigator --> HistoryPage
    MainNavigator --> SchedulePage
    MainNavigator --> ProfilePage

    %% Home
    HomePage --> MetricsPanel
    MetricsPanel --> MetricsGrid
    MetricsPanel --> ModalHelper : "открыть меню"
    MetricsPanel --> AnalysisPage : "навигация"
    MetricsGrid --> HealthCard
    MetricsGrid --> MetricsContainerPage : "навигация"
    MetricsGrid --> EntryService : "чтение данных"

    %% Metrics
    MetricInterface <|.. PressureMetric : implements
    MetricInterface <|.. PulseMetric : implements
    MetricInterface <|.. SugarMetric : implements
    MetricInterface <|.. WeightMetric : implements
    MetricFactory --> MetricInterface : creates
    MetricsContainerPage --> MetricFactory
    MetricsContainerPage --> MetricTabContent

    %% History
    HistoryPage --> HistoryListPanel
    HistoryPage --> ExportPage : "навигация"
    HistoryListPanel --> HistoryFilters
    HistoryListPanel --> DateSelector
    HistoryListPanel --> HistoryCard
    HistoryListPanel --> EntryService : "чтение данных"

    %% Schedule
    SchedulePage --> ReminderService : "чтение данных"
    SchedulePage --> NotificationService : "управление уведомлениями"
    SchedulePage --> ScheduleHeader
    SchedulePage --> ScheduleStatCard
    SchedulePage --> ScheduleSection
    SchedulePage --> ScheduleItem
    SchedulePage --> ScheduleEditPage : "навигация"

    %% Profile
    ProfilePage --> ProfileService : "чтение данных"
    ProfilePage --> ProfileHeader
    ProfilePage --> ProfileCard
    ProfilePage --> SettingsPage : "навигация"
    SettingsPage --> ThemeService : "смена темы"

    %% Onboarding
    OnboardingPage --> ProfileService : "сохранение профиля"
    OnboardingPage --> NamePage
    OnboardingPage --> BirthDatePage
    OnboardingPage --> SexPage
    OnboardingPage --> HeightPage

    %% Analysis
    AnalysisPage --> AnalysisPressurePage
    AnalysisPage --> AnalysisKidneyPage
    AnalysisPressurePage --> PredictionService : "предсказание"
    AnalysisKidneyPage --> PredictionService : "предсказание"

    %% Services → Models
    ProfileService --> UserProfile
    EntryService --> HealthEntry
    EntryService --> EntryType
    ReminderService --> Reminder
    ReminderService --> RepeatType
    ReminderService --> ReminderCategory
    NotificationService --> Reminder
    NotificationService --> ReminderCategory

    %% ML
    PredictionService --> HypertensionSvcModel : "модель гипертонии"
    PredictionService --> RandomForestModel : "модель почек"
    PredictionService --> HealthCategorizer : "категоризация"
    PredictionService --> EntryService : "данные"
    PredictionService --> ProfileService : "данные профиля"
    PredictionService --> HypertensionResult
    PredictionService --> KidneyResult

    %% Core Widgets
    ModalHelper --> BottomEntryMenu
    BottomEntryMenu --> BottomEntryCategoryTile
    BottomEntryMenu --> BottomEntryCategoryContainer
    BottomEntryMenu --> BottomEntryActions
    BottomEntryMenu --> EntryService : "сохранение"
    BottomEntryCategoryContainer --> BottomEntryInputField

    %% Theme
    ThemeService --> AppThemeMode
    AppTheme --> AppColors
    AppTheme --> TextStyles

    %% Sterotypes
    <<interface>> MetricInterface
    <<factory>> MetricFactory
    <<enumeration>> EntryType
    <<enumeration>> RepeatType
    <<enumeration>> ReminderCategory
    <<enumeration>> AppThemeMode
    <<enumeration>> MetricType
    <<service>> ProfileService
    <<service>> EntryService
    <<service>> ReminderService
    <<service>> NotificationService
    <<service>> ThemeService
    <<service>> PredictionService
```
