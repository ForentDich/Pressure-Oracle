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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, 
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
              
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildAvatar(profile),
      ],
    ),
  ),
);
  }

  Widget _buildAvatar(profile) {
    if (profile != null && profile.avatarName != null) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/avatars/${profile.avatarName}'),
      );
    }
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white.withValues(alpha: 0.2),
      child: const Icon(Icons.person_rounded, color: Colors.white, size: 32),
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