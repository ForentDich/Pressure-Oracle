import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_profile.dart';

/// Сервис для работы с профилем пользователя
class ProfileService {
  static const String _boxName = 'user_profile';
  static const String _profileKey = 'profile';

  static Box<UserProfile>? _box;

  /// Инициализация Hive и открытие бокса
  static Future<void> init() async {
    await Hive.initFlutter();

    // Регистрируем адаптер, если ещё не зарегистрирован
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProfileAdapter());
    }

    _box = await Hive.openBox<UserProfile>(_boxName);
  }

  /// Получить текущий профиль
  static UserProfile? getProfile() {
    return _box?.get(_profileKey);
  }

  /// Сохранить профиль
  static Future<void> saveProfile(UserProfile profile) async {
    await _box?.put(_profileKey, profile);
  }

  /// Проверить, есть ли сохранённый профиль
  static bool hasProfile() {
    return _box?.containsKey(_profileKey) ?? false;
  }

  /// Удалить профиль
  static Future<void> deleteProfile() async {
    await _box?.delete(_profileKey);
  }

  /// Слушать изменения профиля
  static Stream<BoxEvent>? watchProfile() {
    return _box?.watch(key: _profileKey);
  }
}
