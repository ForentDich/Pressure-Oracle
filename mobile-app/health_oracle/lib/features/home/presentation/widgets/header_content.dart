import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';

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
              'Ромаэль!',
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
    
    if (hour >= 5 && hour < 10) {
      return 'Доброе утро,';
    } else if (hour >= 10 && hour < 16) {
      return 'Добрый день,';
    } else if (hour >= 16 && hour < 20) {
      return 'Добрый вечер,';
    } else {
      return 'Доброй ночи,';
    }
  }
}