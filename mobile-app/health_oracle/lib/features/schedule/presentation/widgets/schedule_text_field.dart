import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleTextField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String>? onChanged;

  const ScheduleTextField({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
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
            color: AppColors.neutral600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.neutral200),
          ),
          width: double.infinity,
          child: Text(
            value,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral900),
          ),
        ),
      ],
    );
  }
}
