import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';

class EditSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const EditSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyles.labelSmall.copyWith(
              color: AppTheme.textHint(context),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration(context, radius: 16),
          child: Column(children: children),
        ),
      ],
    );
  }
}

/// Текстовое поле для редактирования
class EditTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const EditTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textPrimary(context),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.surfaceVariant(context),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.border(context)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.border(context)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF8E2DE2), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Поле для выбора даты
class EditDateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const EditDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.border(context)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppTheme.textHint(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Старый виджет для обратной совместимости
class EditField extends StatelessWidget {
  final String label;
  final String value;
  final bool isDate;

  const EditField({
    super.key,
    required this.label,
    required this.value,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyles.bodyMedium.copyWith(
                      color: AppTheme.textPrimary(context),
                    ),
                  ),
                ),
                if (isDate)
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: AppTheme.textHint(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Поле выбора пола
class EditSexField extends StatelessWidget {
  final String label;
  final String maleLabel;
  final String femaleLabel;
  final bool? value; // true = мужской, false = женский
  final ValueChanged<bool> onChanged;

  const EditSexField({
    super.key,
    required this.label,
    required this.maleLabel,
    required this.femaleLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.bodyMedium.copyWith(
              color: AppTheme.textSecondary(context),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _SexToggle(
                  label: maleLabel,
                  icon: Icons.male_rounded,
                  isSelected: value == true,
                  onTap: () => onChanged(true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SexToggle(
                  label: femaleLabel,
                  icon: Icons.female_rounded,
                  isSelected: value == false,
                  onTap: () => onChanged(false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SexToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SexToggle({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8E2DE2).withValues(alpha: 0.1) : AppTheme.surfaceVariant(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.border(context),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.textHint(context),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: isSelected ? const Color(0xFF8E2DE2) : AppTheme.textSecondary(context),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
