Project Path: health_oracle

Source Tree:

```txt
health_oracle
└── lib
    ├── core
    │   ├── helpers
    │   │   └── modal_helper.dart
    │   ├── i18n
    │   │   ├── l10n_extension.dart
    │   │   └── strings.dart
    │   ├── theme
    │   │   ├── app_theme.dart
    │   │   ├── colors.dart
    │   │   └── text_styles.dart
    │   └── widgets
    │       ├── bottom_entry_actions.dart
    │       ├── bottom_entry_category_container.dart
    │       ├── bottom_entry_category_tile.dart
    │       ├── bottom_entry_input_field.dart
    │       ├── bottom_entry_menu.dart
    │       └── health_card.dart
    ├── data
    │   ├── data.dart
    │   ├── models
    │   │   ├── health_entry.dart
    │   │   ├── health_entry.g.dart
    │   │   ├── reminder.dart
    │   │   ├── reminder.g.dart
    │   │   ├── user_profile.dart
    │   │   └── user_profile.g.dart
    │   └── services
    │       ├── entry_service.dart
    │       ├── health_categorizer.dart
    │       ├── hypertension_svc_model.dart
    │       ├── notification_service.dart
    │       ├── prediction_service.dart
    │       ├── profile_service.dart
    │       ├── random_forest_model.dart
    │       ├── reminder_service.dart
    │       └── theme_service.dart
    ├── features
    │   ├── analysis
    │   │   └── presentation
    │   │       └── pages
    │   │           ├── analysis_kidney_page.dart
    │   │           ├── analysis_page.dart
    │   │           └── analysis_pressure_page.dart
    │   ├── history
    │   │   └── presentation
    │   │       ├── pages
    │   │       │   ├── export_page.dart
    │   │       │   └── history_page.dart
    │   │       └── widgets
    │   │           ├── date_selector.dart
    │   │           ├── export_button.dart
    │   │           ├── export_section.dart
    │   │           ├── export_selector_row.dart
    │   │           ├── history_card.dart
    │   │           ├── history_filters.dart
    │   │           ├── history_header.dart
    │   │           ├── history_list_panel.dart
    │   │           └── widgets.dart
    │   ├── home
    │   │   └── presentation
    │   │       ├── pages
    │   │       │   └── home_page.dart
    │   │       └── widgets
    │   │           ├── add_entry_page.dart
    │   │           ├── add_record_button.dart
    │   │           ├── background_gradient.dart
    │   │           ├── header_content.dart
    │   │           ├── metrics_grid.dart
    │   │           └── metrics_panel.dart
    │   ├── metrics
    │   │   ├── domain
    │   │   │   ├── metric_factory.dart
    │   │   │   ├── metric_interface.dart
    │   │   │   └── metrics
    │   │   │       ├── pressure_metric.dart
    │   │   │       ├── pulse_metric.dart
    │   │   │       ├── sugar_metric.dart
    │   │   │       └── weight_metric.dart
    │   │   └── presentation
    │   │       ├── pages
    │   │       │   ├── metric_tab_content.dart
    │   │       │   └── metrics_container_page.dart
    │   │       └── widgets
    │   │           ├── metric_chart.dart
    │   │           ├── metric_history.dart
    │   │           ├── metric_info_card.dart
    │   │           └── metric_stats.dart
    │   ├── onboarding
    │   │   └── presentation
    │   │       ├── pages
    │   │       │   └── onboarding_page.dart
    │   │       └── widgets
    │   │           ├── birth_date_page.dart
    │   │           ├── height_page.dart
    │   │           ├── name_page.dart
    │   │           ├── sex_page.dart
    │   │           └── weight_page.dart
    │   ├── profile
    │   │   └── presentation
    │   │       ├── pages
    │   │       │   ├── edit_profile_page.dart
    │   │       │   ├── profile_page.dart
    │   │       │   └── settings_page.dart
    │   │       └── widgets
    │   │           ├── avatar_picker_modal.dart
    │   │           ├── edit_profile_widgets.dart
    │   │           ├── profile_card.dart
    │   │           ├── profile_header.dart
    │   │           ├── settings
    │   │           │   └── settings_widgets.dart
    │   │           └── widgets.dart
    │   └── schedule
    │       └── presentation
    │           ├── pages
    │           │   ├── schedule_edit_page.dart
    │           │   └── schedule_page.dart
    │           └── widgets
    │               ├── schedule_form_section.dart
    │               ├── schedule_header.dart
    │               ├── schedule_item.dart
    │               ├── schedule_section.dart
    │               ├── schedule_selector.dart
    │               ├── schedule_stat_card.dart
    │               ├── schedule_text_field.dart
    │               └── widgets.dart
    ├── l10n
    │   ├── app_localizations.dart
    │   ├── app_localizations_en.dart
    │   └── app_localizations_ru.dart
    └── main.dart

```

`lib\core\helpers\modal_helper.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:health_oracle/core/theme/colors.dart';
import 'package:health_oracle/core/theme/app_theme.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import '../widgets/bottom_entry_menu.dart';

class ModalHelper {
  static Future<Map<String, Map<String, String>>?> showBottomEntryMenu(BuildContext context) async {
  final selectedNotifier = ValueNotifier<Set<String>>({});
  final screenHeight = MediaQuery.of(context).size.height;
  const double modalHeightFactor = 0.75; 

  try {
    return await WoltModalSheet.show<Map<String, Map<String, String>>>(
      context: context,
      pageListBuilder: (modalSheetContext) => [
        WoltModalSheetPage(
          backgroundColor: AppTheme.background(context),
          surfaceTintColor: Colors.transparent,
          hasTopBarLayer: false,
          isTopBarLayerAlwaysVisible: false,
          child: Builder(
            builder: (ctx) => SizedBox(
              height: screenHeight * modalHeightFactor,
              child: SingleChildScrollView(
                child: BottomEntryMenu(
                  selectedNotifier: selectedNotifier,
                  onCancel: () => Navigator.of(ctx).pop(),
                  onSave: (data) => Navigator.of(ctx).pop(data),
                ),
              ),
            ),
          ),
        ),
      ],
      modalTypeBuilder: (_) => WoltModalType.bottomSheet(),
    );
  } catch (e) {
    print('WoltModalSheet failed, falling back to showModalBottomSheet: $e');

    return showModalBottomSheet<Map<String, Map<String, String>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(ctx).viewInsets,
          child: SizedBox(
            height: screenHeight * modalHeightFactor,
            child: SingleChildScrollView(
              child: BottomEntryMenu(
                selectedNotifier: selectedNotifier,
                onCancel: () => Navigator.of(ctx).pop(),
                onSave: (data) => Navigator.of(ctx).pop(data),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
}

```

`lib\core\i18n\l10n_extension.dart`:

```dart
import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

```

`lib\core\i18n\strings.dart`:

```dart
class Strings {
  static const String cancel = 'Отмена';
  static const String save = 'Сохранить';
  static const String edit = 'Редактировать';
  static const String delete = 'Удалить';
  static const String deleteEntry = 'Удалить запись?';
  static const String notSpecified = 'Не указано';
  static const String noData = 'Нет данных';
  static const String yesterday = 'Вчера';
  static const String daysAgo = 'дн. назад';

  static const String addEntryTitle = 'Добавить запись';
  static const String choosePlaceholder = 'Выберите категорию(ии) сверху';
  static const String selectedPrefix = 'Выбрано: ';
  static const String inputToolsPlaceholder = 'Здесь появятся инструменты ввода (пока заглушка).';

  static const String greetingMorning = 'Доброе утро,';
  static const String greetingDay = 'Добрый день,';
  static const String greetingEvening = 'Добрый вечер,';
  static const String greetingNight = 'Доброй ночи,';
  static const String userName = 'Ромаэль!';
  static const String defaultUserName = 'Пользователь';

  static const String unitMmHg = 'мм рт.ст.';
  static const String unitBpm = 'уд/мин';
  static const String unitMmol = 'ммоль/л';
  static const String unitKg = 'кг';
  static const String unitCm = 'см';

  static const String lastToday = 'Сегодня';
  static const String last2Days = '2 дня назад';
  static const String lastWeek = 'Неделю назад';

  static const String profile = 'Профиль';
  static const String editProfile = 'Редактировать профиль';
  static const String personalData = 'Личные данные';
  static const String physicalParams = 'Физические параметры';
  static const String firstName = 'Имя';
  static const String birthDate = 'Дата рождения';
  static const String height = 'Рост';
  static const String weight = 'Вес';
  static const String age = 'Возраст';
  static const String yearsOld = 'лет';
  static const String clearData = 'Очистить данные';

  static const String home = 'Главная';
  static const String history = 'История';
  static const String schedule = 'Расписание';
  static const String settings = 'Настройки';

  static const String metricPressure = 'Давление';
  static const String metricPulse = 'Пульс';
  static const String metricWeight = 'Вес';
  static const String metricSugar = 'Сахар';

  static const String metricPressureUpper = 'ДАВЛЕНИЕ';
  static const String metricPulseUpper = 'ПУЛЬС';
  static const String metricWeightUpper = 'ВЕС';
  static const String metricSugarUpper = 'САХАР';

  static const String historyNoRecords = 'Записей пока нет';
  static const String historyAddFirst = 'Добавьте первое измерение';
  static const String historyYourMeasurements = 'Ваши измерения';

  static const String onboardingWelcome = 'Добро пожаловать!';
  static const String onboardingSubtitle = 'Давайте познакомимся';
  static const String onboardingQuestion = 'Как к вам можно обращаться?';
  static const String onboardingNameHint = 'Ваше имя';
  static const String onboardingContinue = 'Далее';
  static const String onboardingFinish = 'Начать';
  static const String onboardingBirthDateTitle = 'Дата рождения';
  static const String onboardingBirthDateSubtitle = 'Это поможет рассчитать ваш возраст';
  static const String onboardingSelectDate = 'Выберите дату';
  static const String onboardingHeightTitle = 'Ваш рост';
  static const String onboardingHeightSubtitle = 'Укажите ваш рост в сантиметрах';
  static const String onboardingWeightTitle = 'Ваш вес';
  static const String onboardingWeightSubtitle = 'Укажите ваш вес в килограммах';
}

```

`lib\core\theme\app_theme.dart`:

```dart
import 'package:flutter/material.dart';
import 'colors.dart';

/// Готовые ThemeData для светлой и тёмной тем.
class AppTheme {
  // ─── Light ────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        fontFamily: 'Manrope',
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: AppColors.success500, // Зелёный для включённого состояния Switch
          surface: AppColors.surface,
          error: AppColors.error500,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          trackOutlineWidth: WidgetStateProperty.all(0),
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.success500;
            }
            return AppColors.neutral300;
          }),
        ),
      );

  // ─── Dark ─────────────────────────────────────────────────────
  static const _darkBg = Color(0xFF101014);
  static const _darkSurface = Color(0xFF1B1B20);
  static const _darkCard = Color(0xFF26262C);

  static ThemeData get dark => ThemeData(
        fontFamily: 'Manrope',
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _darkBg,
        colorScheme: ColorScheme.dark(
          primary: AppColors.success500, // Зелёный для включённого состояния Switch
          surface: _darkSurface,
          error: AppColors.error500,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: _darkCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        switchTheme: SwitchThemeData(
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          trackOutlineWidth: WidgetStateProperty.all(0),
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.success500;
            }
            return const Color(0xFF424242);
          }),
        ),
      );

  // ─── Dark-aware colors (вызывать из context) ──────────────────

  /// Основной фон
  static Color background(BuildContext context) =>
      _isDark(context) ? _darkBg : AppColors.background;

  /// Поверхность (карточки, листы)
  static Color surface(BuildContext context) =>
      _isDark(context) ? _darkSurface : AppColors.surface;

  /// Поверхность второго уровня (вложенные карточки, поля ввода)
  static Color surfaceVariant(BuildContext context) =>
      _isDark(context) ? _darkCard : AppColors.neutral50;

  /// Основной текст
  static Color textPrimary(BuildContext context) =>
      _isDark(context) ? Colors.white : AppColors.neutral900;

  /// Вторичный текст
  static Color textSecondary(BuildContext context) =>
      _isDark(context) ? const Color(0xFFB0B0B8) : AppColors.neutral600;

  /// Текст-подсказка / третичный
  static Color textHint(BuildContext context) =>
      _isDark(context) ? const Color(0xFF808088) : AppColors.neutral500;

  /// Разделитель
  static Color divider(BuildContext context) =>
      _isDark(context) ? const Color(0xFF35353C) : AppColors.neutral200;

  /// Граница элемента
  static Color border(BuildContext context) =>
      _isDark(context) ? const Color(0xFF3C3C44) : AppColors.neutral200;

  /// Тень карточки
  static Color cardShadow(BuildContext context) =>
      _isDark(context) ? Colors.transparent : AppColors.cardShadow;

  /// Primary (тёмные кнопки / иконки навбара)
  static Color primary(BuildContext context) =>
      _isDark(context) ? Colors.white : AppColors.primary;

  // ─── Готовые декорации карточек ────────────────────────────────

  /// Стандартная декорация карточки: в светлой теме — тень, в тёмной — бордер.
  static BoxDecoration cardDecoration(
    BuildContext context, {
    double radius = 16,
    double shadowAlpha = 0.08,
    double blurRadius = 12,
    Offset shadowOffset = const Offset(0, 3),
  }) {
    final dark = _isDark(context);
    return BoxDecoration(
      color: dark ? _darkSurface : AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: dark ? Border.all(color: const Color(0xFF3C3C44), width: 0.5) : null,
      boxShadow: dark
          ? null
          : [
              BoxShadow(
                color: AppColors.cardShadow.withValues(alpha: shadowAlpha),
                blurRadius: blurRadius,
                offset: shadowOffset,
              ),
            ],
    );
  }

  /// Декорация вложенной карточки (surfaceVariant)
  static BoxDecoration nestedCardDecoration(
    BuildContext context, {
    double radius = 12,
  }) {
    final dark = _isDark(context);
    return BoxDecoration(
      color: dark ? _darkCard : AppColors.neutral50,
      borderRadius: BorderRadius.circular(radius),
      border: dark ? Border.all(color: const Color(0xFF3C3C44), width: 0.5) : null,
    );
  }

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

```

`lib\core\theme\colors.dart`:

```dart
// colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFf6f7f9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF353539);
  
  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF7F8F9);
  static const Color neutral200 = Color(0xFFF0F1F3);
  static const Color neutral300 = Color(0xFFE9ECEF);
  static const Color neutral400 = Color(0xFFCED4DA);
  static const Color neutral500 = Color(0xFFADB5BD);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF495057);
  static const Color neutral800 = Color(0xFF343A40);
  static const Color neutral900 = Color(0xFF212529);

  // Semantic colors
  static const Color actionPrimary = Color(0xFF353539);
  static const Color buttonBorder = Color(0xFFE9ECEF);
  static const Color cardShadow = Color(0x1F000000);
  
  // Status colors
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error200 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error400 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);

  static const Color success500 = Color(0xFF22C55E);
  static const Color warning500 = Color(0xFFEAB308);
  static const Color info500 = Color(0xFF3B82F6);

  // Gradients
  static const Gradient pressureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
  );
  
  static const Gradient sugarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
  );
  
  static const Gradient weightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
  );
  
  static const Gradient pulseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFc44747)],
  );

    static const Gradient primaryGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF31d8b9), Color(0xFF2bc4a4)],
    );

  static const Gradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4CD964),
      Color(0xFF22C55E),
      Color(0xFF16A34A),
    ],
  );

}
```

`lib\core\theme\text_styles.dart`:

```dart
import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 28,
    fontWeight: FontWeight.w700, // 700 = Bold
    color: Colors.black87,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Manrope', 
    fontSize: 18,
    fontWeight: FontWeight.w600, // 600 = SemiBold
    color: Colors.black87,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 16, 
    fontWeight: FontWeight.w500, // 500 = Medium
    color: Colors.black54,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.w500, // 500 = Medium
    color: Colors.white,
  );

static const TextStyle labelXSmall = TextStyle(
  fontFamily: 'Manrope',
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
  }
```

`lib\core\widgets\bottom_entry_actions.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/app_theme.dart';
import '../i18n/l10n_extension.dart';

typedef VoidCallbackNullable = void Function();

class BottomEntryActions extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onSave;

  const BottomEntryActions({super.key, this.onCancel, this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.surfaceVariant(context),
                foregroundColor: AppColors.actionPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: onCancel,
              child: SizedBox(
                height: 44,
                child: Center(child: Text(context.l10n.cancel)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSave,
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                    child: Text(
                      context.l10n.save,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\core\widgets\bottom_entry_category_container.dart`:

```dart

import 'package:flutter/material.dart';
import 'bottom_entry_input_field.dart';

class BottomEntryCategoryContainer extends StatelessWidget {
  final Set<String> selectedCategories;
  final Map<String, Map<String, TextEditingController>> controllers;

  const BottomEntryCategoryContainer({
    super.key,
    required this.selectedCategories,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildInputFields(),
    );
  }

  List<Widget> _buildInputFields() {
    final List<Widget> fields = [];

    if (selectedCategories.contains('Давление')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Верхнее давление',
          unit: 'мм рт. ст.',
          controller: controllers['Давление']!['верхнее']!,
          hintText: '120',
          isRequired: true,
        ),
        const SizedBox(height: 14), 
        BottomEntryInputField(
          label: 'Нижнее давление',
          unit: 'мм рт. ст.',
          controller: controllers['Давление']!['нижнее']!,
          hintText: '80',
          isRequired: true,
        ),
        const SizedBox(height: 14), 
      ]);
    }

    if (selectedCategories.contains('Пульс')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Пульс',
          unit: 'уд/мин',
          controller: controllers['Пульс']!['пульс']!,
          hintText: '72',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (selectedCategories.contains('Вес')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Вес',
          unit: 'кг',
          controller: controllers['Вес']!['вес']!,
          hintText: '70.5',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (selectedCategories.contains('Сахар')) {
      fields.addAll([
        BottomEntryInputField(
          label: 'Уровень сахара',
          unit: 'ммоль/л',
          controller: controllers['Сахар']!['сахар']!,
          hintText: '5.2',
          isRequired: true,
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (fields.isNotEmpty && fields.last is SizedBox) {
      fields.removeLast();
    }

    return fields;
  }
}
```

`lib\core\widgets\bottom_entry_category_tile.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/text_styles.dart';

class BottomEntryCategoryTile extends StatelessWidget {
  final String title;
  final bool selected;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const BottomEntryCategoryTile({
    super.key,
    required this.title,
    required this.selected,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            gradient: selected && gradient != null ? gradient : null,
            color: selected ? null : AppTheme.surfaceVariant(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border(context)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyles.labelXSmall.copyWith(
                color: selected ? Colors.white : AppTheme.textSecondary(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

```

`lib\core\widgets\bottom_entry_input_field.dart`:

```dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/app_theme.dart';
import '../theme/text_styles.dart';

class BottomEntryInputField extends StatelessWidget {
  final String label;
  final String? unit;
  final TextEditingController controller;
  final String? hintText;
  final bool isRequired;

  const BottomEntryInputField({
    super.key,
    required this.label,
    required this.controller,
    this.unit,
    this.hintText,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppColors.neutral700,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.error500),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56, 
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
                  keyboardType: TextInputType.number,
                  style: TextStyles.bodyMedium.copyWith(
                    fontSize: 18, 
                    color: AppColors.neutral800,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    hintStyle: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textHint(context),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              if (unit != null) ...[
                Container(
                  width: 1,
                  height: 24,
                  color: AppTheme.divider(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    unit!,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textSecondary(context),
                      fontWeight: FontWeight.w600,
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
}
```

`lib\core\widgets\bottom_entry_menu.dart`:

```dart
// bottom_entry_menu.dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/app_theme.dart';
import '../theme/text_styles.dart';
import '../i18n/l10n_extension.dart';
import 'bottom_entry_category_tile.dart';
import 'bottom_entry_category_container.dart';
import 'bottom_entry_actions.dart';
import '../../data/data.dart';

class BottomEntryMenu extends StatefulWidget {
  final void Function(Map<String, Map<String, String>>)? onSave;
  final VoidCallback? onCancel;
  final ValueNotifier<Set<String>>? selectedNotifier;

  const BottomEntryMenu({
    super.key,
    this.onSave,
    this.onCancel,
    this.selectedNotifier,
  });

  @override
  State<BottomEntryMenu> createState() => _BottomEntryMenuState();
}

class _BottomEntryMenuState extends State<BottomEntryMenu> {
  final List<String> _categories = ['Давление', 'Пульс', 'Вес', 'Сахар'];
  late Set<String> _selected;
  late Map<String, Map<String, TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _selected = {'Давление', 'Пульс'};
    _initializeControllers();
    widget.selectedNotifier?.value = Set<String>.from(_selected);
  }

  void _initializeControllers() {
    _controllers = {
      'Давление': {
        'верхнее': TextEditingController(),
        'нижнее': TextEditingController(),
      },
      'Пульс': {
        'пульс': TextEditingController(),
      },
      'Вес': {
        'вес': TextEditingController(),
      },
      'Сахар': {
        'сахар': TextEditingController(),
      },
    };
  }

  void _toggle(String cat) {
    setState(() {
      if (_selected.contains(cat)) {
        _selected.remove(cat);
      } else {
        _selected.add(cat);
      }
      widget.selectedNotifier?.value = Set<String>.from(_selected);
    });

    
  }

   void _saveData(BuildContext context) async{

    for (final category in _selected) {
    final controllers = _controllers[category]!;
    switch (category) {
      case 'Давление':
        final sys = double.parse(controllers['верхнее']!.text);
        final dia = double.parse(controllers['нижнее']!.text);
        await EntryService.add(
          type: EntryType.pressure,
          value: sys,      // верхнее
          secondaryValue: dia, // нижнее
        );
        break;
      case 'Пульс':
        final pulse = double.parse(controllers['пульс']!.text);
        await EntryService.add(
          type: EntryType.pulse,
          value: pulse,
        );
        break;
      case 'Вес':
        final weight = double.parse(controllers['вес']!.text);
        await EntryService.add(
          type: EntryType.weight,
          value: weight,
        );
        break;
      case 'Сахар':
        final sugar = double.parse(controllers['сахар']!.text);
        await EntryService.add(
          type: EntryType.sugar,
          value: sugar,
        );
        break;
    }
  }
    
    // Вызываем callback если есть
    final data = <String, Map<String, String>>{};
    for (final category in _selected) {
      data[category] = {};
      for (final entry in _controllers[category]!.entries) {
        data[category]![entry.key] = entry.value.text;
      }
    }
    widget.onSave?.call(data);
  }


  @override
  void dispose() {
    for (final categoryControllers in _controllers.values) {
      for (final controller in categoryControllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: AppTheme.divider(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              context.l10n.addEntryTitle, 
              style: TextStyles.titleMedium.copyWith(
                fontSize: 20, 
              ),
            ),
          ),
          

          const SizedBox(height: 16), 

          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = 12.0;
              final tileWidth = (constraints.maxWidth - spacing) / 2;

              final Map<String, Gradient> gradients = {
                'Давление': AppColors.pressureGradient,
                'Пульс': AppColors.pulseGradient,
                'Вес': AppColors.weightGradient,
                'Сахар': AppColors.sugarGradient,
              };

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _categories.map((c) {
                  return SizedBox(
                    width: tileWidth,
                    child: BottomEntryCategoryTile(
                      title: c,
                      selected: _selected.contains(c),
                      gradient: gradients[c],
                      onTap: () => _toggle(c),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 24),
          
          
          BottomEntryCategoryContainer(
            selectedCategories: _selected,
            controllers: _controllers,
          ),
          
          const SizedBox(height: 24),
          

          BottomEntryActions(
            onCancel: widget.onCancel,
           onSave: () => _saveData(context),
          ),
        ],
      ),
    );
  }
}
```

`lib\core\widgets\health_card.dart`:

