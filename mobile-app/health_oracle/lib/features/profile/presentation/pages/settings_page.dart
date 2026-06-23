import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/services/reminder_service.dart';
import '../../../../data/services/theme_service.dart';
import '../../../../data/services/notification_service.dart';
import '../../../../data/services/profile_service.dart';
import '../../../../data/services/entry_service.dart';
import '../../../onboarding/presentation/pages/onboarding_page.dart';
import '../widgets/settings/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _clearAllData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Очистить данные'),
        content: const Text(
          'Вы точно уверены? Это действие удалит все ваши данные. '
          'Это невозможно отменить.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Удалить',
              style: TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
    await ProfileService.deleteProfile();
    await EntryService.deleteAll();
    await ReminderService.deleteAll();
    await NotificationService.cancelAll();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
        (route) => false,
      );
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = ThemeService.instance;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                SettingsHeader(title: context.l10n.settings),
                // Sheet
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ─── Внешний вид ───────────────────
                            SettingsGroup(
                              title: context.l10n.appearance,
                              children: [
                                _ThemeSelector(
                                  currentMode: themeService.mode,
                                  onChanged: (mode) async {
                                    await themeService.setMode(mode);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // ─── Уведомления ──────────────────
                            SettingsGroup(
  title: context.l10n.notifications,
  children: [
    SettingsSwitch(
      icon: Icons.notifications_none,
      label: context.l10n.reminders,
      value: themeService.notificationsEnabled,  // читаем из сервиса
      onChanged: (val) async {
        await themeService.setNotificationsEnabled(val);
        setState(() {});
        if (val) {
          // Если включили – запрашиваем разрешения и перепланируем
          await NotificationService.requestPermissions();
          final reminders = ReminderService.getActive();
          await NotificationService.rescheduleAllReminders(reminders);
        } else {
          // Если выключили – отменяем все уведомления
          await NotificationService.cancelAll();
        }
      },
    ),
  ],
),
                            const SizedBox(height: 20),
                            // ─── Прочее ────────────────────────
                            SettingsGroup(
                              title: context.l10n.other,
                              children: [
                                SettingsNav(
                                  icon: Icons.info_outline,
                                  label: context.l10n.aboutApp,
                                  value: 'v0.6.7',
                                  onTap: () => _showAbout(context),
                                ),
                                const SettingsDivider(),
                                GestureDetector(
                                  onTap: () => _clearAllData(context),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline,
                                            color: AppColors.error500, size: 22),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            'Очистить данные',
                                            style: TextStyles.bodyMedium.copyWith(
                                              color: AppColors.error500,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.chevron_right,
                                            color: AppTheme.textHint(context),
                                            size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Health Oracle',
      applicationVersion: '0.6.7',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.favorite, color: Colors.white, size: 24),
      ),
    );
  }
}

// ─── Theme Selector ─────────────────────────────────────────────

class _ThemeSelector extends StatelessWidget {
  final AppThemeMode currentMode;
  final ValueChanged<AppThemeMode> onChanged;

  const _ThemeSelector({
    required this.currentMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_outlined,
                  color: AppTheme.textSecondary(context), size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  context.l10n.theme,
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.textPrimary(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: AppThemeMode.values.map((mode) {
              final isSelected = mode == currentMode;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: mode != AppThemeMode.system ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => onChanged(mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8E2DE2).withValues(alpha: 0.1)
                            : AppTheme.surfaceVariant(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF8E2DE2)
                              : AppTheme.border(context),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _iconFor(mode),
                            size: 22,
                            color: isSelected
                                ? const Color(0xFF8E2DE2)
                                : AppTheme.textHint(context),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _labelFor(context, mode),
                            style: TextStyles.labelSmall.copyWith(
                              fontSize: 12,
                              color: isSelected
                                  ? const Color(0xFF8E2DE2)
                                  : AppTheme.textSecondary(context),
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
      case AppThemeMode.system:
        return Icons.settings_brightness_rounded;
    }
  }

  String _labelFor(BuildContext context, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return context.l10n.themeLight;
      case AppThemeMode.dark:
        return context.l10n.themeDark;
      case AppThemeMode.system:
        return context.l10n.themeSystem;
    }
  }
}

