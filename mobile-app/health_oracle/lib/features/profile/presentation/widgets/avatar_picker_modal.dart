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
