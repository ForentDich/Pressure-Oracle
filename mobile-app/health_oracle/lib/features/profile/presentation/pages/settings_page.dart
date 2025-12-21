import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/settings_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Настройки',
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                // White Sheet
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
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
                          children: const [
                            SettingsGroup(
                              title: 'Уведомления',
                              children: [
                                SettingsSwitch(
                                  icon: Icons.notifications_none,
                                  label: 'Напоминания',
                                  value: true,
                                ),
                                SettingsDivider(),
                                SettingsSwitch(
                                  icon: Icons.mail_outline,
                                  label: 'Ежедневная сводка',
                                  value: false,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            SettingsGroup(
                              title: 'Внешний вид',
                              children: [
                                SettingsNav(
                                  icon: Icons.palette_outlined,
                                  label: 'Тема',
                                  value: 'Светлая',
                                ),
                                SettingsDivider(),
                                SettingsNav(
                                  icon: Icons.text_fields,
                                  label: 'Размер текста',
                                  value: 'Обычный',
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            SettingsGroup(
                              title: 'Прочее',
                              children: [
                                SettingsNav(
                                  icon: Icons.info_outline,
                                  label: 'О приложении',
                                  value: 'v1.0.0',
                                ),
                                SettingsDivider(),
                                SettingsNav(
                                  icon: Icons.description_outlined,
                                  label: 'Конфиденциальность',
                                  value: '',
                                ),
                              ],
                            ),
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
}

