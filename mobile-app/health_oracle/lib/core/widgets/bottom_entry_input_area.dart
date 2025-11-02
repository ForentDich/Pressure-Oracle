import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../i18n/strings.dart';

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
      ? Center(child: Text(Strings.choosePlaceholder))
      : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text('${Strings.selectedPrefix}${selectedCategories.join(', ')}',
            style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral600)),
                  const SizedBox(height: 6),
          Text(Strings.inputToolsPlaceholder,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral600)),
                ],
              ),
      ),
    );
  }
}
