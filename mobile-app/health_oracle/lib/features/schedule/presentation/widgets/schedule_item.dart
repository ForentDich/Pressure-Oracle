import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ScheduleItem extends StatelessWidget {
  final String title;
  final String time;
  final String repeat;
  final String category;
  final IconData icon;
  final Gradient gradient;
  final bool isActive;
  final VoidCallback onTap;
  final ValueChanged<bool>? onToggle;

  const ScheduleItem({
    super.key,
    required this.title,
    required this.time,
    required this.repeat,
    required this.category,
    required this.icon,
    required this.gradient,
    required this.isActive,
    required this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.cardDecoration(context, radius: 18),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isActive ? gradient : null,
                color: isActive ? null : AppTheme.surfaceVariant(context),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : AppTheme.textHint(context),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      color: isActive ? AppTheme.textPrimary(context) : AppTheme.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppTheme.textHint(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textSecondary(context),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.textHint(context),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        repeat,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppTheme.textHint(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category,
                    style: TextStyles.bodyMedium.copyWith(
                      fontSize: 12,
                      color: AppTheme.textHint(context),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isActive,
              onChanged: onToggle ?? (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
