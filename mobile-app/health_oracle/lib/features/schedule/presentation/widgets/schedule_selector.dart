import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
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
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.neutral200),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.neutral600),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral900),
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.neutral400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
