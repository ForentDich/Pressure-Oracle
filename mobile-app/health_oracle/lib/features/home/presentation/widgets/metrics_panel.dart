import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class MetricsPanel extends StatelessWidget {
  final double top;
  
  const MetricsPanel({
    super.key,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Center(
          child: Text(
            "Сетка плашек появится здесь",
            style: TextStyles.bodyMedium,
          ),
        ),
      ),
    );
  }
}