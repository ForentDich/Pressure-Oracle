import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/i18n/strings.dart';

class AddRecordButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData leadingIcon;
  final Color leadingColor;

  const AddRecordButton({
    super.key,
    this.onPressed,
  this.label = Strings.addEntryTitle,
    this.leadingIcon = Icons.add_to_photos,
    this.leadingColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
  final Color gradientEnd = Color.lerp(leadingColor, Colors.black, 0.45) ?? leadingColor;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        elevation: 2,
  shadowColor: AppColors.cardShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: AppColors.buttonBorder),
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
                  child: Center(
                    child: Icon(leadingIcon, color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyles.bodyMedium.copyWith(color: Colors.black87),
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: AppColors.neutral600, size: 18),
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
