import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/strings.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreetingByTime(),
              style: TextStyles.titleMedium.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              Strings.userName,
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

  String _getGreetingByTime() {
    final hour = DateTime.now().hour;
    
    if (hour >= 6 && hour < 12) {
      return Strings.greetingMorning;
    } else if (hour >= 12 && hour < 16) {
      return Strings.greetingDay;
    } else if (hour >= 16 && hour < 20) {
      return Strings.greetingEvening;
    } else {
      return Strings.greetingNight;
    }
  }
}