import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class ExportSection extends StatelessWidget {
  final String title;
  final Widget child;

  const ExportSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.titleMedium.copyWith(
            fontSize: 16,
            color: AppColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration(context, radius: 20, blurRadius: 16, shadowOffset: const Offset(0, 6)),
          child: child,
        ),
      ],
    );
  }
}
