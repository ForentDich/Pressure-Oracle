import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class ExportSelectorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ExportSelectorRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
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
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyles.bodyMedium.copyWith(
                  color: AppColors.neutral900,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: AppColors.neutral400),
      ],
    );
  }
}