```dart

import 'package:flutter/material.dart';
import '../theme/text_styles.dart';

class HealthCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String lastUpdate;
  final Gradient gradient;
  final Widget icon;
  final VoidCallback? onTap;

  const HealthCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.lastUpdate,
    required this.gradient,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: TextStyles.labelXSmall,
                  ),
                  
                  const Spacer(),
                  

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        unit,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      lastUpdate,
                      style: TextStyles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            

            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 48,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\data\data.dart`:

```dart
// Barrel file для data layer
export 'models/user_profile.dart';
export 'models/health_entry.dart';
export 'models/reminder.dart';
export 'services/profile_service.dart';
export 'services/entry_service.dart';
export 'services/reminder_service.dart';
export 'services/notification_service.dart';
export 'services/prediction_service.dart';
export 'services/health_categorizer.dart';
export 'services/random_forest_model.dart';
export 'services/theme_service.dart';

```

`lib\data\models\health_entry.dart`:

```dart
import 'package:hive/hive.dart';
import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

part 'health_entry.g.dart';


@HiveType(typeId: 1)
enum EntryType {
  @HiveField(0)
  pressure,
  
  @HiveField(1)
  pulse,
  
  @HiveField(2)
  weight,
  
  @HiveField(3)
  sugar,
}


@HiveType(typeId: 2)
class HealthEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  EntryType type;

  @HiveField(2)
  DateTime createdAt;


  @HiveField(3)
  double value;


  @HiveField(4)
  double? secondaryValue;


  @HiveField(5)
  String? note;

  HealthEntry({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.value,
    this.secondaryValue,
    this.note,
  });


  String get displayValue {
    switch (type) {
      case EntryType.pressure:
        return '${value.toInt()}/${secondaryValue?.toInt() ?? 0}';
      case EntryType.pulse:
        return '${value.toInt()}';
      case EntryType.weight:
        return value.toStringAsFixed(1);
      case EntryType.sugar:
        return value.toStringAsFixed(1);
    }
  }

  String unit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case EntryType.pressure:
        return l10n.unitMmHg;
      case EntryType.pulse:
        return l10n.unitBpm;
      case EntryType.weight:
        return l10n.unitKg;
      case EntryType.sugar:
        return l10n.unitMmol;
    }
  }

  String typeName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case EntryType.pressure:
        return l10n.metricPressure;
      case EntryType.pulse:
        return l10n.metricPulse;
      case EntryType.weight:
        return l10n.metricWeight;
      case EntryType.sugar:
        return l10n.metricSugar;
    }
  }
}

```

`lib\data\models\health_entry.g.dart`:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthEntryAdapter extends TypeAdapter<HealthEntry> {
  @override
  final int typeId = 2;

  @override
  HealthEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthEntry(
      id: fields[0] as String,
      type: fields[1] as EntryType,
      createdAt: fields[2] as DateTime,
      value: fields[3] as double,
      secondaryValue: fields[4] as double?,
      note: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.secondaryValue)
      ..writeByte(5)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EntryTypeAdapter extends TypeAdapter<EntryType> {
  @override
  final int typeId = 1;

  @override
  EntryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EntryType.pressure;
      case 1:
        return EntryType.pulse;
      case 2:
        return EntryType.weight;
      case 3:
        return EntryType.sugar;
      default:
        return EntryType.pressure;
    }
  }

  @override
  void write(BinaryWriter writer, EntryType obj) {
    switch (obj) {
      case EntryType.pressure:
        writer.writeByte(0);
        break;
      case EntryType.pulse:
        writer.writeByte(1);
        break;
      case EntryType.weight:
        writer.writeByte(2);
        break;
      case EntryType.sugar:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

```

`lib\data\models\reminder.dart`:

```dart
import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 3)
enum RepeatType {
  @HiveField(0)
  daily,
  
  @HiveField(1)
  weekly,
  
  @HiveField(2)
  monthly,
  
  @HiveField(3)
  weekdays,
}

@HiveType(typeId: 4)
enum ReminderCategory {
  @HiveField(0)
  pressure,
  
  @HiveField(1)
  pulse,
  
  @HiveField(2)
  weight,
  
  @HiveField(3)
  sugar,
  
  @HiveField(4)
  other,
}

@HiveType(typeId: 5)
class Reminder extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int hour;

  @HiveField(4)
  int minute;

  @HiveField(5)
  RepeatType repeatType;

  @HiveField(6)
  ReminderCategory category;

  @HiveField(7)
  bool isActive;

  @HiveField(8)
  DateTime createdAt;

  Reminder({
    required this.id,
    required this.title,
    this.description,
    required this.hour,
    required this.minute,
    required this.repeatType,
    required this.category,
    this.isActive = true,
    required this.createdAt,
  });

  String get timeString {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

```

`lib\data\models\reminder.g.dart`:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 5;

  @override
  Reminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      hour: fields[3] as int,
      minute: fields[4] as int,
      repeatType: fields[5] as RepeatType,
      category: fields[6] as ReminderCategory,
      isActive: fields[7] as bool,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.repeatType)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RepeatTypeAdapter extends TypeAdapter<RepeatType> {
  @override
  final int typeId = 3;

  @override
  RepeatType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepeatType.daily;
      case 1:
        return RepeatType.weekly;
      case 2:
        return RepeatType.monthly;
      case 3:
        return RepeatType.weekdays;
      default:
        return RepeatType.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RepeatType obj) {
    switch (obj) {
      case RepeatType.daily:
        writer.writeByte(0);
        break;
      case RepeatType.weekly:
        writer.writeByte(1);
        break;
      case RepeatType.monthly:
        writer.writeByte(2);
        break;
      case RepeatType.weekdays:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReminderCategoryAdapter extends TypeAdapter<ReminderCategory> {
  @override
  final int typeId = 4;

  @override
  ReminderCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderCategory.pressure;
      case 1:
        return ReminderCategory.pulse;
      case 2:
        return ReminderCategory.weight;
      case 3:
        return ReminderCategory.sugar;
      case 4:
        return ReminderCategory.other;
      default:
        return ReminderCategory.pressure;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderCategory obj) {
    switch (obj) {
      case ReminderCategory.pressure:
        writer.writeByte(0);
        break;
      case ReminderCategory.pulse:
        writer.writeByte(1);
        break;
      case ReminderCategory.weight:
        writer.writeByte(2);
        break;
      case ReminderCategory.sugar:
        writer.writeByte(3);
        break;
      case ReminderCategory.other:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

```

`lib\data\models\user_profile.dart`:

```dart
import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String firstName;

  @HiveField(2)
  DateTime? birthDate;

  @HiveField(3)
  double? height;

  /// true = мужской, false = женский, null = не указан
  @HiveField(4)
  bool? sex;

  @HiveField(5)
  double? weight;

  @HiveField(6)
  String? avatarName;

  UserProfile({
    required this.firstName,
    this.birthDate,
    this.height,
    this.sex,
    this.weight,
    this.avatarName,
  });

  /// Возраст в годах
  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    int years = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      years--;
    }
    return years;
  }

  /// Создаёт копию с изменёнными полями
  UserProfile copyWith({
    String? firstName,
    DateTime? birthDate,
    double? height,
    bool? sex,
    double? weight,
    String? avatarName,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      sex: sex ?? this.sex,
      weight: weight ?? this.weight,
      avatarName: avatarName ?? this.avatarName,
    );
  }
}

```

`lib\data\models\user_profile.g.dart`:

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      firstName: fields[0] as String,
      birthDate: fields[2] as DateTime?,
      height: fields[3] as double?,
      sex: fields[4] as bool?,
      weight: fields[5] as double?,
      avatarName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.birthDate)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.sex)
      ..writeByte(5)
      ..write(obj.weight)
      ..writeByte(6)
      ..write(obj.avatarName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

```

`lib\data\services\entry_service.dart`:

```dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/health_entry.dart';


class EntryService {
  static const String _boxName = 'health_entries';
  static Box<HealthEntry>? _box;
  static const _uuid = Uuid();


  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(EntryTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(HealthEntryAdapter());
    }

    _box = await Hive.openBox<HealthEntry>(_boxName);
  }


  static List<HealthEntry> getAll() {
    return _box?.values.toList() ?? [];
  }


  static List<HealthEntry> getByType(EntryType type) {
    return _box?.values.where((e) => e.type == type).toList() ?? [];
  }


  static HealthEntry? getLastByType(EntryType type) {
    final entries = getByType(type);
    if (entries.isEmpty) return null;
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries.first;
  }


  static List<HealthEntry> getByDateRange(DateTime start, DateTime end) {
    return _box?.values
            .where((e) => e.createdAt.isAfter(start) && e.createdAt.isBefore(end))
            .toList() ??
        [];
  }

  static List<HealthEntry> getByTypeAndDateRange(EntryType type, DateTime start, DateTime end) {
    final entries = _box?.values
            .where((e) => 
                e.type == type && 
                (e.createdAt.isAfter(start) || e.createdAt.isAtSameMomentAs(start)) && 
                (e.createdAt.isBefore(end) || e.createdAt.isAtSameMomentAs(end)))
            .toList() ?? [];
    entries.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return entries;
  }


  static Future<HealthEntry> add({
    required EntryType type,
    required double value,
    double? secondaryValue,
    String? note,
    DateTime? createdAt,
  }) async {
    if (_box == null) {
      throw Exception('EntryService not initialized. Call init() first.');
    }
    
    final entry = HealthEntry(
      id: _uuid.v4(),
      type: type,
      createdAt: createdAt ?? DateTime.now(),
      value: value,
      secondaryValue: secondaryValue,
      note: note,
    );

    await _box!.put(entry.id, entry);
    print('EntryService: Added entry ${entry.id}, type: ${entry.type}, value: ${entry.value}');
    return entry;
  }

  static Future<void> update(HealthEntry entry) async {
    await _box?.put(entry.id, entry);
  }


  static Future<void> delete(String id) async {
    await _box?.delete(id);
  }

  static Future<void> deleteAll() async {
    await _box?.clear();
  }

  static int get count => _box?.length ?? 0;

  static Stream<BoxEvent>? watch() {
    return _box?.watch();
  }
}

```

`lib\data\services\health_categorizer.dart`:

```dart
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

