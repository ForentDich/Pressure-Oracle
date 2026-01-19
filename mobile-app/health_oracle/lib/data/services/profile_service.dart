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
