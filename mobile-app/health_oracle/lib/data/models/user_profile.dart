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

  UserProfile({
    required this.firstName,
    this.birthDate,
    this.height,
    this.sex,
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
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      birthDate: birthDate ?? this.birthDate,
      height: height ?? this.height,
      sex: sex ?? this.sex,
    );
  }
}
