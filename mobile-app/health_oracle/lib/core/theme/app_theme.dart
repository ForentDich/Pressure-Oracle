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