```

`lib\data\services\hypertension_svc_model.dart`:

```dart
import 'dart:math';
List<double> score(List<double> input) {
    double var0;
    var0 = (pow(0.00009295334872448127 * (0.0 * input[0] + 51.0 * input[1] + 123.0 * input[2] + 78.0 * input[3] + 72.0 * input[4] + 22.491349480968857 * input[5]) + 0.0, 3.0)).toDouble();
    double var1;
    var1 = (pow(0.00009295334872448127 * (1.0 * input[0] + 76.0 * input[1] + 136.0 * input[2] + 71.0 * input[3] + 72.0 * input[4] + 24.835763499439192 * input[5]) + 0.0, 3.0)).toDouble();
    double var2;
    var2 = (pow(0.00009295334872448127 * (1.0 * input[0] + 38.0 * input[1] + 122.0 * input[2] + 69.0 * input[3] + 60.0 * input[4] + 29.136316337148806 * input[5]) + 0.0, 3.0)).toDouble();
    double var3;
    var3 = (pow(0.00009295334872448127 * (0.0 * input[0] + 54.0 * input[1] + 137.0 * input[2] + 80.0 * input[3] + 81.0 * input[4] + 20.761245674740483 * input[5]) + 0.0, 3.0)).toDouble();
    double var4;
    var4 = (pow(0.00009295334872448127 * (1.0 * input[0] + 85.0 * input[1] + 125.0 * input[2] + 62.0 * input[3] + 75.0 * input[4] + 21.907582457706194 * input[5]) + 0.0, 3.0)).toDouble();
    double var5;
    var5 = (pow(0.00009295334872448127 * (1.0 * input[0] + 54.0 * input[1] + 137.0 * input[2] + 84.0 * input[3] + 62.0 * input[4] + 25.969529085872576 * input[5]) + 0.0, 3.0)).toDouble();
    double var6;
    var6 = (pow(0.00009295334872448127 * (0.0 * input[0] + 60.0 * input[1] + 120.0 * input[2] + 63.0 * input[3] + 86.0 * input[4] + 21.0828132906055 * input[5]) + 0.0, 3.0)).toDouble();
    double var7;
    var7 = (pow(0.00009295334872448127 * (1.0 * input[0] + 47.0 * input[1] + 137.0 * input[2] + 80.0 * input[3] + 78.0 * input[4] + 22.666666666666668 * input[5]) + 0.0, 3.0)).toDouble();
    double var8;
    var8 = (pow(0.00009295334872448127 * (0.0 * input[0] + 59.0 * input[1] + 135.0 * input[2] + 84.0 * input[3] + 80.0 * input[4] + 23.23345617689473 * input[5]) + 0.0, 3.0)).toDouble();
    double var9;
    var9 = (pow(0.00009295334872448127 * (0.0 * input[0] + 56.0 * input[1] + 124.0 * input[2] + 75.0 * input[3] + 93.0 * input[4] + 19.721036967980208 * input[5]) + 0.0, 3.0)).toDouble();
    double var10;
    var10 = (pow(0.00009295334872448127 * (1.0 * input[0] + 59.0 * input[1] + 139.0 * input[2] + 85.0 * input[3] + 80.0 * input[4] + 21.051708258409718 * input[5]) + 0.0, 3.0)).toDouble();
    double var11;
    var11 = (pow(0.00009295334872448127 * (1.0 * input[0] + 56.0 * input[1] + 123.0 * input[2] + 75.0 * input[3] + 63.0 * input[4] + 21.631148854350265 * input[5]) + 0.0, 3.0)).toDouble();
    double var12;
    var12 = (pow(0.00009295334872448127 * (0.0 * input[0] + 59.0 * input[1] + 133.0 * input[2] + 77.0 * input[3] + 66.0 * input[4] + 27.358845456721724 * input[5]) + 0.0, 3.0)).toDouble();
    double var13;
    var13 = (pow(0.00009295334872448127 * (1.0 * input[0] + 77.0 * input[1] + 120.0 * input[2] + 69.0 * input[3] + 76.0 * input[4] + 25.63116749967961 * input[5]) + 0.0, 3.0)).toDouble();
    double var14;
    var14 = (pow(0.00009295334872448127 * (1.0 * input[0] + 64.0 * input[1] + 124.0 * input[2] + 70.0 * input[3] + 77.0 * input[4] + 20.88888888888889 * input[5]) + 0.0, 3.0)).toDouble();
    double var15;
    var15 = (pow(0.00009295334872448127 * (1.0 * input[0] + 63.0 * input[1] + 120.0 * input[2] + 60.0 * input[3] + 76.0 * input[4] + 19.223375624759708 * input[5]) + 0.0, 3.0)).toDouble();
    double var16;
    var16 = (pow(0.00009295334872448127 * (0.0 * input[0] + 64.0 * input[1] + 126.0 * input[2] + 65.0 * input[3] + 66.0 * input[4] + 20.703125 * input[5]) + 0.0, 3.0)).toDouble();
    double var17;
    var17 = (pow(0.00009295334872448127 * (1.0 * input[0] + 67.0 * input[1] + 135.0 * input[2] + 75.0 * input[3] + 72.0 * input[4] + 22.892819979188346 * input[5]) + 0.0, 3.0)).toDouble();
    double var18;
    var18 = (pow(0.00009295334872448127 * (0.0 * input[0] + 73.0 * input[1] + 139.0 * input[2] + 71.0 * input[3] + 72.0 * input[4] + 22.65625 * input[5]) + 0.0, 3.0)).toDouble();
    double var19;
    var19 = (pow(0.00009295334872448127 * (0.0 * input[0] + 48.0 * input[1] + 122.0 * input[2] + 77.0 * input[3] + 76.0 * input[4] + 19.37919743392696 * input[5]) + 0.0, 3.0)).toDouble();
    double var20;
    var20 = (pow(0.00009295334872448127 * (1.0 * input[0] + 65.0 * input[1] + 139.0 * input[2] + 69.0 * input[3] + 63.0 * input[4] + 19.959355494266223 * input[5]) + 0.0, 3.0)).toDouble();
    double var21;
    var21 = (pow(0.00009295334872448127 * (0.0 * input[0] + 42.0 * input[1] + 121.0 * input[2] + 73.0 * input[3] + 66.0 * input[4] + 35.33859303090072 * input[5]) + 0.0, 3.0)).toDouble();
    double var22;
    var22 = (pow(0.00009295334872448127 * (1.0 * input[0] + 78.0 * input[1] + 138.0 * input[2] + 66.0 * input[3] + 58.0 * input[4] + 24.03460983816696 * input[5]) + 0.0, 3.0)).toDouble();
    double var23;
    var23 = (pow(0.00009295334872448127 * (0.0 * input[0] + 81.0 * input[1] + 137.0 * input[2] + 74.0 * input[3] + 61.0 * input[4] + 20.549886621315192 * input[5]) + 0.0, 3.0)).toDouble();
    double var24;
    var24 = (pow(0.00009295334872448127 * (1.0 * input[0] + 84.0 * input[1] + 127.0 * input[2] + 65.0 * input[3] + 60.0 * input[4] + 19.04432132963989 * input[5]) + 0.0, 3.0)).toDouble();
    double var25;
    var25 = (pow(0.00009295334872448127 * (0.0 * input[0] + 73.0 * input[1] + 123.0 * input[2] + 68.0 * input[3] + 67.0 * input[4] + 24.21875 * input[5]) + 0.0, 3.0)).toDouble();
    double var26;
    var26 = (pow(0.00009295334872448127 * (0.0 * input[0] + 71.0 * input[1] + 136.0 * input[2] + 68.0 * input[3] + 68.0 * input[4] + 19.53125 * input[5]) + 0.0, 3.0)).toDouble();
    double var27;
    var27 = (pow(0.00009295334872448127 * (1.0 * input[0] + 58.0 * input[1] + 126.0 * input[2] + 63.0 * input[3] + 64.0 * input[4] + 24.444444444444443 * input[5]) + 0.0, 3.0)).toDouble();
    double var28;
    var28 = (pow(0.00009295334872448127 * (1.0 * input[0] + 48.0 * input[1] + 124.0 * input[2] + 62.0 * input[3] + 70.0 * input[4] + 26.5625 * input[5]) + 0.0, 3.0)).toDouble();
    double var29;
    var29 = (pow(0.00009295334872448127 * (0.0 * input[0] + 53.0 * input[1] + 138.0 * input[2] + 93.0 * input[3] + 65.0 * input[4] + 24.489795918367346 * input[5]) + 0.0, 3.0)).toDouble();
    double var30;
    var30 = (pow(0.00009295334872448127 * (1.0 * input[0] + 46.0 * input[1] + 123.0 * input[2] + 73.0 * input[3] + 73.0 * input[4] + 27.05515088449532 * input[5]) + 0.0, 3.0)).toDouble();
    double var31;
    var31 = (pow(0.00009295334872448127 * (0.0 * input[0] + 58.0 * input[1] + 137.0 * input[2] + 65.0 * input[3] + 72.0 * input[4] + 25.390625 * input[5]) + 0.0, 3.0)).toDouble();
    double var32;
    var32 = (pow(0.00009295334872448127 * (0.0 * input[0] + 30.0 * input[1] + 121.0 * input[2] + 78.0 * input[3] + 60.0 * input[4] + 26.81174510620575 * input[5]) + 0.0, 3.0)).toDouble();
    double var33;
    var33 = (pow(0.00009295334872448127 * (0.0 * input[0] + 72.0 * input[1] + 133.0 * input[2] + 73.0 * input[3] + 66.0 * input[4] + 20.44913741820345 * input[5]) + 0.0, 3.0)).toDouble();
    double var34;
    var34 = (pow(0.00009295334872448127 * (1.0 * input[0] + 40.0 * input[1] + 120.0 * input[2] + 63.0 * input[3] + 71.0 * input[4] + 22.432302515622496 * input[5]) + 0.0, 3.0)).toDouble();
    double var35;
    var35 = (pow(0.00009295334872448127 * (1.0 * input[0] + 28.0 * input[1] + 122.0 * input[2] + 70.0 * input[3] + 88.0 * input[4] + 22.65625 * input[5]) + 0.0, 3.0)).toDouble();
    double var36;
    var36 = (pow(0.00009295334872448127 * (1.0 * input[0] + 80.0 * input[1] + 123.0 * input[2] + 56.0 * input[3] + 58.0 * input[4] + 24.654832347140037 * input[5]) + 0.0, 3.0)).toDouble();
    double var37;
    var37 = (pow(0.00009295334872448127 * (0.0 * input[0] + 77.0 * input[1] + 138.0 * input[2] + 69.0 * input[3] + 76.0 * input[4] + 21.10726643598616 * input[5]) + 0.0, 3.0)).toDouble();
    double var38;
    var38 = (pow(0.00009295334872448127 * (0.0 * input[0] + 25.0 * input[1] + 120.0 * input[2] + 69.0 * input[3] + 72.0 * input[4] + 17.75568181818182 * input[5]) + 0.0, 3.0)).toDouble();
    double var39;
    var39 = (pow(0.00009295334872448127 * (1.0 * input[0] + 86.0 * input[1] + 130.0 * input[2] + 66.0 * input[3] + 69.0 * input[4] + 27.00513097488523 * input[5]) + 0.0, 3.0)).toDouble();
    double var40;
    var40 = (pow(0.00009295334872448127 * (1.0 * input[0] + 74.0 * input[1] + 139.0 * input[2] + 75.0 * input[3] + 81.0 * input[4] + 18.730489073881376 * input[5]) + 0.0, 3.0)).toDouble();
    double var41;
    var41 = (pow(0.00009295334872448127 * (0.0 * input[0] + 45.0 * input[1] + 117.0 * input[2] + 74.0 * input[3] + 59.0 * input[4] + 24.447278911564627 * input[5]) + 0.0, 3.0)).toDouble();
    double var42;
    var42 = (pow(0.00009295334872448127 * (0.0 * input[0] + 63.0 * input[1] + 115.0 * input[2] + 62.0 * input[3] + 82.0 * input[4] + 20.2020202020202 * input[5]) + 0.0, 3.0)).toDouble();
    double var43;
    var43 = (pow(0.00009295334872448127 * (1.0 * input[0] + 46.0 * input[1] + 114.0 * input[2] + 65.0 * input[3] + 79.0 * input[4] + 21.333333333333332 * input[5]) + 0.0, 3.0)).toDouble();
    double var44;
    var44 = (pow(0.00009295334872448127 * (0.0 * input[0] + 62.0 * input[1] + 117.0 * input[2] + 74.0 * input[3] + 79.0 * input[4] + 23.875114784205692 * input[5]) + 0.0, 3.0)).toDouble();
    double var45;
    var45 = (pow(0.00009295334872448127 * (1.0 * input[0] + 53.0 * input[1] + 116.0 * input[2] + 58.0 * input[3] + 71.0 * input[4] + 25.0 * input[5]) + 0.0, 3.0)).toDouble();
    double var46;
    var46 = (pow(0.00009295334872448127 * (1.0 * input[0] + 51.0 * input[1] + 118.0 * input[2] + 71.0 * input[3] + 84.0 * input[4] + 29.296875 * input[5]) + 0.0, 3.0)).toDouble();
    double var47;
    var47 = (pow(0.00009295334872448127 * (0.0 * input[0] + 52.0 * input[1] + 119.0 * input[2] + 62.0 * input[3] + 94.0 * input[4] + 19.486961451247165 * input[5]) + 0.0, 3.0)).toDouble();
    double var48;
    var48 = (pow(0.00009295334872448127 * (0.0 * input[0] + 58.0 * input[1] + 116.0 * input[2] + 60.0 * input[3] + 78.0 * input[4] + 15.943877551020408 * input[5]) + 0.0, 3.0)).toDouble();
    double var49;
    var49 = (pow(0.00009295334872448127 * (0.0 * input[0] + 74.0 * input[1] + 114.0 * input[2] + 75.0 * input[3] + 106.0 * input[4] + 22.892819979188346 * input[5]) + 0.0, 3.0)).toDouble();
    double var50;
    var50 = (pow(0.00009295334872448127 * (0.0 * input[0] + 62.0 * input[1] + 116.0 * input[2] + 66.0 * input[3] + 70.0 * input[4] + 20.761245674740483 * input[5]) + 0.0, 3.0)).toDouble();
    double var51;
    var51 = (pow(0.00009295334872448127 * (1.0 * input[0] + 85.0 * input[1] + 118.0 * input[2] + 68.0 * input[3] + 72.0 * input[4] + 20.576131687242796 * input[5]) + 0.0, 3.0)).toDouble();
    double var52;
    var52 = (pow(0.00009295334872448127 * (1.0 * input[0] + 41.0 * input[1] + 113.0 * input[2] + 67.0 * input[3] + 67.0 * input[4] + 19.47714681440443 * input[5]) + 0.0, 3.0)).toDouble();
    double var53;
    var53 = (pow(0.00009295334872448127 * (1.0 * input[0] + 54.0 * input[1] + 115.0 * input[2] + 71.0 * input[3] + 70.0 * input[4] + 35.84078259402935 * input[5]) + 0.0, 3.0)).toDouble();
    double var54;
    var54 = (pow(0.00009295334872448127 * (0.0 * input[0] + 26.0 * input[1] + 115.0 * input[2] + 75.0 * input[3] + 64.0 * input[4] + 18.93700290367378 * input[5]) + 0.0, 3.0)).toDouble();
    double var55;
    var55 = (pow(0.00009295334872448127 * (0.0 * input[0] + 55.0 * input[1] + 113.0 * input[2] + 67.0 * input[3] + 68.0 * input[4] + 24.0569347455645 * input[5]) + 0.0, 3.0)).toDouble();
    double var56;
    var56 = (pow(0.00009295334872448127 * (0.0 * input[0] + 51.0 * input[1] + 115.0 * input[2] + 64.0 * input[3] + 103.0 * input[4] + 24.22145328719723 * input[5]) + 0.0, 3.0)).toDouble();
    double var57;
    var57 = (pow(0.00009295334872448127 * (0.0 * input[0] + 67.0 * input[1] + 116.0 * input[2] + 61.0 * input[3] + 80.0 * input[4] + 17.008820853605474 * input[5]) + 0.0, 3.0)).toDouble();
    double var58;
    var58 = (pow(0.00009295334872448127 * (1.0 * input[0] + 50.0 * input[1] + 110.0 * input[2] + 75.0 * input[3] + 78.0 * input[4] + 32.74492829989838 * input[5]) + 0.0, 3.0)).toDouble();
    double var59;
    var59 = (pow(0.00009295334872448127 * (0.0 * input[0] + 62.0 * input[1] + 117.0 * input[2] + 68.0 * input[3] + 55.0 * input[4] + 26.575890590940308 * input[5]) + 0.0, 3.0)).toDouble();
    double var60;
    var60 = (pow(0.00009295334872448127 * (0.0 * input[0] + 68.0 * input[1] + 116.0 * input[2] + 65.0 * input[3] + 70.0 * input[4] + 23.875432525951556 * input[5]) + 0.0, 3.0)).toDouble();
    double var61;
    var61 = (pow(0.00009295334872448127 * (1.0 * input[0] + 48.0 * input[1] + 117.0 * input[2] + 70.0 * input[3] + 75.0 * input[4] + 23.72528616024974 * input[5]) + 0.0, 3.0)).toDouble();
    double var62;
    var62 = (pow(0.00009295334872448127 * (0.0 * input[0] + 82.0 * input[1] + 118.0 * input[2] + 55.0 * input[3] + 82.0 * input[4] + 21.33821063862216 * input[5]) + 0.0, 3.0)).toDouble();
    double var63;
    var63 = (pow(0.00009295334872448127 * (1.0 * input[0] + 64.0 * input[1] + 117.0 * input[2] + 82.0 * input[3] + 69.0 * input[4] + 19.735976492259113 * input[5]) + 0.0, 3.0)).toDouble();
    double var64;
    var64 = (pow(0.00009295334872448127 * (1.0 * input[0] + 69.0 * input[1] + 141.0 * input[2] + 67.0 * input[3] + 61.0 * input[4] + 27.11111111111111 * input[5]) + 0.0, 3.0)).toDouble();
    double var65;
    var65 = (pow(0.00009295334872448127 * (0.0 * input[0] + 52.0 * input[1] + 154.0 * input[2] + 88.0 * input[3] + 80.0 * input[4] + 23.030045351473923 * input[5]) + 0.0, 3.0)).toDouble();
    double var66;
    var66 = (pow(0.00009295334872448127 * (1.0 * input[0] + 52.0 * input[1] + 143.0 * input[2] + 79.0 * input[3] + 74.0 * input[4] + 22.22222222222222 * input[5]) + 0.0, 3.0)).toDouble();
    double var67;
    var67 = (pow(0.00009295334872448127 * (0.0 * input[0] + 56.0 * input[1] + 143.0 * input[2] + 82.0 * input[3] + 60.0 * input[4] + 25.60553633217993 * input[5]) + 0.0, 3.0)).toDouble();
    double var68;
    var68 = (pow(0.00009295334872448127 * (0.0 * input[0] + 75.0 * input[1] + 144.0 * input[2] + 70.0 * input[3] + 72.0 * input[4] + 22.862368541380885 * input[5]) + 0.0, 3.0)).toDouble();
    double var69;
    var69 = (pow(0.00009295334872448127 * (0.0 * input[0] + 56.0 * input[1] + 158.0 * input[2] + 88.0 * input[3] + 58.0 * input[4] + 22.3081499107674 * input[5]) + 0.0, 3.0)).toDouble();
    double var70;
    var70 = (pow(0.00009295334872448127 * (1.0 * input[0] + 65.0 * input[1] + 143.0 * input[2] + 77.0 * input[3] + 63.0 * input[4] + 26.446280991735534 * input[5]) + 0.0, 3.0)).toDouble();
    double var71;
    var71 = (pow(0.00009295334872448127 * (1.0 * input[0] + 85.0 * input[1] + 149.0 * input[2] + 71.0 * input[3] + 67.0 * input[4] + 24.973985431841832 * input[5]) + 0.0, 3.0)).toDouble();
    double var72;
    var72 = (pow(0.00009295334872448127 * (0.0 * input[0] + 61.0 * input[1] + 149.0 * input[2] + 84.0 * input[3] + 98.0 * input[4] + 22.038567493112946 * input[5]) + 0.0, 3.0)).toDouble();
    double var73;
    var73 = (pow(0.00009295334872448127 * (0.0 * input[0] + 54.0 * input[1] + 157.0 * input[2] + 94.0 * input[3] + 76.0 * input[4] + 34.13111342351717 * input[5]) + 0.0, 3.0)).toDouble();
    double var74;
    var74 = (pow(0.00009295334872448127 * (1.0 * input[0] + 61.0 * input[1] + 140.0 * input[2] + 87.0 * input[3] + 64.0 * input[4] + 24.386526444139612 * input[5]) + 0.0, 3.0)).toDouble();
    double var75;
    var75 = (pow(0.00009295334872448127 * (0.0 * input[0] + 76.0 * input[1] + 140.0 * input[2] + 72.0 * input[3] + 70.0 * input[4] + 22.862368541380885 * input[5]) + 0.0, 3.0)).toDouble();
    double var76;
    var76 = (pow(0.00009295334872448127 * (1.0 * input[0] + 81.0 * input[1] + 142.0 * input[2] + 65.0 * input[3] + 71.0 * input[4] + 30.818540433925047 * input[5]) + 0.0, 3.0)).toDouble();
    double var77;
    var77 = (pow(0.00009295334872448127 * (0.0 * input[0] + 71.0 * input[1] + 159.0 * input[2] + 86.0 * input[3] + 62.0 * input[4] + 19.562955254942768 * input[5]) + 0.0, 3.0)).toDouble();
    double var78;
    var78 = (pow(0.00009295334872448127 * (0.0 * input[0] + 80.0 * input[1] + 160.0 * input[2] + 77.0 * input[3] + 59.0 * input[4] + 16.52892561983471 * input[5]) + 0.0, 3.0)).toDouble();
    double var79;
    var79 = (pow(0.00009295334872448127 * (1.0 * input[0] + 69.0 * input[1] + 160.0 * input[2] + 77.0 * input[3] + 88.0 * input[4] + 24.973985431841832 * input[5]) + 0.0, 3.0)).toDouble();
    double var80;
    var80 = (pow(0.00009295334872448127 * (0.0 * input[0] + 78.0 * input[1] + 163.0 * input[2] + 63.0 * input[3] + 64.0 * input[4] + 14.692378328741965 * input[5]) + 0.0, 3.0)).toDouble();
    double var81;
    var81 = (pow(0.00009295334872448127 * (0.0 * input[0] + 51.0 * input[1] + 161.0 * input[2] + 89.0 * input[3] + 72.0 * input[4] + 28.34467120181406 * input[5]) + 0.0, 3.0)).toDouble();
    double var82;
    var82 = (pow(0.00009295334872448127 * (0.0 * input[0] + 54.0 * input[1] + 161.0 * input[2] + 95.0 * input[3] + 78.0 * input[4] + 22.408178985329645 * input[5]) + 0.0, 3.0)).toDouble();
        return [6.861271138708707 + var0 * -0.32169117647058826 + var1 * -0.0 + var2 * -0.32169117647058826 + var3 * -0.0 + var4 * -0.32169117647058826 + var5 * -0.0 + var6 * -0.32169117647058826 + var7 * -0.0 + var8 * -0.0 + var9 * -0.32169117647058826 + var10 * -0.0 + var11 * -0.32169117647058826 + var12 * -0.0 + var13 * -0.32169117647058826 + var14 * -0.32169117647058826 + var15 * -0.32169117647058826 + var16 * -0.32169117647058826 + var17 * -0.0 + var18 * -0.0 + var19 * -0.32169117647058826 + var20 * -0.0 + var21 * -0.32169117647058826 + var22 * -0.0 + var23 * -0.0 + var24 * -0.19636593363204055 + var25 * -0.32169117647058826 + var26 * -0.0 + var27 * -0.32169117647058826 + var28 * -0.32169117647058826 + var29 * -0.0 + var30 * -0.32169117647058826 + var31 * -0.0 + var32 * -0.32169117647058826 + var33 * -0.0 + var34 * -0.32169117647058826 + var35 * -0.32169117647058826 + var36 * -0.32169117647058826 + var37 * -0.0 + var38 * -0.32169117647058826 + var39 * -0.0 + var40 * -0.0 + var41 * 0.341796875 + var42 * 0.1871119448910558 + var43 * 0.341796875 + var44 * 0.341796875 + var45 * 0.341796875 + var46 * 0.341796875 + var47 * 0.341796875 + var48 * 0.341796875 + var49 * 0.019265629774523223 + var50 * 0.341796875 + var51 * 0.341796875 + var52 * 0.11790727496837548 + var53 * 0.341796875 + var54 * 0.341796875 + var55 * 0.341796875 + var56 * 0.13345516488043943 + var57 * 0.341796875 + var58 * 0.341796875 + var59 * 0.341796875 + var60 * 0.341796875 + var61 * 0.341796875 + var62 * 0.341796875 + var63 * 0.341796875, 4.194493552426856 + var64 * -0.6457568303335267 + var65 * -0.0 + var66 * -0.0 + var67 * -0.0 + var68 * -0.0 + var69 * -0.0 + var70 * -0.0 + var71 * -0.0 + var72 * -0.0 + var73 * -0.0 + var74 * -0.0 + var75 * -0.2074258755454374 + var76 * -0.0 + var77 * -0.0 + var41 * 0.0 + var42 * 0.0 + var43 * 0.0 + var44 * 0.0 + var45 * 0.0 + var46 * 0.031097080670938415 + var47 * 0.0 + var48 * 0.0 + var49 * 0.0 + var50 * 0.0 + var51 * 0.341796875 + var52 * 0.0 + var53 * 0.0 + var54 * 0.0 + var55 * 0.0 + var56 * 0.0 + var57 * 0.0 + var58 * 0.0 + var59 * 0.02376569080673008 + var60 * 0.0 + var61 * 0.0 + var62 * 0.11472618440129563 + var63 * 0.341796875, 2.911445457297574 + var78 * -0.04564551423795627 + var79 * -0.0 + var80 * -0.13477283467336368 + var81 * -0.008403573501753863 + var82 * -0.0 + var41 * 0.0 + var42 * 0.0 + var43 * 0.0 + var44 * 0.0 + var45 * 0.0 + var46 * 0.0 + var47 * 0.0 + var48 * 0.0 + var49 * 0.0 + var50 * 0.0 + var51 * 0.18882192241307383 + var52 * 0.0 + var53 * 0.0 + var54 * 0.0 + var55 * 0.0 + var56 * 0.0 + var57 * 0.0 + var58 * 0.0 + var59 * 0.0 + var60 * 0.0 + var61 * 0.0 + var62 * 0.0 + var63 * 0.0, 9.555947094205797 + var64 * -0.8101851851851852 + var65 * -0.0 + var66 * -0.8101851851851852 + var67 * -0.8101851851851852 + var68 * -0.8101851851851852 + var69 * -0.0 + var70 * -0.3401922416691833 + var71 * -0.0 + var72 * -0.0 + var73 * -0.0 + var74 * -0.8101851851851852 + var75 * -0.8101851851851852 + var76 * -0.6888421282193039 + var77 * -0.0 + var0 * 0.0 + var1 * 0.32169117647058826 + var2 * 0.0 + var3 * 0.32169117647058826 + var4 * 0.0 + var5 * 0.32169117647058826 + var6 * 0.0 + var7 * 0.126616883659534 + var8 * 0.32169117647058826 + var9 * 0.0 + var10 * 0.32169117647058826 + var11 * 0.0 + var12 * 0.32169117647058826 + var13 * 0.0 + var14 * 0.0 + var15 * 0.0 + var16 * 0.0 + var17 * 0.32169117647058826 + var18 * 0.32169117647058826 + var19 * 0.0 + var20 * 0.32169117647058826 + var21 * 0.0 + var22 * 0.32169117647058826 + var23 * 0.32169117647058826 + var24 * 0.0 + var25 * 0.0 + var26 * 0.32169117647058826 + var27 * 0.0 + var28 * 0.0 + var29 * 0.32169117647058826 + var30 * 0.0 + var31 * 0.32169117647058826 + var32 * 0.0 + var33 * 0.32169117647058826 + var34 * 0.0 + var35 * 0.0 + var36 * 0.0 + var37 * 0.32169117647058826 + var38 * 0.0 + var39 * 0.29477859734006434 + var40 * 0.32169117647058826, 5.470544353880778 + var78 * -0.039666690294264347 + var79 * -0.11729184636819226 + var80 * -0.22369561474087998 + var81 * -0.2117574959025038 + var82 * -0.0 + var0 * 0.0 + var1 * 0.0 + var2 * 0.0 + var3 * 0.0 + var4 * 0.0 + var5 * 0.0 + var6 * 0.0 + var7 * 0.0 + var8 * 0.0 + var9 * 0.0 + var10 * 0.2330736774850121 + var11 * 0.0 + var12 * 0.0 + var13 * 0.0 + var14 * 0.0 + var15 * 0.0 + var16 * 0.0 + var17 * 0.0 + var18 * 0.037646793350240085 + var19 * 0.0 + var20 * 0.0 + var21 * 0.0 + var22 * 0.0 + var23 * 0.0 + var24 * 0.0 + var25 * 0.0 + var26 * 0.0 + var27 * 0.0 + var28 * 0.0 + var29 * 0.0 + var30 * 0.0 + var31 * 0.0 + var32 * 0.0 + var33 * 0.0 + var34 * 0.0 + var35 * 0.0 + var36 * 0.0 + var37 * 0.0 + var38 * 0.0 + var39 * 0.0 + var40 * 0.32169117647058826, 12.711063766846925 + var78 * -1.251081627883661 + var79 * -0.36446723213619214 + var80 * -0.02418399980884256 + var81 * -1.3671875 + var82 * -1.177615978185824 + var64 * 0.0 + var65 * 0.8101851851851852 + var66 * 0.0 + var67 * 0.0 + var68 * 0.0 + var69 * 0.8101851851851852 + var70 * 0.0 + var71 * 0.43267429924310485 + var72 * 0.511121298030674 + var73 * 0.8101851851851852 + var74 * 0.0 + var75 * 0.0 + var76 * 0.0 + var77 * 0.8101851851851852];
}

class HypertensionSvcModel {
    static const int _numClasses = 4;

    static int predict(List<double> features) {
        final scores = score(features);
        final votes = List<int>.filled(_numClasses, 0);

        var idx = 0;
        for (var i = 0; i < _numClasses; i++) {
            for (var j = i + 1; j < _numClasses; j++) {
                if (scores[idx] > 0) {
                    votes[i] += 1;
                } else {
                    votes[j] += 1;
                }
                idx += 1;
            }
        }

        var bestClass = 0;
        for (var i = 1; i < votes.length; i++) {
            if (votes[i] > votes[bestClass]) {
                bestClass = i;
            }
        }
        return bestClass;
    }

    static List<double> predictProbabilities(List<double> features) {
        final scores = score(features);
        final votes = List<int>.filled(_numClasses, 0);

        var idx = 0;
        for (var i = 0; i < _numClasses; i++) {
            for (var j = i + 1; j < _numClasses; j++) {
                if (scores[idx] > 0) {
                    votes[i] += 1;
                } else {
                    votes[j] += 1;
                }
                idx += 1;
            }
        }

        final totalVotes = votes.fold<int>(0, (sum, v) => sum + v);
        if (totalVotes == 0) {
            return List<double>.filled(_numClasses, 1.0 / _numClasses);
        }

        return votes
                .map((v) => v / totalVotes)
                .toList(growable: false);
    }
}

```

`lib\data\services\notification_service.dart`:

```dart
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_oracle/data/services/theme_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../../l10n/app_localizations.dart';
import '../models/reminder.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('ic_stat_notification');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings);
    _initialized = true;
  }

  static Future<bool> requestPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    bool granted = false;

    if (android != null) {
      final result = await android.requestNotificationsPermission();
      granted = result ?? false;
    }

    if (ios != null) {
      final result = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      granted = result ?? false;
    }

    return granted;
  }

  static Future<bool> hasPermissions() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      final result = await android.areNotificationsEnabled();
      return result ?? false;
    }
    
    return true;
  }

  static AppLocalizations get _l10n {
    final locale = PlatformDispatcher.instance.locale;
    return lookupAppLocalizations(locale);
  }

  static String _getCategoryName(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return _l10n.notificationCategoryPressure;
      case ReminderCategory.pulse:
        return _l10n.notificationCategoryPulse;
      case ReminderCategory.weight:
        return _l10n.notificationCategoryWeight;
      case ReminderCategory.sugar:
        return _l10n.notificationCategorySugar;
      case ReminderCategory.other:
        return _l10n.notificationCategoryOther;
    }
  }

  static Future<void> scheduleReminder(Reminder reminder) async {
    if (!reminder.isActive) return;

    if (!ThemeService.instance.notificationsEnabled) {
    return;
    }

    final notificationId = reminder.id.hashCode;
    final categoryName = _getCategoryName(reminder.category);
    final categoryLabel = _l10n.notificationCategoryLabel;
    final body = reminder.description?.isNotEmpty == true
        ? '${reminder.description}\n$categoryLabel: $categoryName'
        : '$categoryLabel: $categoryName';

    final androidDetails = AndroidNotificationDetails(
      'reminders',
      'Напоминания',
      channelDescription: 'Напоминания о измерениях',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'ic_stat_notification',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    DateTimeComponents? matchComponents;
    switch (reminder.repeatType) {
      case RepeatType.daily:
        matchComponents = DateTimeComponents.time;
        break;
      case RepeatType.weekly:
        matchComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
      case RepeatType.monthly:
        matchComponents = DateTimeComponents.dayOfMonthAndTime;
        break;
      case RepeatType.weekdays:
        matchComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
    }

    await _plugin.zonedSchedule(
      notificationId,
      reminder.title,
      body,
      tzScheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: matchComponents,
    );
  }

  static Future<void> cancelReminder(Reminder reminder) async {
    final notificationId = reminder.id.hashCode;
    await _plugin.cancel(notificationId);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static Future<void> rescheduleAllReminders(List<Reminder> reminders) async {
    await cancelAll();
    for (final reminder in reminders) {
      if (reminder.isActive) {
        await scheduleReminder(reminder);
      }
    }
  }
}

```

`lib\data\services\prediction_service.dart`:

```dart
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
```

`lib\data\services\profile_service.dart`:

```dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';


class ProfileService {
  static const String _boxName = 'user_profile';
  static const String _profileKey = 'profile';

  static Box<UserProfile>? _box;

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }

    _box = await Hive.openBox<UserProfile>(_boxName);
  }

  static UserProfile? getProfile() {
    return _box?.get(_profileKey);
  }

  static Future<void> saveProfile(UserProfile profile) async {
    await _box?.put(_profileKey, profile);
  }

  static bool hasProfile() {
    return _box?.containsKey(_profileKey) ?? false;
  }

  static Future<void> deleteProfile() async {
    await _box?.delete(_profileKey);
  }

  static Stream<BoxEvent>? watchProfile() {
    return _box?.watch(key: _profileKey);
  }
}

```

`lib\data\services\random_forest_model.dart`:

```dart
import 'dart:convert';
import 'package:flutter/services.dart';

/// Универсальный интерпретатор RandomForest, загружаемого из JSON.
class RandomForestModel {
  final String id;
  final int nClasses;
  final int nFeatures;
  final List<String> featureNames;
  final List<String> classNames;
  final List<_DecisionTree> _trees;
  final List<double>? _imputerStats;
  final List<int>? _indicatorFeatures;

  RandomForestModel._({
    required this.id,
    required this.nClasses,
    required this.nFeatures,
    required this.featureNames,
    required this.classNames,
    required List<_DecisionTree> trees,
    List<double>? imputerStats,
    List<int>? indicatorFeatures,
  })  : _trees = trees,
        _imputerStats = imputerStats,
        _indicatorFeatures = indicatorFeatures;

  /// Загружает модель из JSON-ассета.
  static Future<RandomForestModel> load(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;

    final treesJson = json['trees'] as List;
    final trees = treesJson.map((t) => _DecisionTree.fromJson(t)).toList();

    List<double>? impStats;
    List<int>? indFeats;
    if (json.containsKey('imputer')) {
      final imp = json['imputer'] as Map<String, dynamic>;
      impStats = (imp['statistics'] as List).map((e) => (e as num).toDouble()).toList();
      if (imp.containsKey('indicator_features')) {
        indFeats = (imp['indicator_features'] as List).map((e) => (e as num).toInt()).toList();
      }
    }

    return RandomForestModel._(
      id: json['id'] as String,
      nClasses: json['n_classes'] as int,
      nFeatures: json['n_features'] as int,
      featureNames: (json['feature_names'] as List).cast<String>(),
      classNames: (json['class_names'] as List).cast<String>(),
      trees: trees,
      imputerStats: impStats,
      indicatorFeatures: indFeats,
    );
  }

  /// Предсказание класса. Возвращает индекс класса (sklearn-like: argmax(mean_proba)).
  int predict(List<double> features) {
    final probs = predictProbabilities(features);
    if (probs.isEmpty) return 0;

    var bestIdx = 0;
    var best = probs[0];
    for (var i = 1; i < probs.length; i++) {
      if (probs[i] > best) {
        best = probs[i];
        bestIdx = i;
      }
    }
    return bestIdx;
  }

  /// Вероятности по классам (mean of per-tree leaf probabilities).
  List<double> predictProbabilities(List<double> features) {
    final processed = _preprocess(features);
    final votes = List<double>.filled(nClasses, 0);

    for (final tree in _trees) {
      final p = tree.predictProba(processed); // already sums to 1
      for (int i = 0; i < nClasses; i++) {
        votes[i] += p[i];
      }
    }

    if (_trees.isNotEmpty) {
      for (int i = 0; i < votes.length; i++) {
        votes[i] /= _trees.length;
      }
    }
    return votes;
  }

