import 'package:flutter/material.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../core/theme/text_styles.dart';

class NamePage extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;
  final ValueChanged<bool> onKeyboardChanged;

  const NamePage({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onKeyboardChanged,
  });

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
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
                    Icons.waving_hand_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Title
            Text(
              context.l10n.onboardingWelcome,
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
              context.l10n.onboardingQuestion,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Input
            TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              textCapitalization: TextCapitalization.words,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              onChanged: (_) => widget.onChanged(),
              decoration: InputDecoration(
                hintText: context.l10n.onboardingNameHint,
                hintStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.3),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
