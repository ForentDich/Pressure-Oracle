import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class BottomEntryCategoryTile extends StatelessWidget {
  final String title;
  final bool selected;
  final Gradient? gradient;
  final VoidCallback? onTap;

  const BottomEntryCategoryTile({
    super.key,
    required this.title,
    required this.selected,
    this.gradient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            gradient: selected && gradient != null ? gradient : null,
            color: selected ? null : AppColors.neutral100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.buttonBorder),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyles.labelXSmall.copyWith(
                color: selected ? Colors.white : AppColors.neutral600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
