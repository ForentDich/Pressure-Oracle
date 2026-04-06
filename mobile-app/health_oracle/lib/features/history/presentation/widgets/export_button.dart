import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ExportButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const leadingColor = AppColors.primary;
    final Color gradientEnd = Color.lerp(leadingColor, Colors.black, 0.45) ?? leadingColor;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppTheme.surface(context),
        elevation: 2,
        shadowColor: AppTheme.cardShadow(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: AppTheme.border(context)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [leadingColor, gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(Icons.download, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Экспорт данных',
                    style: TextStyles.bodyMedium.copyWith(color: AppTheme.textPrimary(context)),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios, color: AppTheme.textSecondary(context), size: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
