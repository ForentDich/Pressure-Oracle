import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
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
              color: AppTheme.textSecondary(context),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.border(context)),
            ),
            width: double.infinity,
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppTheme.textSecondary(context)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
                  ),
                ),
                Icon(Icons.chevron_right, color: AppTheme.textHint(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