  /// Предобработка: Imputer (замена NaN медианой + индикаторы).
  List<double> _preprocess(List<double> features) {
    if (_imputerStats == null) return features;

    final result = List<double>.from(features);

    // Заменяем NaN на медиану
    for (int i = 0; i < result.length && i < _imputerStats.length; i++) {
      if (result[i].isNaN) {
        result[i] = _imputerStats[i];
      }
    }

    // Добавляем индикаторные признаки (1 = было NaN)
    if (_indicatorFeatures != null) {
      for (final idx in _indicatorFeatures) {
        result.add(idx < features.length && features[idx].isNaN ? 1.0 : 0.0);
      }
    }

    return result;
  }
}

/// Одно дерево решений из ансамбля.
class _DecisionTree {
  final List<int> feature;
  final List<double> threshold;
  final List<int> childrenLeft;
  final List<int> childrenRight;
  final List<List<double>> value; // <-- was int

  _DecisionTree({
    required this.feature,
    required this.threshold,
    required this.childrenLeft,
    required this.childrenRight,
    required this.value,
  });

  factory _DecisionTree.fromJson(Map<String, dynamic> json) {
    return _DecisionTree(
      feature: (json['feature'] as List).cast<int>(),
      threshold: (json['threshold'] as List).map((e) => (e as num).toDouble()).toList(),
      childrenLeft: (json['children_left'] as List).cast<int>(),
      childrenRight: (json['children_right'] as List).cast<int>(),
      value: (json['value'] as List).map((row) {
        // row is List<num> in JSON (old versions may be int-only)
        return (row as List).map((v) => (v as num).toDouble()).toList();
      }).toList(),
    );
  }

  /// Возвращает вероятности по классам для данного вектора признаков (leaf distribution normalized).
  List<double> predictProba(List<double> features) {
    int nodeId = 0;
    while (childrenLeft[nodeId] != -1) {
      final f = feature[nodeId];
      if (f < 0 || f >= features.length) break;
      if (features[f] <= threshold[nodeId]) {
        nodeId = childrenLeft[nodeId];
      } else {
        nodeId = childrenRight[nodeId];
      }
    }

    final counts = value[nodeId];
    final total = counts.fold<double>(0, (a, b) => a + b);
    if (total <= 0) return List<double>.filled(counts.length, 0);

    return counts.map((c) => c / total).toList();
  }
}

```

`lib\data\services\reminder_service.dart`:

```dart
import 'package:hive_flutter/hive_flutter.dart';
import '../models/reminder.dart';

class ReminderService {
  static const String _boxName = 'reminders';
  static Box<Reminder>? _box;

  static Future<void> init() async {
    Hive.registerAdapter(ReminderAdapter());
    Hive.registerAdapter(RepeatTypeAdapter());
    Hive.registerAdapter(ReminderCategoryAdapter());
    _box = await Hive.openBox<Reminder>(_boxName);
  }

  static Box<Reminder> get box {
    if (_box == null) {
      throw Exception('ReminderService not initialized. Call init() first.');
    }
    return _box!;
  }

  static Future<Reminder> add({
    required String title,
    String? description,
    required int hour,
    required int minute,
    required RepeatType repeatType,
    required ReminderCategory category,
    bool isActive = true,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final reminder = Reminder(
      id: id,
      title: title,
      description: description,
      hour: hour,
      minute: minute,
      repeatType: repeatType,
      category: category,
      isActive: isActive,
      createdAt: DateTime.now(),
    );
    await box.put(id, reminder);
    return reminder;
  }

  static Future<void> update(Reminder reminder) async {
    await reminder.save();
  }

  static Future<void> delete(String id) async {
    await box.delete(id);
  }

  static Future<void> deleteAll() async {
    await box.clear();
  }

  static Future<void> toggleActive(String id) async {
    final reminder = box.get(id);
    if (reminder != null) {
      reminder.isActive = !reminder.isActive;
      await reminder.save();
    }
  }

  static List<Reminder> getAll() {
    return box.values.toList();
  }

  static List<Reminder> getActive() {
    return box.values.where((r) => r.isActive).toList();
  }

  static List<Reminder> getInactive() {
    return box.values.where((r) => !r.isActive).toList();
  }

  static Reminder? getById(String id) {
    return box.get(id);
  }

  static int get activeCount => getActive().length;

  static int get totalCount => box.length;
}

```

`lib\data\services\theme_service.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Режим темы
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Сервис для хранения и управления темой.
class ThemeService extends ValueNotifier<AppThemeMode> {
  static const String _boxName = 'settings';
  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';

  static Box? _box;
  static ThemeService? _instance;

  ThemeService._(AppThemeMode mode) : super(mode);

  /// Единственный экземпляр
  static ThemeService get instance {
    _instance ??= ThemeService._(AppThemeMode.system);
    return _instance!;
  }

  /// Инициализация: открывает Hive-бокс и загружает тему.
  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    final saved = _box?.get(_themeKey, defaultValue: 'system') as String;
    final mode = AppThemeMode.values.firstWhere(
      (e) => e.name == saved,
      orElse: () => AppThemeMode.system,
    );
    _instance = ThemeService._(mode);
  }

  /// Текущий режим
  AppThemeMode get mode => value;

  /// Меняет тему и сохраняет в Hive.
  Future<void> setMode(AppThemeMode mode) async {
    value = mode;
    await _box?.put(_themeKey, mode.name);
  }

