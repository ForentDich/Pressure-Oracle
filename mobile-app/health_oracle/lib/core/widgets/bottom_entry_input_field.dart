import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class BottomEntryInputField extends StatelessWidget {
  final String label;
  final String? unit;
  final TextEditingController controller;
  final String? hintText;
  final bool isRequired;

  const BottomEntryInputField({
    super.key,
    required this.label,
    required this.controller,
    this.unit,
    this.hintText,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppColors.neutral700,
              fontWeight: FontWeight.w600,
            ),
            children: [
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: AppColors.error500),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56, 
          decoration: BoxDecoration(
            color: AppColors.neutral50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.buttonBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: TextStyles.bodyMedium.copyWith(
                    fontSize: 18, 
                    color: AppColors.neutral800,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    hintStyle: TextStyles.bodyMedium.copyWith(
                      color: AppColors.neutral400,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              if (unit != null) ...[
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.neutral200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    unit!,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppColors.neutral600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}