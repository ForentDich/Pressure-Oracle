import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class BottomEntryInputArea extends StatelessWidget {
  final List<String> selectedCategories;

  const BottomEntryInputArea({super.key, required this.selectedCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 96, maxHeight: 320),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: selectedCategories.isEmpty
            ? const Center(child: Text('Выберите категорию(ии) сверху'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Выбрано: ${selectedCategories.join(', ')}',
                      style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral600)),
                  const SizedBox(height: 6),
                  Text('Здесь появятся инструменты ввода (пока заглушка).',
                      style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral600)),
                ],
              ),
      ),
    );
  }
}