  /// Flutter ThemeMode для MaterialApp.
  ThemeMode get themeMode {
    switch (value) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Человекочитаемое название (для UI).
  String label(AppThemeMode m) {
    switch (m) {
      case AppThemeMode.light:
        return 'Светлая';
      case AppThemeMode.dark:
        return 'Тёмная';
      case AppThemeMode.system:
        return 'Системная';
    }
  }

   bool get notificationsEnabled {
    return _box?.get(_notificationsKey, defaultValue: true) as bool? ?? true;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _box?.put(_notificationsKey, enabled);
  }
}

```

`lib\features\analysis\presentation\pages\analysis_kidney_page.dart`:

```dart
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

```

`lib\features\analysis\presentation\pages\analysis_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import 'analysis_pressure_page.dart';
import 'analysis_kidney_page.dart';

enum _AnalysisCategory { pressure, kidney }

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  _AnalysisCategory _selectedCategory = _AnalysisCategory.pressure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient header
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        context.l10n.analysisTitle,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surface(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceVariant(context),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                _buildTab(
                                  context,
                                  _AnalysisCategory.pressure,
                                  'Давление',
                                  Icons.favorite_rounded,
                                ),
                                _buildTab(
                                  context,
                                  _AnalysisCategory.kidney,
                                  'Почки',
                                  Icons.water_drop_rounded,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                            child: _selectedCategory == _AnalysisCategory.pressure
                                ? const AnalysisPressurePage(key: ValueKey('pressure'))
                                : const AnalysisKidneyPage(key: ValueKey('kidney')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    _AnalysisCategory category,
    String label,
    IconData icon,
  ) {
    final isSelected = _selectedCategory == category;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.surface(context) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected && Theme.of(context).brightness == Brightness.dark
                ? Border.all(color: AppTheme.border(context), width: 0.5)
                : null,
            boxShadow: isSelected && Theme.of(context).brightness == Brightness.light
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 16,
                    color: isSelected
                        ? AppTheme.textPrimary(context)
                        : AppTheme.textSecondary(context),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyles.bodyMedium.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? AppTheme.textPrimary(context)
                          : AppTheme.textSecondary(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2.5,
                width: isSelected ? 26 : 0,
                decoration: BoxDecoration(
                  color: AppColors.actionPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

`lib\features\analysis\presentation\pages\analysis_pressure_page.dart`:

```dart
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
             
            ],
          ],
        ),
      ),
    );
  }

  

  Widget _buildHypertensionCard(BuildContext context, HypertensionResult result) {
    final bool isHypotension = result.isHypotension;
    final String title = isHypotension ? 'Риск гипотензии' : context.l10n.analysisHypertension;
    final IconData icon = isHypotension ? Icons.arrow_downward_rounded : Icons.favorite_rounded;
    final Color severityColor = isHypotension ? AppColors.error500 : _severityColor(result.severity);
    final Color severityBgColor = isHypotension
        ? AppColors.error500.withOpacity(0.1)
        : _severityBgColor(result.severity);
    final double confidence = isHypotension ? 1.0 : result.confidence;

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
                child: Icon(icon, color: severityColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
          if (!isHypotension) ...[
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
                  '${(confidence * 100).toStringAsFixed(0)}%',
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
                value: confidence,
                minHeight: 8,
                backgroundColor: AppTheme.border(context),
                color: severityColor,
              ),
            ),
          ],
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
    // Если гипотензия – блок вероятностей не показываем
    if (result.isHypotension) {
      return const SizedBox.shrink();
    }

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
        return AppColors.success500.withOpacity(0.1);
      case 1:
        return AppColors.warning500.withOpacity(0.1);
      case 2:
        return const Color(0xFFFF8C00).withOpacity(0.1);
      case 3:
        return AppColors.error500.withOpacity(0.1);
      default:
        return AppTheme.border(context);
    }
  }
}
```

`lib\features\history\presentation\pages\export_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:csv/csv.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../data/data.dart';
import '../widgets/export_section.dart';
import '../widgets/export_selector_row.dart';

enum ExportFormat { pdf, csv }

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  DateTimeRange? _dateRange;
  ExportFormat _format = ExportFormat.pdf;
  Set<EntryType> _selectedTypes = {}; // пусто = все
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateRange = DateTimeRange(
      start: now.subtract(const Duration(days: 30)),
      end: now,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '—';
    return DateFormat('dd.MM.yyyy').format(date);
  }

  String _getDateRangeText() {
    if (_dateRange == null) return 'Выберите диапазон';
    return '${_formatDate(_dateRange!.start)} — ${_formatDate(_dateRange!.end)}';
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _selectFormat() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ExportFormat.values.map((format) {
            final isSelected = _format == format;
            return ListTile(
              title: Text(format == ExportFormat.pdf ? 'PDF отчёт' : 'CSV таблица'),
              trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _format = format);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDetailText() {
    if (_selectedTypes.isEmpty) return 'Все измерения';
    final names = _selectedTypes.map((type) {
      switch (type) {
        case EntryType.pressure:
          return 'Давление';
        case EntryType.pulse:
          return 'Пульс';
        case EntryType.weight:
          return 'Вес';
        case EntryType.sugar:
          return 'Сахар';
      }
    }).toList();
    return names.join(', ');
  }

  void _selectDetails() {
    // Временная копия для редактирования
    Set<EntryType> tempSelected = Set.from(_selectedTypes);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.divider(context),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Выберите категории',
                      style: TextStyles.titleMedium.copyWith(
                        fontSize: 18,
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Опция "Все"
                    CheckboxListTile(
                      value: tempSelected.isEmpty,
                      onChanged: (value) {
                        setStateModal(() {
                          if (value == true) {
                            tempSelected.clear();
                          } else {
                            // Если снимаем "Все", то выбираем все категории
                            tempSelected = {
                              EntryType.pressure,
                              EntryType.pulse,
                              EntryType.weight,
                              EntryType.sugar,
                            };
                          }
                        });
                      },
                      title: const Text('Все измерения'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                    ),
                    const Divider(),
                    // Список категорий
                    ...EntryType.values.map((type) {
                      final label = _typeName(type);
                      return CheckboxListTile(
                        value: tempSelected.contains(type),
                        onChanged: (value) {
                          setStateModal(() {
                            if (value == true) {
                              tempSelected.add(type);
                            } else {
                              tempSelected.remove(type);
                            }
                          });
                        },
                        title: Text(label),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: AppColors.primary,
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Отмена'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Применяем выбор
                              setState(() {
                                _selectedTypes = tempSelected;
                              });
                              Navigator.pop(ctx);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Применить'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _typeName(EntryType type) {
    switch (type) {
      case EntryType.pressure:
        return 'Давление';
      case EntryType.pulse:
        return 'Пульс';
      case EntryType.weight:
        return 'Вес';
      case EntryType.sugar:
        return 'Сахар';
    }
  }

  // === Запрос разрешений с учётом версии Android ===
  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt >= 30) {
      var status = await Permission.manageExternalStorage.status;
      if (status.isGranted) return true;

      status = await Permission.manageExternalStorage.request();
      if (status.isGranted) return true;

      if (status.isPermanentlyDenied) {
        if (mounted) {
          final openSettings = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Требуется разрешение'),
              content: const Text(
                'Для сохранения файлов в папку Downloads необходимо разрешение '
                'на управление всеми файлами. Пожалуйста, включите его в настройках.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Открыть настройки'),
                ),
              ],
            ),
          );
          if (openSettings == true) {
            await openAppSettings();
          }
        }
        return false;
      }
      return false;
    }

    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // === Получение папки Downloads ===
  Future<Directory?> _getDownloadsDirectory() async {
    if (!Platform.isAndroid) {
      return await getDownloadsDirectory();
    }

    final paths = [
      '/storage/emulated/0/Download',
      '/sdcard/Download',
    ];

    for (final path in paths) {
      final dir = Directory(path);
      if (await dir.exists()) {
        return dir;
      }
    }

    final externalDir = await getExternalStorageDirectory();
    if (externalDir != null) {
      final downloadsPath = '${externalDir.path.split('/Android').first}/Download';
      final downloadsDir = Directory(downloadsPath);
      if (await downloadsDir.exists()) {
        return downloadsDir;
      }
    }

    return null;
  }

  // === Генерация CSV ===
  Future<File> _generateCsv(List<HealthEntry> entries, Directory dir) async {
    final rows = <List<String>>[];
    rows.add(['Дата', 'Время', 'Тип', 'Значение', 'Примечание']);

    for (final entry in entries) {
      final date = DateFormat('dd.MM.yyyy').format(entry.createdAt);
      final time = DateFormat('HH:mm').format(entry.createdAt);
      final typeName = entry.typeName(context);
      final value = entry.displayValue;
      final note = entry.note ?? '';
      rows.add([date, time, typeName, value, note]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final filename = 'health_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
    final file = File('${dir.path}/$filename');
    await file.writeAsString(csv, flush: true);
    return file;
  }

  // === Генерация PDF с поддержкой кириллицы ===
  Future<File> _generatePdf(List<HealthEntry> entries, Directory dir) async {
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final font = pw.Font.ttf(fontData);
    final theme = pw.ThemeData.withFont(base: font);

    final pdf = pw.Document(theme: theme);

    final headers = ['Дата', 'Время', 'Тип', 'Значение', 'Примечание'];
    final rows = <List<String>>[];
    for (final entry in entries) {
      final date = DateFormat('dd.MM.yyyy').format(entry.createdAt);
      final time = DateFormat('HH:mm').format(entry.createdAt);
      final typeName = entry.typeName(context);
      final value = entry.displayValue;
      final note = entry.note ?? '';
      rows.add([date, time, typeName, value, note]);
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Text(
                'Экспорт данных Health Oracle',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  fontFallback: [font],
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Период: ${_formatDate(_dateRange?.start)} — ${_formatDate(_dateRange?.end)}',
              style: pw.TextStyle(fontSize: 14, fontFallback: [font]),
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: headers,
              data: rows,
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontFallback: [font],
              ),
              headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30,
              cellAlignment: pw.Alignment.centerLeft,
              cellStyle: pw.TextStyle(fontFallback: [font]),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Сгенерировано: ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())}',
              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, fontFallback: [font]),
            ),
          ];
        },
      ),
    );

    final filename = 'health_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  // === Основная функция экспорта ===
  Future<void> _export() async {
    if (_dateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите диапазон дат')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        setState(() => _isLoading = false);
        return;
      }

      final allEntries = EntryService.getByDateRange(
        _dateRange!.start,
        _dateRange!.end,
      );

      // Фильтрация по выбранным типам
      List<HealthEntry> filteredEntries;
      if (_selectedTypes.isEmpty) {
        filteredEntries = allEntries;
      } else {
        filteredEntries = allEntries.where((e) => _selectedTypes.contains(e.type)).toList();
      }

      if (filteredEntries.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Нет данных за выбранный период с такой детализацией')),
          );
        }
        setState(() => _isLoading = false);
        return;
      }

      final dir = await _getDownloadsDirectory();
      if (dir == null) {
        throw Exception('Не удалось получить доступ к папке Downloads');
      }

      File file;
      if (_format == ExportFormat.csv) {
        file = await _generateCsv(filteredEntries, dir);
      } else {
        file = await _generatePdf(filteredEntries, dir);
      }

      if (await file.exists()) {
        if (mounted) {
          final customSnackBar = SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('✅ Сохранено в Загрузки'),
                      Text(
                        file.path.split('/').last,
                        style: const TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Share.shareXFiles([XFile(file.path)]);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const Text('Поделиться'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        OpenFile.open(file.path);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.white),
                      child: const Text('Открыть'),
                    ),
                  ],
                ),
              ],
            ),
            duration: const Duration(seconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(customSnackBar);
        }
      } else {
        throw Exception('Файл не был создан');
      }
    } catch (e) {
      print('❌ Export error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка экспорта: $e'),
            backgroundColor: AppColors.error500,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Экспорт истории',
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surface(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExportSection(
                              title: 'Диапазон дат',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.calendar_today_outlined,
                                    label: 'Диапазон',
                                    value: _getDateRangeText(),
                                    onTap: _selectDateRange,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            ExportSection(
                              title: 'Формат и содержимое',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.description_outlined,
                                    label: 'Формат файла',
                                    value: _format == ExportFormat.pdf ? 'PDF отчёт' : 'CSV таблица',
                                    onTap: _selectFormat,
                                  ),
                                  const SizedBox(height: 8),
                                  ExportSelectorRow(
                                    icon: Icons.list_alt_outlined,
                                    label: 'Детализация',
                                    value: _getDetailText(),
                                    onTap: _selectDetails,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.neutral700,
                                      side: BorderSide(color: AppTheme.border(context)),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text('Отмена'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: AppColors.purpleGradient,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _export,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              'Экспортировать',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

`lib\features\history\presentation\pages\history_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/history_list_panel.dart';
import 'export_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'История',
                            style: TextStyles.headlineLarge.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ваши измерения',
                            style: TextStyles.bodyMedium.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ExportPage(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Экспорт',
                                    style: TextStyles.bodyMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // White Sheet
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                        child: HistoryListPanel(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



```

`lib\features\history\presentation\widgets\date_selector.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primary,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surface(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today_rounded, size: 16, color: AppTheme.textSecondary(context)),
            const SizedBox(width: 8),
            Text(
              _formatDate(_selectedDate),
              style: TextStyles.bodyMedium.copyWith(
                color: AppColors.neutral800,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppTheme.textSecondary(context)),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Сегодня';
    }
    return '${date.day}.${date.month}.${date.year}';
  }
}

```

`lib\features\history\presentation\widgets\export_button.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ExportButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const leadingColor = AppColors.primary;
    final Color gradientEnd = Color.lerp(leadingColor, Colors.black, 0.45) ?? leadingColor;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppTheme.surface(context),
        elevation: 2,
        shadowColor: AppTheme.cardShadow(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: AppTheme.border(context)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [leadingColor, gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.download, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Экспорт данных',
                    style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios, color: AppTheme.textSecondary(context), size: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

`lib\features\history\presentation\widgets\export_section.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ExportSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ExportSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.titleMedium.copyWith(
            fontSize: 16,
            color: AppColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 6)),
          child: child,
        ),
      ],
    );
  }
}

```

`lib\features\history\presentation\widgets\export_selector_row.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ExportSelectorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap; 

  const ExportSelectorRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      color: AppTheme.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textPrimary(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppTheme.textHint(context)),
          ],
        ),
      ),
    );
  }
}
```

`lib\features\history\presentation\widgets\history_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';

enum MetricType {
  pressure,
  pulse,
  weight,
  sugar,
}

class HistoryCard extends StatelessWidget {
  final MetricType type;
  final String value;
  final String unit;
  final DateTime date;
  final String? secondaryValue;
  final String? secondaryUnit;
  final String? status;
  final Color? statusColor;
  final VoidCallback? onDelete;

  const HistoryCard({
    super.key,
    required this.type,
    required this.value,
    required this.unit,
    required this.date,
    this.secondaryValue,
    this.secondaryUnit,
    this.status,
    this.statusColor,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final metricInfo = _getMetricInfo(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context, shadowAlpha: 0.1, blurRadius: 8, shadowOffset: const Offset(0, 4)),
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (onDelete != null)
            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.error500.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: AppColors.error500,
                  ),
                ),
              ),
            ),
          Row(
            children: [
             Container(
  width: 48,
  height: 48,
  decoration: BoxDecoration(
    color: (statusColor ?? metricInfo.color).withOpacity(0.25),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: (statusColor ?? metricInfo.color).withOpacity(0.15),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Icon(
    metricInfo.icon,
    size: 28,
    color: statusColor ?? metricInfo.color,
  ),
),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metricInfo.name,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textSecondary(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          value,
                          style: TextStyles.headlineLarge.copyWith(
                            color: AppTheme.textPrimary(context),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyles.labelSmall.copyWith(
                            color: AppTheme.textHint(context),
                          ),
                        ),
                        const Spacer(),
                        if (secondaryValue != null)
                          _buildSecondaryValue(context)
                        else if (status != null)
                          _buildStatusChip(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              _formatTime(date),
              style: TextStyles.bodyMedium.copyWith(
                color: AppColors.neutral700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (statusColor ?? AppColors.primary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status!,
        style: TextStyles.labelSmall.copyWith(
          color: statusColor ?? AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _MetricInfo _getMetricInfo(BuildContext context) {
    switch (type) {
      case MetricType.pressure:
        return _MetricInfo(context.l10n.metricPressure, Icons.favorite_border, const Color(0xFF764ba2));
      case MetricType.pulse:
        return _MetricInfo(context.l10n.metricPulse, Icons.monitor_heart_outlined, const Color(0xFFEF4444));
      case MetricType.weight:
        return _MetricInfo(context.l10n.metricWeight, Icons.monitor_weight_outlined, const Color(0xFF3B82F6));
      case MetricType.sugar:
        return _MetricInfo(context.l10n.metricSugar, Icons.water_drop_outlined, const Color(0xFFEAB308));
    }
  }



  Widget _buildSecondaryValue(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            type == MetricType.pressure ? Icons.favorite : Icons.show_chart,
            size: 12,
            color: AppTheme.textSecondary(context),
          ),
          const SizedBox(width: 4),
          Text(
            '$secondaryValue ${secondaryUnit ?? ''}',
            style: TextStyles.labelSmall.copyWith(
              color: AppTheme.textSecondary(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

class _MetricInfo {
  final String name;
  final IconData icon;
  final Color color;

  _MetricInfo(this.name, this.icon, this.color);
}

```

`lib\features\history\presentation\widgets\history_filters.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class HistoryFilters extends StatefulWidget {
  final Function(String) onFilterChanged;

  const HistoryFilters({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<HistoryFilters> createState() => _HistoryFiltersState();
}

class _HistoryFiltersState extends State<HistoryFilters> {
  final Set<String> _selectedFilters = {};

  final Map<String, IconData> _filters = {
    'Давление': Icons.favorite_border,
    'Пульс': Icons.monitor_heart_outlined,
    'Вес': Icons.monitor_weight_outlined,
    'Сахар': Icons.water_drop_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 3.5,
      children: _filters.entries.map((entry) {
        final filter = entry.key;
        final icon = entry.value;
        final isSelected = _selectedFilters.contains(filter);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedFilters.remove(filter);
                } else {
                  _selectedFilters.add(filter);
                }
              });
              widget.onFilterChanged(_selectedFilters.join(','));
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppTheme.surface(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppTheme.border(context),
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 18,
                    color: isSelected ? Colors.white : AppTheme.textSecondary(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    filter,
                    style: TextStyles.bodyMedium.copyWith(
                      color: isSelected ? Colors.white : AppTheme.textSecondary(context),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

```

`lib\features\history\presentation\widgets\history_header.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'История',
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Все ваши измерения',
              style: TextStyles.titleMedium.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\history\presentation\widgets\history_list_panel.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import 'history_filters.dart';
import 'history_card.dart';

class HistoryListPanel extends StatefulWidget {
  const HistoryListPanel({super.key});

  @override
  State<HistoryListPanel> createState() => _HistoryListPanelState();
}

class _HistoryListPanelState extends State<HistoryListPanel> {
  List<HealthEntry> _entries = [];
  Set<MetricType> _selectedTypes = {};

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    final entries = EntryService.getAll();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    setState(() {
      _entries = entries;
    });
  }

  List<HealthEntry> get _filteredEntries {
    if (_selectedTypes.isEmpty) return _entries;
    
    return _entries.where((entry) {
      return _selectedTypes.contains(_entryTypeToMetricType(entry.type));
    }).toList();
  }

  MetricType _entryTypeToMetricType(EntryType type) {
    switch (type) {
      case EntryType.pressure:
        return MetricType.pressure;
      case EntryType.pulse:
        return MetricType.pulse;
      case EntryType.weight:
        return MetricType.weight;
      case EntryType.sugar:
        return MetricType.sugar;
    }
  }

  void _handleFilterChange(String filterString) {
    final newSelectedTypes = <MetricType>{};
    if (filterString.isNotEmpty) {
      final filters = filterString.split(',');
      for (final filter in filters) {
        switch (filter) {
          case 'Давление':
            newSelectedTypes.add(MetricType.pressure);
            break;
          case 'Пульс':
            newSelectedTypes.add(MetricType.pulse);
            break;
          case 'Вес':
            newSelectedTypes.add(MetricType.weight);
            break;
          case 'Сахар':
            newSelectedTypes.add(MetricType.sugar);
            break;
        }
      }
    }
    
    setState(() {
      _selectedTypes = newSelectedTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredEntries;

    if (filteredList.isEmpty) {
      return Column(
        children: [
          HistoryFilters(
            onFilterChanged: _handleFilterChange,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: AppTheme.textHint(context),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.historyNoRecords,
                    style: TextStyles.titleMedium.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.historyAddFirst,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        HistoryFilters(
          onFilterChanged: _handleFilterChange,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final entry = filteredList[index];
              final showHeader = index == 0 || !_isSameDay(filteredList[index - 1].createdAt, entry.createdAt);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) _buildDateHeader(entry.createdAt),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: HistoryCard(
                      type: _entryTypeToMetricType(entry.type),
                      value: entry.displayValue,
                      unit: entry.unit(context),
                      date: entry.createdAt,
                      onDelete: () => _showDeleteConfirmation(context, entry),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, HealthEntry entry) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.deleteEntry),
        content: Text('${entry.typeName(context)}: ${entry.displayValue} ${entry.unit(context)}'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: AppTheme.textSecondary(context)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l10n.delete,
              style: TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      await EntryService.delete(entry.id);
      _loadEntries();
    }
  }

  Widget _buildDateHeader(DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDateHeader(date),
            style: TextStyles.titleMedium.copyWith(
              color: AppColors.neutral800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0 && date.day == now.day) {
      return context.l10n.today;
    } else if (diff.inDays <= 1 && date.day == now.subtract(const Duration(days: 1)).day) {
      return context.l10n.yesterday;
    }
    
    return '${date.day}.${date.month}.${date.year}';
  }
}

```

`lib\features\history\presentation\widgets\widgets.dart`:

```dart
export 'history_list_panel.dart';
export 'export_section.dart';
export 'export_selector_row.dart';

```

`lib\features\home\presentation\pages\home_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../widgets/background_gradient.dart';
import '../widgets/header_content.dart';
import '../widgets/metrics_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final headerHeight = screenHeight * 1;
        final panelTop = headerHeight * 0.2;

        return Stack(
          children: [
            BackgroundGradient(height: headerHeight),
            HeaderContent(),
            MetricsPanel(top: panelTop),
          ],
        );
      },
    );
  }
}

```

`lib\features\home\presentation\widgets\add_entry_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_entry_menu.dart';

class AddEntryPage extends StatelessWidget {
  const AddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedNotifier = ValueNotifier<Set<String>>({});

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => BottomEntryMenu(
        selectedNotifier: selectedNotifier,
      ),
    );
  }
}

```

`lib\features\home\presentation\widgets\add_record_button.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/strings.dart';

class AddRecordButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData leadingIcon;

  const AddRecordButton({
    super.key,
    this.onPressed,
    this.label = Strings.addEntryTitle,
    this.leadingIcon = Icons.add_to_photos,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.greenGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withOpacity(0.3),
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
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                leadingIcon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\home\presentation\widgets\background_gradient.dart`:

```dart
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final double height;

  const BackgroundGradient({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(gradient: _getTimeBasedGradient()),
    );
  }

  Gradient _getTimeBasedGradient() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      return const LinearGradient(
        colors: [Color(0xFFFF0061), Color(0xFFFEC194)],
        stops: [0, 0.25],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 12 && hour < 16) {
      return const LinearGradient(
        colors: [Color(0xFF4418b8), Color(0xFF00c0ff)],
        stops: [0, 0.25],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (hour >= 16 && hour < 20) {
      return const LinearGradient(
        stops: [0, 0.25],
        colors: [Color(0xFFff2525), Color(0xFFffe53b)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return const LinearGradient(
        stops: [0, 0.25],
        colors: [Color(0xFF4a3cdb), Color(0xFFff0a6c)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

}

```

`lib\features\home\presentation\widgets\header_content.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileService.getProfile();
    final displayName = (profile != null && profile.firstName.isNotEmpty)
        ? '${profile.firstName}!' 
        : context.l10n.defaultUserName;

    return SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, 
            children: [
              Text(
                _getGreetingByTime(context),
                style: TextStyles.titleMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayName,
                style: TextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildAvatar(profile),
      ],
    ),
  ),
);
  }

  Widget _buildAvatar(profile) {
    if (profile != null && profile.avatarName != null) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/avatars/${profile.avatarName}'),
      );
    }
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white.withValues(alpha: 0.2),
      child: const Icon(Icons.person_rounded, color: Colors.white, size: 32),
    );
  }

  String _getGreetingByTime(BuildContext context) {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      return context.l10n.greetingMorning;
    } else if (hour >= 12 && hour < 16) {
      return context.l10n.greetingDay;
    } else if (hour >= 16 && hour < 20) {
      return context.l10n.greetingEvening;
    } else {
      return context.l10n.greetingNight;
    }
  }
}
```

`lib\features\home\presentation\widgets\metrics_grid.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/widgets/health_card.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../../../metrics/presentation/pages/metrics_container_page.dart';
import '../../../metrics/domain/metric_factory.dart';

class MetricsGrid extends StatefulWidget {
  const MetricsGrid({super.key});

  @override
  State<MetricsGrid> createState() => MetricsGridState();
}

class MetricsGridState extends State<MetricsGrid> {
  HealthEntry? _lastPressure;
  HealthEntry? _lastPulse;
  HealthEntry? _lastSugar;
  HealthEntry? _lastWeight;

  @override
  void initState() {
    super.initState();
    _loadLastEntries();
  }

  void refresh() {
    _loadLastEntries();
  }

  void _loadLastEntries() {
    setState(() {
      _lastPressure = EntryService.getLastByType(EntryType.pressure);
      _lastPulse = EntryService.getLastByType(EntryType.pulse);
      _lastSugar = EntryService.getLastByType(EntryType.sugar);
      _lastWeight = EntryService.getLastByType(EntryType.weight);
    });
  }

  String _formatLastUpdate(BuildContext context, DateTime? date) {
    if (date == null) return context.l10n.noData;
    
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0 && date.day == now.day) {
      return context.l10n.today;
    } else if (diff.inDays <= 1 && date.day == now.subtract(const Duration(days: 1)).day) {
      return context.l10n.yesterday;
    } else if (diff.inDays < 7) {
      return '${diff.inDays} дн. назад';
    } else {
      return '${date.day}.${date.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            padding: EdgeInsets.zero,
            children: [
              HealthCard(
                title: context.l10n.metricPressureUpper,
                value: _lastPressure?.displayValue ?? '—/—',
                unit: context.l10n.unitMmHg,
                lastUpdate: _formatLastUpdate(context, _lastPressure?.createdAt),
                gradient: AppColors.pressureGradient,
                icon: const Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.pressure,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricPulseUpper,
                value: _lastPulse?.displayValue ?? '—',
                unit: context.l10n.unitBpm,
                lastUpdate: _formatLastUpdate(context, _lastPulse?.createdAt),
                gradient: AppColors.pulseGradient,
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.pulse,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricSugarUpper,
                value: _lastSugar?.displayValue ?? '—',
                unit: context.l10n.unitMmol,
                lastUpdate: _formatLastUpdate(context, _lastSugar?.createdAt),
                gradient: AppColors.sugarGradient,
                icon: const Icon(
                  Icons.bloodtype_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.sugar,
                      ),
                    ),
                  );
                },
              ),
              
              HealthCard(
                title: context.l10n.metricWeightUpper,
                value: _lastWeight?.displayValue ?? '—',
                unit: context.l10n.unitKg,
                lastUpdate: _formatLastUpdate(context, _lastWeight?.createdAt),
                gradient: AppColors.weightGradient,
                icon: const Icon(
                  Icons.monitor_weight_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MetricsContainerPage(
                        initialTab: MetricType.weight,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

`lib\features\home\presentation\widgets\metrics_panel.dart`:

```dart
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
```

`lib\features\metrics\domain\metric_factory.dart`:

```dart
import 'metric_interface.dart';
import 'metrics/pressure_metric.dart';
import 'metrics/sugar_metric.dart';
import 'metrics/weight_metric.dart';
import 'metrics/pulse_metric.dart';

enum MetricType { pressure, sugar, weight, pulse }

class MetricFactory {
  static MetricInterface create(MetricType type) {
    switch (type) {
      case MetricType.pressure:
        return PressureMetric();
      case MetricType.sugar:
        return SugarMetric();
      case MetricType.weight:
        return WeightMetric();
      case MetricType.pulse:
        return PulseMetric();
    }
  }

  static List<MetricType> get allTypes => MetricType.values;
}

```

`lib\features\metrics\domain\metric_interface.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../data/models/health_entry.dart';

abstract class MetricInterface {
  String get title;
  String get description;
  String get unit;
  Gradient get gradient;
  IconData get icon;
  EntryType get entryType;
  
  String formatValue(HealthEntry entry);
  String formatValueShort(HealthEntry entry);
}
```

`lib\features\metrics\domain\metrics\pressure_metric.dart`:

```dart
import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class PressureMetric implements MetricInterface {
  @override
  String get title => 'ДАВЛЕНИЕ';
  
  @override
  String get description => 'Артериальное давление — ключевой маркер состояния сердечно-сосудистой системы, отражающий силу воздействия крови на стенки сосудов.';
  
  @override
  String get unit => 'мм рт.ст.';
  
  @override
  Gradient get gradient => AppColors.pressureGradient;
  
  @override
  IconData get icon => Icons.monitor_heart_outlined;
  
  @override
  EntryType get entryType => EntryType.pressure;
  
  @override
  String formatValue(HealthEntry entry) {
    final sys = entry.value.toInt();
    final dia = entry.secondaryValue?.toInt() ?? 0;
    return '$sys/$dia';
  }
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}
```

`lib\features\metrics\domain\metrics\pulse_metric.dart`:

```dart
import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class PulseMetric implements MetricInterface {
  @override
  String get title => 'ПУЛЬС';
  
  @override
  String get description => 'Пульс отображает частоту сердечных сокращений и позволяет оценивать ритм работы сердца.';
  
  @override
  String get unit => 'уд/мин';
  
  @override
  Gradient get gradient => AppColors.pulseGradient;
  
  @override
  IconData get icon => Icons.favorite_outline;
  
  @override
  EntryType get entryType => EntryType.pulse;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toInt().toString();
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}
```

`lib\features\metrics\domain\metrics\sugar_metric.dart`:

```dart
import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class SugarMetric implements MetricInterface {
  @override
  String get title => 'САХАР';
  
  @override
  String get description => 'Уровень глюкозы в крови отражает концентрацию сахара и является главным показателем углеводного обмена в организме.';
  
  @override
  String get unit => 'ммоль/л';
  
  @override
  Gradient get gradient => AppColors.sugarGradient;
  
  @override
  IconData get icon => Icons.bloodtype_outlined;
  
  @override
  EntryType get entryType => EntryType.sugar;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toStringAsFixed(1);
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}
```

`lib\features\metrics\domain\metrics\weight_metric.dart`:

```dart
import 'package:flutter/material.dart';
import '../metric_interface.dart';
import '../../../../core/theme/colors.dart';
import '../../../../data/models/health_entry.dart';

class WeightMetric implements MetricInterface {
  @override
  String get title => 'ВЕС';
  
  @override
  String get description => 'Регулярное отслеживание веса помогает контролировать физическую форму и вовремя замечать изменения в организме.';
  
  @override
  String get unit => 'кг';
  
  @override
  Gradient get gradient => AppColors.weightGradient;
  
  @override
  IconData get icon => Icons.monitor_weight_outlined;
  
  @override
  EntryType get entryType => EntryType.weight;
  
  @override
  String formatValue(HealthEntry entry) => entry.value.toStringAsFixed(1);
  
  @override
  String formatValueShort(HealthEntry entry) => formatValue(entry);
}
```

`lib\features\metrics\presentation\pages\metric_tab_content.dart`:

```dart
import 'package:flutter/material.dart';
import '../../domain/metric_factory.dart';
import '../widgets/metric_chart.dart';
import '../widgets/metric_history.dart';
import '../widgets/metric_info_card.dart';
import '../widgets/metric_stats.dart';
import '../../../../main.dart';

class MetricTabContent extends StatelessWidget {
  final MetricType metricType;

  const MetricTabContent({
    super.key,
    required this.metricType,
  });

  @override
  Widget build(BuildContext context) {
    final metric = MetricFactory.create(metricType);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MetricStats(metric: metric),
          const SizedBox(height: 16),
          MetricChart(metric: metric),
          const SizedBox(height: 16),
          MetricHistory(
            metric: metric,
            onViewAll: () {
              // Закрываем страницу метрик и переходим на историю
              Navigator.of(context).pop();
              MainNavigator.goToHistory();
            },
          ),
          const SizedBox(height: 16),
          MetricInfoCard(metric: metric),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
```

`lib\features\metrics\presentation\pages\metrics_container_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../domain/metric_factory.dart';
import 'metric_tab_content.dart';

class MetricsContainerPage extends StatefulWidget {
  final MetricType initialTab;

  const MetricsContainerPage({
    super.key,
    this.initialTab = MetricType.pressure,
  });

  @override
  State<MetricsContainerPage> createState() => _MetricsContainerPageState();
}

class _MetricsContainerPageState extends State<MetricsContainerPage> {
  MetricType _selectedMetric = MetricType.pressure;

  @override
  void initState() {
    super.initState();
    _selectedMetric = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background(context),
      
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Метрики здоровья', style: TextStyles.titleMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: MetricFactory.allTypes.map((metricType) {
                final metric = MetricFactory.create(metricType);
                final isSelected = _selectedMetric == metricType;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMetric = metricType),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.surface(context) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected && Theme.of(context).brightness == Brightness.dark
                            ? Border.all(color: AppTheme.border(context), width: 0.5)
                            : null,
                        boxShadow: isSelected && Theme.of(context).brightness == Brightness.light ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: Text(
                        metric.title.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyles.bodyMedium.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? AppTheme.textPrimary(context) : AppTheme.textSecondary(context),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),


          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: MetricTabContent(
                key: ValueKey(_selectedMetric),
                metricType: _selectedMetric,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

`lib\features\metrics\presentation\widgets\metric_chart.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';
import '../../../../data/models/health_entry.dart';

class MetricChart extends StatefulWidget {
  final MetricInterface metric;

  const MetricChart({
    super.key,
    required this.metric,
  });

  @override
  State<MetricChart> createState() => _MetricChartState();
}

class _MetricChartState extends State<MetricChart> {
  int _selectedPeriod = 7; // days

  List<HealthEntry> _getEntriesForPeriod() {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: _selectedPeriod));
    return EntryService.getByTypeAndDateRange(
      widget.metric.entryType,
      startDate,
      now,
    );
  }

  List<String> _getLabelsFromEntries(List<HealthEntry> entries) {
    if (entries.isEmpty) return [];
    
    // Показываем до 7 меток равномерно распределённых
    final maxLabels = 7;
    final step = entries.length > maxLabels 
        ? (entries.length / maxLabels).ceil() 
        : 1;
    
    final labels = <String>[];
    for (int i = 0; i < entries.length; i += step) {
      final date = entries[i].createdAt;
      if (_selectedPeriod <= 7) {
        labels.add(DateFormat('E', 'ru').format(date)); // Пн, Вт...
      } else if (_selectedPeriod <= 30) {
        labels.add(DateFormat('d', 'ru').format(date)); // 1, 2, 3...
      } else {
        labels.add(DateFormat('MMM', 'ru').format(date)); // Янв, Фев...
      }
    }
    return labels;
  }

  String _getPeriodName(BuildContext context) {
    if (_selectedPeriod == 7) return context.l10n.week;
    if (_selectedPeriod == 30) return context.l10n.month;
    return context.l10n.year;
  }

  void _showPeriodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(context.l10n.week),
              trailing: _selectedPeriod == 7 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 7);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(context.l10n.month),
              trailing: _selectedPeriod == 30 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 30);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: Text(context.l10n.year),
              trailing: _selectedPeriod == 365 ? const Icon(Icons.check) : null,
              onTap: () {
                setState(() => _selectedPeriod = 365);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getEntriesForPeriod();
    final labels = _getLabelsFromEntries(entries);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.dynamics,
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                ),
              ),
              GestureDetector(
                onTap: () => _showPeriodPicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _getPeriodName(context),
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textSecondary(context),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppTheme.textSecondary(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      context.l10n.noDataForPeriod,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textHint(context),
                      ),
                    ),
                  )
                : CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: _ChartPainter(
                      entries: entries,
                      metric: widget.metric,
                      period: _selectedPeriod,
                    ),
                  ),
          ),
          if (labels.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels
                  .map((label) => Text(
                        label,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          color: AppTheme.textHint(context),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<HealthEntry> entries;
  final MetricInterface metric;
  final int period;

  _ChartPainter({
    required this.entries,
    required this.metric,
    required this.period,
  });

  double _getMainValue(HealthEntry entry) {
    return entry.value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (entries.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final gridPaint = Paint()
      ..color = const Color(0xFFE9ECEF)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Calculate normalized points
    final values = entries.map(_getMainValue).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final range = maxVal - minVal;
    
    List<double> points;
    if (range == 0) {
      points = values.map((_) => 0.5).toList();
    } else {
      points = values.map((v) => (v - minVal) / range * 0.8 + 0.1).toList();
    }

    final gradient = const LinearGradient(
      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.shader = gradient;

    if (points.length == 1) {
      // Single point - just draw a dot
      final x = size.width / 2;
      final y = size.height * (1 - points[0]);
      final pointPaint = Paint()
        ..color = const Color(0xFF667eea)
        ..style = PaintingStyle.fill;
      final pointBorderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 6, pointBorderPaint);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
      return;
    }

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * (1 - points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = size.width * (i - 1) / (points.length - 1);
        final prevY = size.height * (1 - points[i - 1]);
        final controlX = (prevX + x) / 2;
        path.cubicTo(controlX, prevY, controlX, y, x, y);
      }
    }
    canvas.drawPath(path, paint);

    // Draw area under the curve
    final areaPath = Path.from(path);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF667eea).withValues(alpha: 0.3),
          const Color(0xFF667eea).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(areaPath, areaPaint);

    // Draw points
    final pointPaint = Paint()
      ..color = const Color(0xFF667eea)
      ..style = PaintingStyle.fill;
    final pointBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * (1 - points[i]);
      canvas.drawCircle(Offset(x, y), 6, pointBorderPaint);
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.entries != entries || oldDelegate.period != period;
  }
}
```

`lib\features\metrics\presentation\widgets\metric_history.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';
import '../../../../data/models/health_entry.dart';

class MetricHistory extends StatelessWidget {
  final MetricInterface metric;
  final VoidCallback? onViewAll;

  const MetricHistory({
    super.key,
    required this.metric,
    this.onViewAll,
  });

  List<HealthEntry> _getRecentEntries() {
    final entries = EntryService.getByType(metric.entryType);
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries.take(3).toList(); // Только 3 последних
  }

  int _getTotalCount() {
    return EntryService.getByType(metric.entryType).length;
  }

  double _getChange(List<HealthEntry> entries, int index) {
    if (index >= entries.length - 1) return 0;
    final current = _getMainValue(entries[index]);
    final previous = _getMainValue(entries[index + 1]);
    return current - previous;
  }

  double _getMainValue(HealthEntry entry) {
    return entry.value;
  }

  @override
  Widget build(BuildContext context) {
    final entries = _getRecentEntries();
    final totalCount = _getTotalCount();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.historyYourMeasurements,
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                ),
              ),
              if (totalCount > 3 && onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    context.l10n.allRecords,
                    style: TextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      size: 48,
                      color: AppTheme.textHint(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.historyNoRecords,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textHint(context),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...entries.asMap().entries.map((e) {
              final index = e.key;
              final entry = e.value;
              final change = _getChange(entries, index);
              return _HistoryItem(
                entry: entry,
                metric: metric,
                change: change,
              );
            }),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final HealthEntry entry;
  final MetricInterface metric;
  final double change;

  const _HistoryItem({
    required this.entry,
    required this.metric,
    required this.change,
  });

  String _formatDate(DateTime date) {
    return DateFormat('d MMM', 'ru').format(date);
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceVariant(context),
            AppTheme.surface(context),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.border(context),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Иконка
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: metric.gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              metric.icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Дата и время
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(entry.createdAt),
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textPrimary(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTime(entry.createdAt),
                  style: TextStyles.labelSmall.copyWith(
                    color: AppTheme.textHint(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    metric.formatValueShort(entry),
                    style: TextStyles.titleMedium.copyWith(
                      color: AppTheme.textPrimary(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    metric.unit,
                    style: TextStyles.labelSmall.copyWith(
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              // Изменение
              if (change != 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      change < 0 
                          ? Icons.trending_down 
                          : Icons.trending_up,
                      size: 14,
                      color: change < 0 
                          ? AppColors.success500 
                          : AppColors.error500,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${change > 0 ? '+' : ''}${change.toStringAsFixed(1)}',
                      style: TextStyles.labelXSmall.copyWith(
                        color: change < 0 
                            ? AppColors.success500 
                            : AppColors.error500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
```

`lib\features\metrics\presentation\widgets\metric_info_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/app_theme.dart';

class MetricInfoCard extends StatelessWidget {
  final MetricInterface metric;

  const MetricInfoCard({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'О метрике',
            style: TextStyles.titleMedium.copyWith(
              color: AppTheme.textPrimary(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            metric.description,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
```

`lib\features\metrics\presentation\widgets\metric_stats.dart`:

```dart
import 'package:flutter/material.dart';
import '../../domain/metric_interface.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/entry_service.dart';

class MetricStats extends StatelessWidget {
  final MetricInterface metric;

  const MetricStats({
    super.key,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    final lastEntry = EntryService.getLastByType(metric.entryType);
    final currentValue = lastEntry != null ? metric.formatValue(lastEntry) : '—';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: metric.gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lastEntry != null ? context.l10n.today : context.l10n.noData,
                style: TextStyles.labelSmall.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentValue,
                style: TextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              Text(
                metric.unit,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Icon(metric.icon, color: Colors.white, size: 40),
        ],
      ),
    );
  }
}
```

`lib\features\onboarding\presentation\pages\onboarding_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../../../../main.dart';
import '../widgets/name_page.dart';
import '../widgets/birth_date_page.dart';
import '../widgets/sex_page.dart';
import '../widgets/height_page.dart';
import '../widgets/weight_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  int _currentPage = 0;
  DateTime? _birthDate;
  bool? _sex;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isKeyboardVisible = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  static const _primaryColor = Color(0xFFAC68F2);
  static const _secondaryColor = Color(0xFF4E00c9);
  static const _tricondaryColor = Color(0xFF1A1E4C);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _nextPage() {
    FocusScope.of(context).unfocus();

    if (!_canProceed()) {
      _showValidationError();
      return;
    }

    if (_currentPage < 4) {
      _fadeController.reverse().then((_) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _fadeController.forward();
      });
    } else {
      _finish();
    }
  }

  void _previousPage() {
    FocusScope.of(context).unfocus();

    if (_currentPage > 0) {
      _fadeController.reverse().then((_) {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _fadeController.forward();
      });
    }
  }

  void _showValidationError() {
    String? message;
    switch (_currentPage) {
      case 0:
        message = 'Пожалуйста, введите ваше имя';
        break;
      case 1:
        message = 'Пожалуйста, выберите дату рождения';
        break;
      case 2:
        message = 'Пожалуйста, укажите ваш пол';
        break;
      case 3:
        message = 'Пожалуйста, укажите ваш рост';
        break;
      case 4:
        message = 'Пожалуйста, укажите ваш вес';
        break;
    }

    if (message != null && mounted) {
      setState(() => _errorMessage = message);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _errorMessage = null);
      });
    }
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _nameController.text.trim().isNotEmpty;
      case 1:
        return _birthDate != null;
      case 2:
        return _sex != null;
      case 3:
        return _heightController.text.isNotEmpty &&
            double.tryParse(_heightController.text) != null;
      case 4:
        return _weightController.text.isNotEmpty &&
            double.tryParse(_weightController.text) != null;
      default:
        return true;
    }
  }

  Future<void> _finish() async {
    if (!_canProceed()) return;

    setState(() => _isLoading = true);

    try {
      final profile = UserProfile(
        firstName: _nameController.text.trim(),
        birthDate: _birthDate,
        height: double.tryParse(_heightController.text),
        weight: double.tryParse(_weightController.text),
        sex: _sex,
      );

      await ProfileService.saveProfile(profile);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigator(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Произошла ошибка при сохранении. Попробуйте ещё раз.';
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) setState(() => _errorMessage = null);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_primaryColor, _secondaryColor, _tricondaryColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button and progress
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: _currentPage > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _currentPage > 0 ? 44 : 0,
                        height: 44,
                        child: _currentPage > 0
                            ? GestureDetector(
                                onTap: _previousPage,
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),

                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(5, (index) => _buildDot(index)),
                    ),

                    const SizedBox(width: 44),
                  ],
                ),
              ),

              // Error message banner
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _errorMessage != null ? 48 : 0,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _errorMessage != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.info_outline,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),

              // PageView
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    children: [
                      NamePage(
                        controller: _nameController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                      BirthDatePage(
                        selectedDate: _birthDate,
                        onDateSelected: (date) =>
                            setState(() => _birthDate = date),
                      ),
                      SexPage(
                        selectedSex: _sex,
                        onSexSelected: (sex) => setState(() => _sex = sex),
                      ),
                      HeightPage(
                        controller: _heightController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                      WeightPage(
                        controller: _weightController,
                        onChanged: () => setState(() {}),
                        onKeyboardChanged: (visible) {
                          if (visible != _isKeyboardVisible) {
                            setState(() => _isKeyboardVisible = visible);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        _canProceed() ? (_isLoading ? null : _nextPage) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _secondaryColor,
                      
                      disabledBackgroundColor: Colors.white.withValues(alpha: 0.4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: _primaryColor,
                            ),
                          )
                        : Text(
                            _currentPage == 4
                                ? context.l10n.onboardingFinish
                                : context.l10n.onboardingContinue,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == _currentPage;
    final isPassed = index < _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? Colors.white
            : isPassed
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

```

`lib\features\onboarding\presentation\widgets\birth_date_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class BirthDatePage extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const BirthDatePage({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        DateTime tempDate = selectedDate ?? DateTime(1990, 1, 1);
        return Container(
          height: 320,
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        context.l10n.cancel,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        onDateSelected(tempDate);
                        Navigator.pop(context);
                      },
                      child: Text(
                        context.l10n.save,
                        style: TextStyles.bodyMedium.copyWith(
                          color: const Color(0xFF667eea),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: tempDate,
                  minimumDate: DateTime(1900),
                  maximumDate: now,
                  onDateTimeChanged: (date) => tempDate = date,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final months = [
      '', 'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cake_rounded,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              context.l10n.onboardingBirthDateTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              context.l10n.onboardingBirthDateSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Date selector
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: selectedDate != null
                          ? Colors.black87
                          : Colors.black.withValues(alpha: 0.3),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        selectedDate != null
                            ? _formatDate(selectedDate)
                            : context.l10n.onboardingSelectDate,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: selectedDate != null
                              ? Colors.black87
                              : Colors.black.withValues(alpha: 0.3),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\onboarding\presentation\widgets\height_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class HeightPage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final ValueChanged<bool> onKeyboardChanged;

  const HeightPage({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onKeyboardChanged,
  });

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onKeyboardChanged(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = _focusNode.hasFocus;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Icon with fade animation when keyboard appears
            AnimatedOpacity(
              opacity: isKeyboardVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: AnimatedScale(
                scale: isKeyboardVisible ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.height_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),

            Text(
              context.l10n.onboardingHeightTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              context.l10n.onboardingHeightSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                      onChanged: (_) => widget.onChanged(),
                      decoration: InputDecoration(
                        hintText: '170',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.unitCm,
                  style: TextStyles.headlineLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Container(
              width: 200,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\onboarding\presentation\widgets\name_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class NamePage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final ValueChanged<bool> onKeyboardChanged;

  const NamePage({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onKeyboardChanged,
  });

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onKeyboardChanged(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = _focusNode.hasFocus;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Icon with fade animation when keyboard appears
            AnimatedOpacity(
              opacity: isKeyboardVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: AnimatedScale(
                scale: isKeyboardVisible ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.waving_hand_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              context.l10n.onboardingWelcome,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              context.l10n.onboardingQuestion,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Input
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              textCapitalization: TextCapitalization.words,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              onChanged: (_) => widget.onChanged(),
              decoration: InputDecoration(
                hintText: context.l10n.onboardingNameHint,
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.3),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\onboarding\presentation\widgets\sex_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class SexPage extends StatelessWidget {
  final bool? selectedSex; // true = мужской, false = женский
  final ValueChanged<bool> onSexSelected;

  const SexPage({
    super.key,
    required this.selectedSex,
    required this.onSexSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wc_rounded,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),

            Text(
              context.l10n.onboardingSexTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              context.l10n.onboardingSexSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SexOption(
                  icon: Icons.male_rounded,
                  label: context.l10n.sexMale,
                  isSelected: selectedSex == true,
                  onTap: () => onSexSelected(true),
                ),
                const SizedBox(width: 24),
                _SexOption(
                  icon: Icons.female_rounded,
                  label: context.l10n.sexFemale,
                  isSelected: selectedSex == false,
                  onTap: () => onSexSelected(false),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SexOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SexOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 130,
        height: 150,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.2),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 52,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\onboarding\presentation\widgets\weight_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class WeightPage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final ValueChanged<bool> onKeyboardChanged;

  const WeightPage({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onKeyboardChanged,
  });

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onKeyboardChanged(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = _focusNode.hasFocus;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Icon with fade animation when keyboard appears
            AnimatedOpacity(
              opacity: isKeyboardVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: AnimatedScale(
                scale: isKeyboardVisible ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.monitor_weight_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              context.l10n.onboardingWeightTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              context.l10n.onboardingWeightSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                      onChanged: (_) => widget.onChanged(),
                      decoration: InputDecoration(
                        hintText: '70',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.unitKg,
                  style: TextStyles.headlineLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Underline
            Container(
              width: 200,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\profile\presentation\pages\edit_profile_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/edit_profile_widgets.dart';
import '../widgets/avatar_picker_modal.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _heightController;
  DateTime? _birthDate;
  bool? _sex;
  String? _avatarName;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.profile.firstName);
    _heightController = TextEditingController(
      text: widget.profile.height?.toStringAsFixed(0) ?? '',
    );
    _birthDate = widget.profile.birthDate;
    _sex = widget.profile.sex;
    _avatarName = widget.profile.avatarName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ru'),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  String _formatDate(BuildContext context, DateTime? date) {
    if (date == null) return context.l10n.notSpecified;
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Future<void> _pickAvatar() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AvatarPickerModal(
        currentAvatarName: _avatarName,
        onAvatarSelected: (name) {
          setState(() {
            _avatarName = name;
          });
        },
      ),
    );
  }

  Future<void> _save() async {
    final newProfile = UserProfile(
      firstName: _firstNameController.text.trim(),
      birthDate: _birthDate,
      height: double.tryParse(_heightController.text),
      sex: _sex,
      avatarName: _avatarName,
    );
    
    await ProfileService.saveProfile(newProfile);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        context.l10n.editProfile,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Avatar edit
                            Center(
                              child: GestureDetector(
                                onTap: _pickAvatar,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppTheme.surfaceVariant(context),
                                      backgroundImage: _avatarName != null
                                          ? AssetImage('assets/images/avatars/$_avatarName')
                                          : null,
                                      onBackgroundImageError: _avatarName != null
                                          ? (_, __) {}
                                          : null,
                                      child: _avatarName == null
                                          ? Icon(
                                              Icons.person_rounded,
                                              size: 52,
                                              color: AppTheme.textHint(context),
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:  Color(0xFF8E2DE2),
                                          shape: BoxShape.circle,
                                          border: Border.all(color: AppTheme.surface(context), width: 3),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Form fields
                            EditSection(
                              title: context.l10n.personalData,
                              children: [
                                EditTextField(
                                  label: context.l10n.firstName,
                                  controller: _firstNameController,
                                ),
                                EditDateField(
                                  label: context.l10n.birthDate,
                                  value: _formatDate(context, _birthDate),
                                  onTap: _selectDate,
                                ),
                                EditSexField(
                                  label: context.l10n.sex,
                                  maleLabel: context.l10n.sexMale,
                                  femaleLabel: context.l10n.sexFemale,
                                  value: _sex,
                                  onChanged: (v) => setState(() => _sex = v),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            EditSection(
                              title: context.l10n.physicalParams,
                              children: [
                                EditTextField(
                                  label: '${context.l10n.height} (${context.l10n.unitCm})',
                                  controller: _heightController,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Save button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.purpleGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          context.l10n.save,
                          style: TextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\profile\presentation\pages\profile_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';
import 'settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile _profile = UserProfile(firstName: '');

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final profile = ProfileService.getProfile();
    if (profile != null) {
      setState(() {
        _profile = profile;
      });
    }
  }

  String _formatDate(BuildContext context, DateTime? date) {
    if (date == null) return context.l10n.notSpecified;
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatHeight(BuildContext context, double? height) {
    if (height == null) return context.l10n.notSpecified;
    return '${height.toStringAsFixed(0)} ${context.l10n.unitCm}';
  }

  String _formatSex(BuildContext context, bool? sex) {
    if (sex == null) return context.l10n.notSpecified;
    return sex ? context.l10n.sexMale : context.l10n.sexFemale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.profile,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SettingsPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ProfileHeader(
                    profile: _profile,
                    onEditComplete: _loadProfile,
                  ),
                ),


                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                        child: Column(
                          children: [
                            ProfileCard(
                              icon: Icons.person_outline,
                              title: context.l10n.personalData,
                              items: [
                                ProfileItem(
                                  label: context.l10n.firstName, 
                                  value: _profile.firstName.isEmpty 
                                      ? context.l10n.notSpecified 
                                      : _profile.firstName,
                                ),
                                ProfileItem(
                                  label: context.l10n.birthDate, 
                                  value: _formatDate(context, _profile.birthDate),
                                ),
                                ProfileItem(
                                  label: context.l10n.sex,
                                  value: _formatSex(context, _profile.sex),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ProfileCard(
                              icon: Icons.monitor_weight_outlined,
                              title: context.l10n.physicalParams,
                              items: [
                                ProfileItem(
                                  label: context.l10n.height, 
                                  value: _formatHeight(context, _profile.height),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\profile\presentation\pages\settings_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/reminder_service.dart';
import '../../../../data/services/theme_service.dart';
import '../../../../data/services/notification_service.dart';
import '../../../../data/services/profile_service.dart';
import '../../../../data/services/entry_service.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';
import '../widgets/settings/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _clearAllData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Очистить данные'),
        content: const Text(
          'Вы точно уверены? Это действие удалит все ваши данные. '
          'Это невозможно отменить.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
    await ProfileService.deleteProfile();
    await EntryService.deleteAll();
    await ReminderService.deleteAll();
    await NotificationService.cancelAll();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
        (route) => false,
      );
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = ThemeService.instance;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                SettingsHeader(title: context.l10n.settings),
                // Sheet
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ─── Внешний вид ───────────────────
                            SettingsGroup(
                              title: context.l10n.appearance,
                              children: [
                                _ThemeSelector(
                                  currentMode: themeService.mode,
                                  onChanged: (mode) async {
                                    await themeService.setMode(mode);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // ─── Уведомления ──────────────────
                            SettingsGroup(
  title: context.l10n.notifications,
  children: [
    SettingsSwitch(
      icon: Icons.notifications_none,
      label: context.l10n.reminders,
      value: themeService.notificationsEnabled,  // читаем из сервиса
      onChanged: (val) async {
        await themeService.setNotificationsEnabled(val);
        setState(() {});
        if (val) {
          // Если включили – запрашиваем разрешения и перепланируем
          await NotificationService.requestPermissions();
          final reminders = ReminderService.getActive();
          await NotificationService.rescheduleAllReminders(reminders);
        } else {
          // Если выключили – отменяем все уведомления
          await NotificationService.cancelAll();
        }
      },
    ),
  ],
),
                            const SizedBox(height: 20),
                            // ─── Прочее ────────────────────────
                            SettingsGroup(
                              title: context.l10n.other,
                              children: [
                                SettingsNav(
                                  icon: Icons.info_outline,
                                  label: context.l10n.aboutApp,
                                  value: 'v0.6.7',
                                  onTap: () => _showAbout(context),
                                ),
                                const SettingsDivider(),
                                GestureDetector(
                                  onTap: () => _clearAllData(context),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline,
                                            color: AppColors.error500, size: 22),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            'Очистить данные',
                                            style: TextStyles.bodyMedium.copyWith(
                                              color: AppColors.error500,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.chevron_right,
                                            color: AppTheme.textHint(context),
                                            size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Health Oracle',
      applicationVersion: '0.6.7',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.favorite, color: Colors.white, size: 24),
      ),
    );
  }
}

// ─── Theme Selector ─────────────────────────────────────────────

class _ThemeSelector extends StatelessWidget {
  final AppThemeMode currentMode;
  final ValueChanged<AppThemeMode> onChanged;

  const _ThemeSelector({
    required this.currentMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_outlined,
                  color: AppTheme.textSecondary(context), size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  context.l10n.theme,
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textPrimary(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: AppThemeMode.values.map((mode) {
              final isSelected = mode == currentMode;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: mode != AppThemeMode.system ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => onChanged(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8E2DE2).withValues(alpha: 0.1)
                            : AppTheme.surfaceVariant(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF8E2DE2)
                              : AppTheme.border(context),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _iconFor(mode),
                            size: 22,
                            color: isSelected
                                ? const Color(0xFF8E2DE2)
                                : AppTheme.textHint(context),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _labelFor(context, mode),
                            style: TextStyles.labelSmall.copyWith(
                              fontSize: 12,
                              color: isSelected
                                  ? const Color(0xFF8E2DE2)
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
      case AppThemeMode.system:
        return Icons.settings_brightness_rounded;
    }
  }

  String _labelFor(BuildContext context, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return context.l10n.themeLight;
      case AppThemeMode.dark:
        return context.l10n.themeDark;
      case AppThemeMode.system:
        return context.l10n.themeSystem;
    }
  }
}


```

`lib\features\profile\presentation\widgets\avatar_picker_modal.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

/// Модальное окно для выбора аватарки из предложенных изображений.
///
/// Аватарки должны лежать в assets/images/avatars/.
/// Пользователь сам кладёт туда .jpg, .png файлы.
class AvatarPickerModal extends StatelessWidget {
  /// Текущий выбранный аватар (имя файла) или null
  final String? currentAvatarName;

  /// Колбэк при выборе аватарки
  final ValueChanged<String?> onAvatarSelected;

  const AvatarPickerModal({
    super.key,
    this.currentAvatarName,
    required this.onAvatarSelected,
  });

  static List<String> _getAvatarAssets() {
    return const [
      'assets/images/avatars/avatar_1.jpg',
      'assets/images/avatars/avatar_2.jpg',
      'assets/images/avatars/avatar_3.jpg',
      'assets/images/avatars/avatar_4.jpg',
      'assets/images/avatars/avatar_5.jpg',
      'assets/images/avatars/avatar_6.jpg',
      'assets/images/avatars/avatar_7.jpg',
      'assets/images/avatars/avatar_8.jpg',
    ];
  }

  /// Получить имя файла из пути ассета
  static String _assetName(String assetPath) {
    return assetPath.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    final avatars = _getAvatarAssets();

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      decoration: BoxDecoration(
        color: AppTheme.surface(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppTheme.textHint(context).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Выберите аватар',
            style: TextStyles.headlineLarge.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Нажмите на аватар, чтобы выбрать его',
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textHint(context),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // Сетка аватарок
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final assetPath = avatars[index];
              final fileName = _assetName(assetPath);
              final isSelected = currentAvatarName == fileName;

              return GestureDetector(
                onTap: () {
                  onAvatarSelected(fileName);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: const Color(0xFF8E2DE2), width: 3)
                        : null,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: AppTheme.surfaceVariant(context),
                    backgroundImage: AssetImage(assetPath),
                    onBackgroundImageError: (_, __) {},
                  
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Кнопка "Убрать аватар"
          if (currentAvatarName != null)
            Center(
              child: TextButton.icon(
                onPressed: () {
                  onAvatarSelected(null);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Убрать аватар'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red.shade400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

```

`lib\features\profile\presentation\widgets\edit_profile_widgets.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class EditSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const EditSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyles.labelSmall.copyWith(
              color: AppTheme.textHint(context),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration(context, radius: 16),
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// Текстовое поле для редактирования
class EditTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const EditTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textPrimary(context),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.surfaceVariant(context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.border(context)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.border(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF8E2DE2), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Поле для выбора даты
class EditDateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const EditDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border(context)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppTheme.textHint(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Старый виджет для обратной совместимости
class EditField extends StatelessWidget {
  final String label;
  final String value;
  final bool isDate;

  const EditField({
    super.key,
    required this.label,
    required this.value,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textPrimary(context),
                    ),
                  ),
                ),
                if (isDate)
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppTheme.textHint(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Поле выбора пола
class EditSexField extends StatelessWidget {
  final String label;
  final String maleLabel;
  final String femaleLabel;
  final bool? value; // true = мужской, false = женский
  final ValueChanged<bool> onChanged;

  const EditSexField({
    super.key,
    required this.label,
    required this.maleLabel,
    required this.femaleLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _SexToggle(
                  label: maleLabel,
                  icon: Icons.male_rounded,
                  isSelected: value == true,
                  onTap: () => onChanged(true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SexToggle(
                  label: femaleLabel,
                  icon: Icons.female_rounded,
                  isSelected: value == false,
                  onTap: () => onChanged(false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SexToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SexToggle({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8E2DE2).withValues(alpha: 0.1) : AppTheme.surfaceVariant(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.border(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.textHint(context),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.textSecondary(context),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\profile\presentation\widgets\profile_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<ProfileItem> items;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(context, radius: 20, shadowAlpha: 0.1, blurRadius: 8, shadowOffset: const Offset(0, 4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyles.titleMedium.copyWith(
                  color: AppTheme.textPrimary(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(color: AppTheme.textSecondary(context)),
          ),
          Text(
            value,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textPrimary(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\profile\presentation\widgets\profile_header.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../pages/edit_profile_page.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onEditComplete;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    final displayName = profile.firstName.isEmpty 
        ? context.l10n.defaultUserName 
        : profile.firstName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.surface(context), width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 46,
              backgroundColor: AppTheme.surface(context),
              backgroundImage: profile.avatarName != null
                  ? AssetImage('assets/images/avatars/${profile.avatarName}')
                  : null,
              onBackgroundImageError: profile.avatarName != null
                  ? (_, __) {}
                  : null,
              child: profile.avatarName == null
                  ? Icon(
                      Icons.person_rounded,
                      size: 56,
                      color: AppTheme.textHint(context),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 24),
          // Name & Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyles.headlineLarge.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                // Edit Button
                UnconstrainedBox(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditProfilePage(
                                profile: profile,
                              ),
                            ),
                          );
                          onEditComplete?.call();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.edit,
                                style: TextStyles.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\profile\presentation\widgets\settings\settings_widgets.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/theme/text_styles.dart';

class SettingsHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const SettingsHeader({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyles.headlineLarge.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsGroup({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: TextStyles.labelSmall.copyWith(
              color: AppTheme.textHint(context),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: AppTheme.cardDecoration(context, radius: 16),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 52,
      color: AppTheme.divider(context),
    );
  }
}

class SettingsSwitch extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SettingsSwitch({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.textSecondary(context), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged ?? (_) {},
          ),
        ],
      ),
    );
  }
}

class SettingsNav extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const SettingsNav({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.textSecondary(context), size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
              ),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: TextStyles.bodyMedium.copyWith(color: AppTheme.textHint(context)),
              ),
            const SizedBox(width: 6),
            Icon(Icons.chevron_right, color: AppTheme.textHint(context), size: 20),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\profile\presentation\widgets\widgets.dart`:

```dart
export 'profile_card.dart';
export 'profile_header.dart';
export 'avatar_picker_modal.dart';

```

`lib\features\schedule\presentation\pages\schedule_edit_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';

class ScheduleEditPage extends StatefulWidget {
  final bool isNew;
  final Reminder? reminder;

  const ScheduleEditPage({
    super.key,
    required this.isNew,
    this.reminder,
  });

  @override
  State<ScheduleEditPage> createState() => _ScheduleEditPageState();
}

class _ScheduleEditPageState extends State<ScheduleEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TimeOfDay _selectedTime;
  late RepeatType _selectedRepeat;
  late ReminderCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title ?? '');
    _descriptionController = TextEditingController(text: widget.reminder?.description ?? '');
    _selectedTime = widget.reminder != null
        ? TimeOfDay(hour: widget.reminder!.hour, minute: widget.reminder!.minute)
        : const TimeOfDay(hour: 9, minute: 0);
    _selectedRepeat = widget.reminder?.repeatType ?? RepeatType.daily;
    _selectedCategory = widget.reminder?.category ?? ReminderCategory.pressure;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _getRepeatText(BuildContext context, RepeatType type) {
    switch (type) {
      case RepeatType.daily:
        return context.l10n.repeatDaily;
      case RepeatType.weekly:
        return context.l10n.repeatWeekly;
      case RepeatType.monthly:
        return context.l10n.repeatMonthly;
      case RepeatType.weekdays:
        return context.l10n.repeatWeekdays;
    }
  }

  String _getCategoryText(BuildContext context, ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return context.l10n.metricPressure;
      case ReminderCategory.pulse:
        return context.l10n.metricPulse;
      case ReminderCategory.weight:
        return context.l10n.metricWeight;
      case ReminderCategory.sugar:
        return context.l10n.metricSugar;
      case ReminderCategory.other:
        return context.l10n.other;
    }
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _selectRepeat() {
    final repeatOptions = [RepeatType.daily, RepeatType.weekly, RepeatType.monthly];
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: repeatOptions.map((type) {
            return ListTile(
              title: Text(_getRepeatText(context, type)),
              trailing: _selectedRepeat == type ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedRepeat = type);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _selectCategory() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ReminderCategory.values.map((category) {
            return ListTile(
              title: Text(_getCategoryText(context, category)),
              trailing: _selectedCategory == category ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedCategory = category);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDefaultTitle(BuildContext context, ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return context.l10n.defaultReminderTitlePressure;
      case ReminderCategory.pulse:
        return context.l10n.defaultReminderTitlePulse;
      case ReminderCategory.weight:
        return context.l10n.defaultReminderTitleWeight;
      case ReminderCategory.sugar:
        return context.l10n.defaultReminderTitleSugar;
      case ReminderCategory.other:
        return context.l10n.defaultReminderTitleOther;
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim().isEmpty
        ? _getDefaultTitle(context, _selectedCategory)
        : _titleController.text.trim();
    
    final description = _descriptionController.text.trim().isEmpty
        ? context.l10n.defaultReminderDescription
        : _descriptionController.text.trim();

    final hasPermission = await NotificationService.hasPermissions();
    if (!hasPermission) {
      await NotificationService.requestPermissions();
    }

    Reminder? savedReminder;

    try {
      if (widget.isNew) {
        savedReminder = await ReminderService.add(
          title: title,
          description: description,
          hour: _selectedTime.hour,
          minute: _selectedTime.minute,
          repeatType: _selectedRepeat,
          category: _selectedCategory,
        );
      } else if (widget.reminder != null) {
        widget.reminder!.title = title;
        widget.reminder!.description = description;
        widget.reminder!.hour = _selectedTime.hour;
        widget.reminder!.minute = _selectedTime.minute;
        widget.reminder!.repeatType = _selectedRepeat;
        widget.reminder!.category = _selectedCategory;
        await ReminderService.update(widget.reminder!);
        savedReminder = widget.reminder;
      }

      if (savedReminder != null && savedReminder.isActive) {
        await NotificationService.scheduleReminder(savedReminder);
      }
    } catch (e) {
      debugPrint('Error saving reminder: $e');
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    if (widget.reminder == null) return;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.delete),
        content: Text(context.l10n.deleteEntry),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l10n.delete,
              style: const TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await NotificationService.cancelReminder(widget.reminder!);
      await ReminderService.delete(widget.reminder!.id);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeString = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: AppTheme.background(context),
      body: Stack(
        children: [
          // Gradient header background
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.isNew ? context.l10n.newReminder : context.l10n.editing,
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.surface(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScheduleFormSection(
                            title: context.l10n.notificationType,
                            child: ScheduleSelector(
                              icon: Icons.category_outlined,
                              label: context.l10n.notificationType,
                              value: _getCategoryText(context, _selectedCategory),
                              onTap: _selectCategory,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ScheduleFormSection(
                            title: context.l10n.timeAndRepeat,
                            child: Column(
                              children: [
                                ScheduleSelector(
                                  icon: Icons.access_time,
                                  label: context.l10n.time,
                                  value: timeString,
                                  onTap: _selectTime,
                                ),
                                const SizedBox(height: 12),
                                ScheduleSelector(
                                  icon: Icons.repeat,
                                  label: context.l10n.repeat,
                                  value: _getRepeatText(context, _selectedRepeat),
                                  onTap: _selectRepeat,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          ScheduleFormSection(
                            title: context.l10n.basicData,
                            child: Column(
                              children: [
                                ScheduleTextField(
                                  label: context.l10n.notificationTitle,
                                  controller: _titleController,
                                  hintText: _getDefaultTitle(context, _selectedCategory),
                                ),
                                const SizedBox(height: 12),
                                ScheduleTextField(
                                  label: context.l10n.description,
                                  controller: _descriptionController,
                                  hintText: context.l10n.defaultReminderDescription,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.purpleGradient,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF8E2DE2).withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
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
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(context.l10n.save),
                                ),
                              ),
                            ),
                          ),
                          if (!widget.isNew) ...[
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: _delete,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.error500,
                                  side: const BorderSide(color: AppColors.error500),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(context.l10n.delete),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\schedule\presentation\pages\schedule_page.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';
import 'schedule_edit_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Reminder> _activeReminders = [];
  List<Reminder> _inactiveReminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    setState(() {
      _activeReminders = ReminderService.getActive();
      _inactiveReminders = ReminderService.getInactive();
      _activeReminders.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
      _inactiveReminders.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
    });
  }

  IconData _getCategoryIcon(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return Icons.favorite_outline;
      case ReminderCategory.pulse:
        return Icons.monitor_heart_outlined;
      case ReminderCategory.weight:
        return Icons.monitor_weight_outlined;
      case ReminderCategory.sugar:
        return Icons.water_drop_outlined;
      case ReminderCategory.other:
        return Icons.notifications_outlined;
    }
  }

  Gradient _getCategoryGradient(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return AppColors.pressureGradient;
      case ReminderCategory.pulse:
        return AppColors.pulseGradient;
      case ReminderCategory.weight:
        return AppColors.weightGradient;
      case ReminderCategory.sugar:
        return AppColors.sugarGradient;
      case ReminderCategory.other:
        return AppColors.primaryGradient;
    }
  }

  String _getRepeatText(BuildContext context, RepeatType type) {
    switch (type) {
      case RepeatType.daily:
        return context.l10n.repeatDaily;
      case RepeatType.weekly:
        return context.l10n.repeatWeekly;
      case RepeatType.monthly:
        return context.l10n.repeatMonthly;
      case RepeatType.weekdays:
        return context.l10n.repeatWeekdays;
    }
  }

  String _getCategoryText(BuildContext context, ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return context.l10n.metricPressure;
      case ReminderCategory.pulse:
        return context.l10n.metricPulse;
      case ReminderCategory.weight:
        return context.l10n.metricWeight;
      case ReminderCategory.sugar:
        return context.l10n.metricSugar;
      case ReminderCategory.other:
        return context.l10n.other;
    }
  }

  Future<void> _toggleReminder(String id) async {
    final reminder = ReminderService.getById(id);
    if (reminder == null) return;
    
    final willBeActive = !reminder.isActive;
    await ReminderService.toggleActive(id);
    
    // Update notification
    if (willBeActive) {
      await NotificationService.scheduleReminder(reminder);
    } else {
      await NotificationService.cancelReminder(reminder);
    }
    
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background для верхней панели
          Container(
            height: MediaQuery.of(context).size.height * 0.35, // измените высоту, если у вас она другая
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Header
                ScheduleHeader(
                  onAddPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ScheduleEditPage(isNew: true),
                      ),
                    );
                    _loadReminders();
                  },
                ),
                // White Sheet with content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 24, bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: context.l10n.scheduleActiveCount,
                                      value: '${ReminderService.activeCount}',
                                      icon: Icons.notifications_active_outlined,
                                      gradient: AppColors.greenGradient,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: context.l10n.scheduleTotal,
                                      value: '${ReminderService.totalCount}',
                                      icon: Icons.schedule_outlined,
                                      gradient: AppColors.purpleGradient,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            if (_activeReminders.isNotEmpty)
                              ScheduleSection(
                                title: context.l10n.scheduleActive,
                                children: _activeReminders.map((reminder) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ScheduleItem(
                                      title: reminder.title,
                                      time: reminder.timeString,
                                      repeat: _getRepeatText(context, reminder.repeatType),
                                      category: _getCategoryText(context, reminder.category),
                                      icon: _getCategoryIcon(reminder.category),
                                      gradient: _getCategoryGradient(reminder.category),
                                      isActive: true,
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ScheduleEditPage(
                                              isNew: false,
                                              reminder: reminder,
                                            ),
                                          ),
                                        );
                                        _loadReminders();
                                      },
                                      onToggle: (_) => _toggleReminder(reminder.id),
                                    ),
                                  );
                                }).toList(),
                              ),
                            if (_activeReminders.isNotEmpty && _inactiveReminders.isNotEmpty)
                              const SizedBox(height: 16),
                            if (_inactiveReminders.isNotEmpty)
                              ScheduleSection(
                                title: context.l10n.scheduleInactive,
                                children: _inactiveReminders.map((reminder) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ScheduleItem(
                                      title: reminder.title,
                                      time: reminder.timeString,
                                      repeat: _getRepeatText(context, reminder.repeatType),
                                      category: _getCategoryText(context, reminder.category),
                                      icon: _getCategoryIcon(reminder.category),
                                      gradient: _getCategoryGradient(reminder.category),
                                      isActive: false,
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ScheduleEditPage(
                                              isNew: false,
                                              reminder: reminder,
                                            ),
                                          ),
                                        );
                                        _loadReminders();
                                      },
                                      onToggle: (_) => _toggleReminder(reminder.id),
                                    ),
                                  );
                                }).toList(),
                              ),
                            if (_activeReminders.isEmpty && _inactiveReminders.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.notifications_none_outlined,
                                        size: 64,
                                        color: AppTheme.textHint(context),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        context.l10n.scheduleManageReminders,
                                        style: TextStyle(
                                          color: AppTheme.textHint(context),
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_form_section.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleFormSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ScheduleFormSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.titleMedium.copyWith(
            fontSize: 16,
            color: AppColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration(context, radius: 20),
          child: child,
        ),
      ],
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_header.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleHeader extends StatelessWidget {
  final VoidCallback onAddPressed;

  const ScheduleHeader({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Расписание',
                style: TextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Управляйте напоминаниями',
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onAddPressed,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_item.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final String time;
  final String repeat;
  final String category;
  final IconData icon;
  final Gradient gradient;
  final bool isActive;
  final VoidCallback onTap;
  final ValueChanged<bool>? onToggle;

  const ScheduleItem({
    super.key,
    required this.title,
    required this.time,
    required this.repeat,
    required this.category,
    required this.icon,
    required this.gradient,
    required this.isActive,
    required this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.cardDecoration(context, radius: 18),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isActive ? gradient : null,
                color: isActive ? null : AppTheme.surfaceVariant(context),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : AppTheme.textHint(context),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      color: isActive ? AppTheme.textPrimary(context) : AppTheme.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppTheme.textHint(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textSecondary(context),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.textHint(context),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        repeat,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textHint(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: TextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isActive,
              onChanged: onToggle ?? (_) {},
            ),
          ],
        ),
      ),
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_section.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ScheduleSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyles.titleMedium.copyWith(
              color: AppTheme.textPrimary(context),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_selector.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleSelector extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const ScheduleSelector({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(
              fontSize: 14,
              color: AppTheme.textSecondary(context),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border(context)),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppTheme.textSecondary(context)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
                  ),
                ),
                Icon(Icons.chevron_right, color: AppTheme.textHint(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_stat_card.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const ScheduleStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withValues(alpha: 0.15),
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
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyles.headlineLarge.copyWith(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

```

`lib\features\schedule\presentation\widgets\schedule_text_field.dart`:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;

  const ScheduleTextField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            fontSize: 14,
            color: AppTheme.textSecondary(context),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyles.bodyMedium.copyWith(color: AppTheme.textHint(context)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            filled: true,
            fillColor: AppTheme.background(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppTheme.border(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppTheme.border(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}

```

`lib\features\schedule\presentation\widgets\widgets.dart`:

```dart
export 'schedule_header.dart';
export 'schedule_stat_card.dart';
export 'schedule_item.dart';
export 'schedule_section.dart';
export 'schedule_form_section.dart';
export 'schedule_text_field.dart';
export 'schedule_selector.dart';

```

`lib\l10n\app_localizations.dart`:

```dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @deleteEntry.
  ///
  /// In ru, this message translates to:
  /// **'Удалить запись?'**
  String get deleteEntry;

  /// No description provided for @notSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Не указано'**
  String get notSpecified;

  /// No description provided for @noData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных'**
  String get noData;

  /// No description provided for @yesterday.
  ///
  /// In ru, this message translates to:
  /// **'Вчера'**
  String get yesterday;

  /// No description provided for @today.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня'**
  String get today;

  /// No description provided for @daysAgo.
  ///
  /// In ru, this message translates to:
  /// **'{count} дн. назад'**
  String daysAgo(int count);

  /// No description provided for @addEntryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добавить запись'**
  String get addEntryTitle;

  /// No description provided for @choosePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Выберите категорию(ии) сверху'**
  String get choosePlaceholder;

  /// No description provided for @selectedPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Выбрано: '**
  String get selectedPrefix;

  /// No description provided for @greetingMorning.
  ///
  /// In ru, this message translates to:
  /// **'Доброе утро,'**
  String get greetingMorning;

  /// No description provided for @greetingDay.
  ///
  /// In ru, this message translates to:
  /// **'Добрый день,'**
  String get greetingDay;

  /// No description provided for @greetingEvening.
  ///
  /// In ru, this message translates to:
  /// **'Добрый вечер,'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In ru, this message translates to:
  /// **'Доброй ночи,'**
  String get greetingNight;

  /// No description provided for @defaultUserName.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь'**
  String get defaultUserName;

  /// No description provided for @unitMmHg.
  ///
  /// In ru, this message translates to:
  /// **'мм рт.ст.'**
  String get unitMmHg;

  /// No description provided for @unitBpm.
  ///
  /// In ru, this message translates to:
  /// **'уд/мин'**
  String get unitBpm;

  /// No description provided for @unitMmol.
  ///
  /// In ru, this message translates to:
  /// **'ммоль/л'**
  String get unitMmol;

  /// No description provided for @unitKg.
  ///
  /// In ru, this message translates to:
  /// **'кг'**
  String get unitKg;

  /// No description provided for @unitCm.
  ///
  /// In ru, this message translates to:
  /// **'см'**
  String get unitCm;

  /// No description provided for @profile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать профиль'**
  String get editProfile;

  /// No description provided for @personalData.
  ///
  /// In ru, this message translates to:
  /// **'Личные данные'**
  String get personalData;

  /// No description provided for @physicalParams.
  ///
  /// In ru, this message translates to:
  /// **'Физические параметры'**
  String get physicalParams;

  /// No description provided for @firstName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get firstName;

  /// No description provided for @birthDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get birthDate;

  /// No description provided for @height.
  ///
  /// In ru, this message translates to:
  /// **'Рост'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get weight;

  /// No description provided for @age.
  ///
  /// In ru, this message translates to:
  /// **'Возраст'**
  String get age;

  /// No description provided for @yearsOld.
  ///
  /// In ru, this message translates to:
  /// **'лет'**
  String get yearsOld;

  /// No description provided for @clearData.
  ///
  /// In ru, this message translates to:
  /// **'Очистить данные'**
  String get clearData;

  /// No description provided for @home.
  ///
  /// In ru, this message translates to:
  /// **'Главная'**
  String get home;

  /// No description provided for @history.
  ///
  /// In ru, this message translates to:
  /// **'История'**
  String get history;

  /// No description provided for @schedule.
  ///
  /// In ru, this message translates to:
  /// **'Расписание'**
  String get schedule;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @metricPressure.
  ///
  /// In ru, this message translates to:
  /// **'Давление'**
  String get metricPressure;

  /// No description provided for @metricPulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get metricPulse;

  /// No description provided for @metricWeight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get metricWeight;

  /// No description provided for @metricSugar.
  ///
  /// In ru, this message translates to:
  /// **'Сахар'**
  String get metricSugar;

  /// No description provided for @metricPressureUpper.
  ///
  /// In ru, this message translates to:
  /// **'ДАВЛЕНИЕ'**
  String get metricPressureUpper;

  /// No description provided for @metricPulseUpper.
  ///
  /// In ru, this message translates to:
  /// **'ПУЛЬС'**
  String get metricPulseUpper;

  /// No description provided for @metricWeightUpper.
  ///
  /// In ru, this message translates to:
  /// **'ВЕС'**
  String get metricWeightUpper;

  /// No description provided for @metricSugarUpper.
  ///
  /// In ru, this message translates to:
  /// **'САХАР'**
  String get metricSugarUpper;

  /// No description provided for @historyNoRecords.
  ///
  /// In ru, this message translates to:
  /// **'Записей пока нет'**
  String get historyNoRecords;

  /// No description provided for @historyAddFirst.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте первое измерение'**
  String get historyAddFirst;

  /// No description provided for @historyYourMeasurements.
  ///
  /// In ru, this message translates to:
  /// **'Ваши измерения'**
  String get historyYourMeasurements;

  /// No description provided for @allRecords.
  ///
  /// In ru, this message translates to:
  /// **'Все записи'**
  String get allRecords;

  /// No description provided for @onboardingWelcome.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать!'**
  String get onboardingWelcome;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Давайте познакомимся'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingQuestion.
  ///
  /// In ru, this message translates to:
  /// **'Как к вам можно обращаться?'**
  String get onboardingQuestion;

  /// No description provided for @onboardingNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Ваше имя'**
  String get onboardingNameHint;

  /// No description provided for @onboardingContinue.
  ///
  /// In ru, this message translates to:
  /// **'Далее'**
  String get onboardingContinue;

  /// No description provided for @onboardingFinish.
  ///
  /// In ru, this message translates to:
  /// **'Начать'**
  String get onboardingFinish;

  /// No description provided for @onboardingBirthDateTitle.
  ///
  /// In ru, this message translates to:
  /// **'Дата рождения'**
  String get onboardingBirthDateTitle;

  /// No description provided for @onboardingBirthDateSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это поможет рассчитать ваш возраст'**
  String get onboardingBirthDateSubtitle;

  /// No description provided for @onboardingSelectDate.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get onboardingSelectDate;

  /// No description provided for @onboardingHeightTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш рост'**
  String get onboardingHeightTitle;

  /// No description provided for @onboardingHeightSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите ваш рост в сантиметрах'**
  String get onboardingHeightSubtitle;

  /// No description provided for @onboardingWeightTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш вес'**
  String get onboardingWeightTitle;

  /// No description provided for @onboardingWeightSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Укажите ваш вес в килограммах'**
  String get onboardingWeightSubtitle;

  /// No description provided for @upperPressure.
  ///
  /// In ru, this message translates to:
  /// **'Верхнее давление'**
  String get upperPressure;

  /// No description provided for @lowerPressure.
  ///
  /// In ru, this message translates to:
  /// **'Нижнее давление'**
  String get lowerPressure;

  /// No description provided for @pulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get pulse;

  /// No description provided for @sugarLevel.
  ///
  /// In ru, this message translates to:
  /// **'Уровень сахара'**
  String get sugarLevel;

  /// No description provided for @dynamics.
  ///
  /// In ru, this message translates to:
  /// **'Динамика'**
  String get dynamics;

  /// No description provided for @week.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get week;

  /// No description provided for @month.
  ///
  /// In ru, this message translates to:
  /// **'Месяц'**
  String get month;

  /// No description provided for @year.
  ///
  /// In ru, this message translates to:
  /// **'Год'**
  String get year;

  /// No description provided for @noDataForPeriod.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных за этот период'**
  String get noDataForPeriod;

  /// No description provided for @weekdayMon.
  ///
  /// In ru, this message translates to:
  /// **'Пн'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In ru, this message translates to:
  /// **'Вт'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In ru, this message translates to:
  /// **'Ср'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In ru, this message translates to:
  /// **'Чт'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In ru, this message translates to:
  /// **'Пт'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In ru, this message translates to:
  /// **'Сб'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In ru, this message translates to:
  /// **'Вс'**
  String get weekdaySun;

  /// No description provided for @scheduleManageReminders.
  ///
  /// In ru, this message translates to:
  /// **'Управляйте напоминаниями'**
  String get scheduleManageReminders;

  /// No description provided for @scheduleActive.
  ///
  /// In ru, this message translates to:
  /// **'Активные'**
  String get scheduleActive;

  /// No description provided for @scheduleInactive.
  ///
  /// In ru, this message translates to:
  /// **'Неактивные'**
  String get scheduleInactive;

  /// No description provided for @scheduleActiveCount.
  ///
  /// In ru, this message translates to:
  /// **'Активных'**
  String get scheduleActiveCount;

  /// No description provided for @scheduleTotal.
  ///
  /// In ru, this message translates to:
  /// **'Всего'**
  String get scheduleTotal;

  /// No description provided for @newReminder.
  ///
  /// In ru, this message translates to:
  /// **'Новое напоминание'**
  String get newReminder;

  /// No description provided for @editing.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get editing;

  /// No description provided for @basicData.
  ///
  /// In ru, this message translates to:
  /// **'Основные данные'**
  String get basicData;

  /// No description provided for @notificationTitle.
  ///
  /// In ru, this message translates to:
  /// **'Название уведомления (необязательно)'**
  String get notificationTitle;

  /// No description provided for @description.
  ///
  /// In ru, this message translates to:
  /// **'Описание (необязательно)'**
  String get description;

  /// No description provided for @timeAndRepeat.
  ///
  /// In ru, this message translates to:
  /// **'Время и повтор'**
  String get timeAndRepeat;

  /// No description provided for @time.
  ///
  /// In ru, this message translates to:
  /// **'Время'**
  String get time;

  /// No description provided for @repeat.
  ///
  /// In ru, this message translates to:
  /// **'Повтор'**
  String get repeat;

  /// No description provided for @startDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата начала'**
  String get startDate;

  /// No description provided for @notificationStyle.
  ///
  /// In ru, this message translates to:
  /// **'Оформление уведомления'**
  String get notificationStyle;

  /// No description provided for @notificationType.
  ///
  /// In ru, this message translates to:
  /// **'Тип уведомления'**
  String get notificationType;

  /// No description provided for @cardColor.
  ///
  /// In ru, this message translates to:
  /// **'Цвет карточки'**
  String get cardColor;

  /// No description provided for @repeatDaily.
  ///
  /// In ru, this message translates to:
  /// **'Каждый день'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In ru, this message translates to:
  /// **'Каждую неделю'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In ru, this message translates to:
  /// **'Раз в месяц'**
  String get repeatMonthly;

  /// No description provided for @repeatWeekdays.
  ///
  /// In ru, this message translates to:
  /// **'По будням'**
  String get repeatWeekdays;

  /// No description provided for @notifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get notifications;

  /// No description provided for @reminders.
  ///
  /// In ru, this message translates to:
  /// **'Напоминания'**
  String get reminders;

  /// No description provided for @dailySummary.
  ///
  /// In ru, this message translates to:
  /// **'Ежедневная сводка'**
  String get dailySummary;

  /// No description provided for @appearance.
  ///
  /// In ru, this message translates to:
  /// **'Внешний вид'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In ru, this message translates to:
  /// **'Тема'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In ru, this message translates to:
  /// **'Светлая'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ru, this message translates to:
  /// **'Тёмная'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In ru, this message translates to:
  /// **'Системная'**
  String get themeSystem;

  /// No description provided for @fontSize.
  ///
  /// In ru, this message translates to:
  /// **'Размер текста'**
  String get fontSize;

  /// No description provided for @fontSizeNormal.
  ///
  /// In ru, this message translates to:
  /// **'Обычный'**
  String get fontSizeNormal;

  /// No description provided for @other.
  ///
  /// In ru, this message translates to:
  /// **'Прочее'**
  String get other;

  /// No description provided for @aboutApp.
  ///
  /// In ru, this message translates to:
  /// **'О приложении'**
  String get aboutApp;

  /// No description provided for @typeStandard.
  ///
  /// In ru, this message translates to:
  /// **'Стандартное'**
  String get typeStandard;

  /// No description provided for @colorPurple.
  ///
  /// In ru, this message translates to:
  /// **'Фиолетовый'**
  String get colorPurple;

  /// No description provided for @measurePressure.
  ///
  /// In ru, this message translates to:
  /// **'Измерить давление'**
  String get measurePressure;

  /// No description provided for @eveningMeasurement.
  ///
  /// In ru, this message translates to:
  /// **'Вечернее измерение'**
  String get eveningMeasurement;

  /// No description provided for @weighing.
  ///
  /// In ru, this message translates to:
  /// **'Взвешивание'**
  String get weighing;

  /// No description provided for @recordSugar.
  ///
  /// In ru, this message translates to:
  /// **'Записать сахар'**
  String get recordSugar;

  /// No description provided for @doctorVisit.
  ///
  /// In ru, this message translates to:
  /// **'Визит к врачу'**
  String get doctorVisit;

  /// No description provided for @notificationPermissionDenied.
  ///
  /// In ru, this message translates to:
  /// **'Разрешение на уведомления не получено. Включите в настройках.'**
  String get notificationPermissionDenied;

  /// No description provided for @defaultReminderTitlePressure.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте давление!'**
  String get defaultReminderTitlePressure;

  /// No description provided for @defaultReminderTitlePulse.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте пульс!'**
  String get defaultReminderTitlePulse;

  /// No description provided for @defaultReminderTitleWeight.
  ///
  /// In ru, this message translates to:
  /// **'Время взвеситься!'**
  String get defaultReminderTitleWeight;

  /// No description provided for @defaultReminderTitleSugar.
  ///
  /// In ru, this message translates to:
  /// **'Измерьте уровень сахара!'**
  String get defaultReminderTitleSugar;

  /// No description provided for @defaultReminderTitleOther.
  ///
  /// In ru, this message translates to:
  /// **'Напоминание'**
  String get defaultReminderTitleOther;

  /// No description provided for @defaultReminderDescription.
  ///
  /// In ru, this message translates to:
  /// **'Регулярные измерения важны для здоровья'**
  String get defaultReminderDescription;

  /// No description provided for @notificationCategoryPressure.
  ///
  /// In ru, this message translates to:
  /// **'Давление'**
  String get notificationCategoryPressure;

  /// No description provided for @notificationCategoryPulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get notificationCategoryPulse;

  /// No description provided for @notificationCategoryWeight.
  ///
  /// In ru, this message translates to:
  /// **'Вес'**
  String get notificationCategoryWeight;

  /// No description provided for @notificationCategorySugar.
  ///
  /// In ru, this message translates to:
  /// **'Сахар'**
  String get notificationCategorySugar;

  /// No description provided for @notificationCategoryOther.
  ///
  /// In ru, this message translates to:
  /// **'Прочее'**
  String get notificationCategoryOther;

  /// No description provided for @notificationCategoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get notificationCategoryLabel;

  /// No description provided for @sex.
  ///
  /// In ru, this message translates to:
  /// **'Пол'**
  String get sex;

  /// No description provided for @sexMale.
  ///
  /// In ru, this message translates to:
  /// **'Мужской'**
  String get sexMale;

  /// No description provided for @sexFemale.
  ///
  /// In ru, this message translates to:
  /// **'Женский'**
  String get sexFemale;

  /// No description provided for @onboardingSexTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ваш пол'**
  String get onboardingSexTitle;

  /// No description provided for @onboardingSexSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Необходимо для точного анализа здоровья'**
  String get onboardingSexSubtitle;

  /// No description provided for @analysis.
  ///
  /// In ru, this message translates to:
  /// **'Анализ'**
  String get analysis;

  /// No description provided for @analysisTitle.
  ///
  /// In ru, this message translates to:
  /// **'Анализ здоровья'**
  String get analysisTitle;

  /// No description provided for @analysisSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Результаты ML-моделей'**
  String get analysisSubtitle;

  /// No description provided for @analysisBased.
  ///
  /// In ru, this message translates to:
  /// **'На основе ваших данных'**
  String get analysisBased;

  /// No description provided for @analysisNoData.
  ///
  /// In ru, this message translates to:
  /// **'Недостаточно данных для анализа'**
  String get analysisNoData;

  /// No description provided for @analysisNoDataHint.
  ///
  /// In ru, this message translates to:
  /// **'Добавьте измерения давления и пульса'**
  String get analysisNoDataHint;

  /// No description provided for @analysisHypertension.
  ///
  /// In ru, this message translates to:
  /// **'Риск гипертонии'**
  String get analysisHypertension;

  /// No description provided for @analysisKidney.
  ///
  /// In ru, this message translates to:
  /// **'Риск болезней почек'**
  String get analysisKidney;

  /// No description provided for @analysisConfidence.
  ///
  /// In ru, this message translates to:
  /// **'Уверенность модели'**
  String get analysisConfidence;

  /// No description provided for @analysisSBP.
  ///
  /// In ru, this message translates to:
  /// **'Сист. давление'**
  String get analysisSBP;

  /// No description provided for @analysisDBP.
  ///
  /// In ru, this message translates to:
  /// **'Диаст. давление'**
  String get analysisDBP;

  /// No description provided for @analysisPulse.
  ///
  /// In ru, this message translates to:
  /// **'Пульс'**
  String get analysisPulse;

  /// No description provided for @analysisBMI.
  ///
  /// In ru, this message translates to:
  /// **'ИМТ'**
  String get analysisBMI;

  /// No description provided for @analysisNormal.
  ///
  /// In ru, this message translates to:
  /// **'Норма'**
  String get analysisNormal;

  /// No description provided for @analysisPrehypertension.
  ///
  /// In ru, this message translates to:
  /// **'Предгипертензия'**
  String get analysisPrehypertension;

  /// No description provided for @analysisStage1.
  ///
  /// In ru, this message translates to:
  /// **'Гипертония 1 ст.'**
  String get analysisStage1;

  /// No description provided for @analysisStage2.
  ///
  /// In ru, this message translates to:
  /// **'Гипертония 2 ст.'**
  String get analysisStage2;

  /// No description provided for @analysisLowRisk.
  ///
  /// In ru, this message translates to:
  /// **'Низкий риск'**
  String get analysisLowRisk;

  /// No description provided for @analysisHighRisk.
  ///
  /// In ru, this message translates to:
  /// **'Повышенный риск'**
  String get analysisHighRisk;

  /// No description provided for @analysisModelNotLoaded.
  ///
  /// In ru, this message translates to:
  /// **'Модель не загружена'**
  String get analysisModelNotLoaded;

  /// No description provided for @analysisCategories.
  ///
  /// In ru, this message translates to:
  /// **'Категории показателей'**
  String get analysisCategories;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

```

`lib\l10n\app_localizations_en.dart`:

```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteEntry => 'Delete entry?';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get noData => 'No data';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get today => 'Today';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get addEntryTitle => 'Add entry';

  @override
  String get choosePlaceholder => 'Select category(ies) above';

  @override
  String get selectedPrefix => 'Selected: ';

  @override
  String get greetingMorning => 'Good morning,';

  @override
  String get greetingDay => 'Good afternoon,';

  @override
  String get greetingEvening => 'Good evening,';

  @override
  String get greetingNight => 'Good night,';

  @override
  String get defaultUserName => 'User';

  @override
  String get unitMmHg => 'mmHg';

  @override
  String get unitBpm => 'bpm';

  @override
  String get unitMmol => 'mmol/L';

  @override
  String get unitKg => 'kg';

  @override
  String get unitCm => 'cm';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get personalData => 'Personal data';

  @override
  String get physicalParams => 'Physical parameters';

  @override
  String get firstName => 'First name';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get age => 'Age';

  @override
  String get yearsOld => 'years old';

  @override
  String get clearData => 'Clear data';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get schedule => 'Schedule';

  @override
  String get settings => 'Settings';

  @override
  String get metricPressure => 'Pressure';

  @override
  String get metricPulse => 'Pulse';

  @override
  String get metricWeight => 'Weight';

  @override
  String get metricSugar => 'Sugar';

  @override
  String get metricPressureUpper => 'PRESSURE';

  @override
  String get metricPulseUpper => 'PULSE';

  @override
  String get metricWeightUpper => 'WEIGHT';

  @override
  String get metricSugarUpper => 'SUGAR';

  @override
  String get historyNoRecords => 'No records yet';

  @override
  String get historyAddFirst => 'Add your first measurement';

  @override
  String get historyYourMeasurements => 'Your measurements';

  @override
  String get allRecords => 'All records';

  @override
  String get onboardingWelcome => 'Welcome!';

  @override
  String get onboardingSubtitle => 'Let\'s get to know each other';

  @override
  String get onboardingQuestion => 'What should we call you?';

  @override
  String get onboardingNameHint => 'Your name';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingFinish => 'Start';

  @override
  String get onboardingBirthDateTitle => 'Date of birth';

  @override
  String get onboardingBirthDateSubtitle => 'This will help calculate your age';

  @override
  String get onboardingSelectDate => 'Select date';

  @override
  String get onboardingHeightTitle => 'Your height';

  @override
  String get onboardingHeightSubtitle => 'Enter your height in centimeters';

  @override
  String get onboardingWeightTitle => 'Your weight';

  @override
  String get onboardingWeightSubtitle => 'Enter your weight in kilograms';

  @override
  String get upperPressure => 'Upper pressure';

  @override
  String get lowerPressure => 'Lower pressure';

  @override
  String get pulse => 'Pulse';

  @override
  String get sugarLevel => 'Sugar level';

  @override
  String get dynamics => 'Dynamics';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get noDataForPeriod => 'No data for this period';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get scheduleManageReminders => 'Manage reminders';

  @override
  String get scheduleActive => 'Active';

  @override
  String get scheduleInactive => 'Inactive';

  @override
  String get scheduleActiveCount => 'Active';

  @override
  String get scheduleTotal => 'Total';

  @override
  String get newReminder => 'New reminder';

  @override
  String get editing => 'Editing';

  @override
  String get basicData => 'Basic data';

  @override
  String get notificationTitle => 'Notification title (optional)';

  @override
  String get description => 'Description (optional)';

  @override
  String get timeAndRepeat => 'Time and repeat';

  @override
  String get time => 'Time';

  @override
  String get repeat => 'Repeat';

  @override
  String get startDate => 'Start date';

  @override
  String get notificationStyle => 'Notification style';

  @override
  String get notificationType => 'Notification type';

  @override
  String get cardColor => 'Card color';

  @override
  String get repeatDaily => 'Every day';

  @override
  String get repeatWeekly => 'Every week';

  @override
  String get repeatMonthly => 'Once a month';

  @override
  String get repeatWeekdays => 'Weekdays';

  @override
  String get notifications => 'Notifications';

  @override
  String get reminders => 'Reminders';

  @override
  String get dailySummary => 'Daily summary';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get fontSize => 'Font size';

  @override
  String get fontSizeNormal => 'Normal';

  @override
  String get other => 'Other';

  @override
  String get aboutApp => 'About app';

  @override
  String get typeStandard => 'Standard';

  @override
  String get colorPurple => 'Purple';

  @override
  String get measurePressure => 'Measure pressure';

  @override
  String get eveningMeasurement => 'Evening measurement';

  @override
  String get weighing => 'Weighing';

  @override
  String get recordSugar => 'Record sugar';

  @override
  String get doctorVisit => 'Doctor visit';

  @override
  String get notificationPermissionDenied =>
      'Notification permission denied. Please enable in settings.';

  @override
  String get defaultReminderTitlePressure => 'Measure your pressure!';

  @override
  String get defaultReminderTitlePulse => 'Check your pulse!';

  @override
  String get defaultReminderTitleWeight => 'Time to weigh yourself!';

  @override
  String get defaultReminderTitleSugar => 'Check your sugar level!';

  @override
  String get defaultReminderTitleOther => 'Reminder';

  @override
  String get defaultReminderDescription =>
      'Regular measurements are important for your health';

  @override
  String get notificationCategoryPressure => 'Pressure';

  @override
  String get notificationCategoryPulse => 'Pulse';

  @override
  String get notificationCategoryWeight => 'Weight';

  @override
  String get notificationCategorySugar => 'Sugar';

  @override
  String get notificationCategoryOther => 'Other';

  @override
  String get notificationCategoryLabel => 'Category';

  @override
  String get sex => 'Sex';

  @override
  String get sexMale => 'Male';

  @override
  String get sexFemale => 'Female';

  @override
  String get onboardingSexTitle => 'Your sex';

  @override
  String get onboardingSexSubtitle => 'Needed for accurate health analysis';

  @override
  String get analysis => 'Analysis';

  @override
  String get analysisTitle => 'Health Analysis';

  @override
  String get analysisSubtitle => 'ML model results';

  @override
  String get analysisBased => 'Based on your data';

  @override
  String get analysisNoData => 'Insufficient data for analysis';

  @override
  String get analysisNoDataHint => 'Add pressure and pulse measurements';

  @override
  String get analysisHypertension => 'Hypertension risk';

  @override
  String get analysisKidney => 'Kidney disease risk';

  @override
  String get analysisConfidence => 'Model confidence';

  @override
  String get analysisSBP => 'Systolic BP';

  @override
  String get analysisDBP => 'Diastolic BP';

  @override
  String get analysisPulse => 'Pulse';

  @override
  String get analysisBMI => 'BMI';

  @override
  String get analysisNormal => 'Normal';

  @override
  String get analysisPrehypertension => 'Prehypertension';

  @override
  String get analysisStage1 => 'Stage 1 hypertension';

  @override
  String get analysisStage2 => 'Stage 2 hypertension';

  @override
  String get analysisLowRisk => 'Low risk';

  @override
  String get analysisHighRisk => 'High risk';

  @override
  String get analysisModelNotLoaded => 'Model not loaded';

  @override
  String get analysisCategories => 'Indicator categories';
}

```

`lib\l10n\app_localizations_ru.dart`:

```dart
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get edit => 'Редактировать';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteEntry => 'Удалить запись?';

  @override
  String get notSpecified => 'Не указано';

  @override
  String get noData => 'Нет данных';

  @override
  String get yesterday => 'Вчера';

  @override
  String get today => 'Сегодня';

  @override
  String daysAgo(int count) {
    return '$count дн. назад';
  }

  @override
  String get addEntryTitle => 'Добавить запись';

  @override
  String get choosePlaceholder => 'Выберите категорию(ии) сверху';

  @override
  String get selectedPrefix => 'Выбрано: ';

  @override
  String get greetingMorning => 'Доброе утро,';

  @override
  String get greetingDay => 'Добрый день,';

  @override
  String get greetingEvening => 'Добрый вечер,';

  @override
  String get greetingNight => 'Доброй ночи,';

  @override
  String get defaultUserName => 'Пользователь';

  @override
  String get unitMmHg => 'мм рт.ст.';

  @override
  String get unitBpm => 'уд/мин';

  @override
  String get unitMmol => 'ммоль/л';

  @override
  String get unitKg => 'кг';

  @override
  String get unitCm => 'см';

  @override
  String get profile => 'Профиль';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get personalData => 'Личные данные';

  @override
  String get physicalParams => 'Физические параметры';

  @override
  String get firstName => 'Имя';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get height => 'Рост';

  @override
  String get weight => 'Вес';

  @override
  String get age => 'Возраст';

  @override
  String get yearsOld => 'лет';

  @override
  String get clearData => 'Очистить данные';

  @override
  String get home => 'Главная';

  @override
  String get history => 'История';

  @override
  String get schedule => 'Расписание';

  @override
  String get settings => 'Настройки';

  @override
  String get metricPressure => 'Давление';

  @override
  String get metricPulse => 'Пульс';

  @override
  String get metricWeight => 'Вес';

  @override
  String get metricSugar => 'Сахар';

  @override
  String get metricPressureUpper => 'ДАВЛЕНИЕ';

  @override
  String get metricPulseUpper => 'ПУЛЬС';

  @override
  String get metricWeightUpper => 'ВЕС';

  @override
  String get metricSugarUpper => 'САХАР';

  @override
  String get historyNoRecords => 'Записей пока нет';

  @override
  String get historyAddFirst => 'Добавьте первое измерение';

  @override
  String get historyYourMeasurements => 'Ваши измерения';

  @override
  String get allRecords => 'Все записи';

  @override
  String get onboardingWelcome => 'Добро пожаловать!';

  @override
  String get onboardingSubtitle => 'Давайте познакомимся';

  @override
  String get onboardingQuestion => 'Как к вам можно обращаться?';

  @override
  String get onboardingNameHint => 'Ваше имя';

  @override
  String get onboardingContinue => 'Далее';

  @override
  String get onboardingFinish => 'Начать';

  @override
  String get onboardingBirthDateTitle => 'Дата рождения';

  @override
  String get onboardingBirthDateSubtitle =>
      'Это поможет рассчитать ваш возраст';

  @override
  String get onboardingSelectDate => 'Выберите дату';

  @override
  String get onboardingHeightTitle => 'Ваш рост';

  @override
  String get onboardingHeightSubtitle => 'Укажите ваш рост в сантиметрах';

  @override
  String get onboardingWeightTitle => 'Ваш вес';

  @override
  String get onboardingWeightSubtitle => 'Укажите ваш вес в килограммах';

  @override
  String get upperPressure => 'Верхнее давление';

  @override
  String get lowerPressure => 'Нижнее давление';

  @override
  String get pulse => 'Пульс';

  @override
  String get sugarLevel => 'Уровень сахара';

  @override
  String get dynamics => 'Динамика';

  @override
  String get week => 'Неделя';

  @override
  String get month => 'Месяц';

  @override
  String get year => 'Год';

  @override
  String get noDataForPeriod => 'Нет данных за этот период';

  @override
  String get weekdayMon => 'Пн';

  @override
  String get weekdayTue => 'Вт';

  @override
  String get weekdayWed => 'Ср';

  @override
  String get weekdayThu => 'Чт';

  @override
  String get weekdayFri => 'Пт';

  @override
  String get weekdaySat => 'Сб';

  @override
  String get weekdaySun => 'Вс';

  @override
  String get scheduleManageReminders => 'Управляйте напоминаниями';

  @override
  String get scheduleActive => 'Активные';

  @override
  String get scheduleInactive => 'Неактивные';

  @override
  String get scheduleActiveCount => 'Активных';

  @override
  String get scheduleTotal => 'Всего';

  @override
  String get newReminder => 'Новое напоминание';

  @override
  String get editing => 'Редактирование';

  @override
  String get basicData => 'Основные данные';

  @override
  String get notificationTitle => 'Название уведомления (необязательно)';

  @override
  String get description => 'Описание (необязательно)';

  @override
  String get timeAndRepeat => 'Время и повтор';

  @override
  String get time => 'Время';

  @override
  String get repeat => 'Повтор';

  @override
  String get startDate => 'Дата начала';

  @override
  String get notificationStyle => 'Оформление уведомления';

  @override
  String get notificationType => 'Тип уведомления';

  @override
  String get cardColor => 'Цвет карточки';

  @override
  String get repeatDaily => 'Каждый день';

  @override
  String get repeatWeekly => 'Каждую неделю';

  @override
  String get repeatMonthly => 'Раз в месяц';

  @override
  String get repeatWeekdays => 'По будням';

  @override
  String get notifications => 'Уведомления';

  @override
  String get reminders => 'Напоминания';

  @override
  String get dailySummary => 'Ежедневная сводка';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get theme => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get themeSystem => 'Системная';

  @override
  String get fontSize => 'Размер текста';

  @override
  String get fontSizeNormal => 'Обычный';

  @override
  String get other => 'Прочее';

  @override
  String get aboutApp => 'О приложении';

  @override
  String get typeStandard => 'Стандартное';

  @override
  String get colorPurple => 'Фиолетовый';

  @override
  String get measurePressure => 'Измерить давление';

  @override
  String get eveningMeasurement => 'Вечернее измерение';

  @override
  String get weighing => 'Взвешивание';

  @override
  String get recordSugar => 'Записать сахар';

  @override
  String get doctorVisit => 'Визит к врачу';

  @override
  String get notificationPermissionDenied =>
      'Разрешение на уведомления не получено. Включите в настройках.';

  @override
  String get defaultReminderTitlePressure => 'Измерьте давление!';

  @override
  String get defaultReminderTitlePulse => 'Измерьте пульс!';

  @override
  String get defaultReminderTitleWeight => 'Время взвеситься!';

  @override
  String get defaultReminderTitleSugar => 'Измерьте уровень сахара!';

  @override
  String get defaultReminderTitleOther => 'Напоминание';

  @override
  String get defaultReminderDescription =>
      'Регулярные измерения важны для здоровья';

  @override
  String get notificationCategoryPressure => 'Давление';

  @override
  String get notificationCategoryPulse => 'Пульс';

  @override
  String get notificationCategoryWeight => 'Вес';

  @override
  String get notificationCategorySugar => 'Сахар';

  @override
  String get notificationCategoryOther => 'Прочее';

  @override
  String get notificationCategoryLabel => 'Категория';

  @override
  String get sex => 'Пол';

  @override
  String get sexMale => 'Мужской';

  @override
  String get sexFemale => 'Женский';

  @override
  String get onboardingSexTitle => 'Ваш пол';

  @override
  String get onboardingSexSubtitle => 'Необходимо для точного анализа здоровья';

  @override
  String get analysis => 'Анализ';

  @override
  String get analysisTitle => 'Анализ здоровья';

  @override
  String get analysisSubtitle => 'Результаты ML-моделей';

  @override
  String get analysisBased => 'На основе ваших данных';

  @override
  String get analysisNoData => 'Недостаточно данных для анализа';

  @override
  String get analysisNoDataHint => 'Добавьте измерения давления и пульса';

  @override
  String get analysisHypertension => 'Риск гипертонии';

  @override
  String get analysisKidney => 'Риск болезней почек';

  @override
  String get analysisConfidence => 'Уверенность модели';

  @override
  String get analysisSBP => 'Сист. давление';

  @override
  String get analysisDBP => 'Диаст. давление';

  @override
  String get analysisPulse => 'Пульс';

  @override
  String get analysisBMI => 'ИМТ';

  @override
  String get analysisNormal => 'Норма';

  @override
  String get analysisPrehypertension => 'Предгипертензия';

  @override
  String get analysisStage1 => 'Гипертония 1 ст.';

  @override
  String get analysisStage2 => 'Гипертония 2 ст.';

  @override
  String get analysisLowRisk => 'Низкий риск';

  @override
  String get analysisHighRisk => 'Повышенный риск';

  @override
  String get analysisModelNotLoaded => 'Модель не загружена';

  @override
  String get analysisCategories => 'Категории показателей';
}

```

`lib\main.dart`:

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'l10n/app_localizations.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/history/presentation/pages/history_page.dart';
import 'features/schedule/presentation/pages/schedule_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'core/helpers/modal_helper.dart';
import 'core/theme/colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/text_styles.dart';
import 'core/i18n/l10n_extension.dart';
import 'data/services/profile_service.dart';
import 'data/services/entry_service.dart';
import 'data/services/reminder_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/prediction_service.dart';
import 'data/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Убрали запрос storage permission - больше не нужен
  
  await ProfileService.init();
  await EntryService.init();
  await ReminderService.init();
  await NotificationService.init();
  await ThemeService.init();
  PredictionService.init();
  runApp(const MyApp());
}
/// Проверяет, нужен ли onboarding
bool get needsOnboarding => !ProfileService.hasProfile();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: ThemeService.instance,
      builder: (context, _, __) {
        return MaterialApp(
          title: 'Health Oracle',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeService.instance.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: needsOnboarding
              ? const OnboardingPage()
              : MainNavigator(key: MainNavigator.navigatorKey),
        );
      },
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  static final GlobalKey<_MainNavigatorState> navigatorKey =
      GlobalKey<_MainNavigatorState>();

  static void goToHistory() {
    navigatorKey.currentState?.goToHistory();
  }

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const SchedulePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void goToHistory() {
    setState(() {
      _currentIndex = 1; // История - индекс 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.surface(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.home_outlined,
                      Icons.home,
                      context.l10n.home,
                      0,
                    ),
                    _buildNavItem(
                      Icons.history_outlined,
                      Icons.history,
                      context.l10n.history,
                      1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 54),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.calendar_month_outlined,
                      Icons.calendar_month,
                      context.l10n.schedule,
                      2,
                    ),
                    _buildNavItem(
                      Icons.person_outlined,
                      Icons.person,
                      context.l10n.profile,
                      3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildCenterButton(),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDark ? Colors.white : AppColors.primary;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? selectedColor : AppTheme.textHint(context),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyles.labelSmall.copyWith(
                fontSize: 10,
                color: isSelected ? selectedColor : AppTheme.textHint(context),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => ModalHelper.showBottomEntryMenu(context),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8E2DE2).withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}

```