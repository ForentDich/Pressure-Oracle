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
