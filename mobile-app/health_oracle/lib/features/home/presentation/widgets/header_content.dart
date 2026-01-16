import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = ProfileService.getProfile();
    final displayName = (profile != null && profile.firstName.isNotEmpty)
        ? '${profile.firstName}!' 
        : context.l10n.defaultUserName;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreetingByTime(context),
              style: TextStyles.titleMedium.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              displayName,
              style: TextStyles.headlineLarge.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _getGreetingByTime(BuildContext context) {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      return context.l10n.greetingMorning;
    } else if (hour >= 12 && hour < 16) {
      return context.l10n.greetingDay;
    } else if (hour >= 16 && hour < 20) {
      return context.l10n.greetingEvening;
    } else {
      return context.l10n.greetingNight;
    }
  }
}