import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class WeightPage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final ValueChanged<bool> onKeyboardChanged;

  const WeightPage({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onKeyboardChanged,
  });

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onKeyboardChanged(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = _focusNode.hasFocus;

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
            // Icon with fade animation when keyboard appears
            AnimatedOpacity(
              opacity: isKeyboardVisible ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 250),
              child: AnimatedScale(
                scale: isKeyboardVisible ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.monitor_weight_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              context.l10n.onboardingWeightTitle,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              context.l10n.onboardingWeightSubtitle,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                      onChanged: (_) => widget.onChanged(),
                      decoration: InputDecoration(
                        hintText: '70',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 56,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.unitKg,
                  style: TextStyles.headlineLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Underline
            Container(
              width: 200,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
