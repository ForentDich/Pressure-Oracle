import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class SexPage extends StatelessWidget {
  final bool? selectedSex; // true = мужской, false = женский
  final ValueChanged<bool> onSexSelected;

  const SexPage({
    super.key,
    required this.selectedSex,
    required this.onSexSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wc_rounded,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),

            Text(
              context.l10n.onboardingSexTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              context.l10n.onboardingSexSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SexOption(
                  icon: Icons.male_rounded,
                  label: context.l10n.sexMale,
                  isSelected: selectedSex == true,
                  onTap: () => onSexSelected(true),
                ),
                const SizedBox(width: 24),
                _SexOption(
                  icon: Icons.female_rounded,
                  label: context.l10n.sexFemale,
                  isSelected: selectedSex == false,
                  onTap: () => onSexSelected(false),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SexOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SexOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 130,
        height: 150,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.2),
            width: isSelected ? 2.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 52,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
