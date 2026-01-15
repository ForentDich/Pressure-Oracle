import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../widgets/widgets.dart';
import 'schedule_edit_page.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                ScheduleHeader(
                  onAddPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ScheduleEditPage(isNew: true),
                      ),
                    );
                  },
                ),
                // White Sheet with content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 24, bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Stats cards
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: 'Активных',
                                      value: '3',
                                      icon: Icons.notifications_active_outlined,
                                      gradient: AppColors.primaryGradient,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: 'Всего',
                                      value: '5',
                                      icon: Icons.schedule_outlined,
                                      gradient: AppColors.pressureGradient,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            // Active section
                            ScheduleSection(
                              title: 'Активные',
                              children: [
                                ScheduleItem(
                                  title: 'Измерить давление',
                                  time: '09:00',
                                  repeat: 'Каждый день',
                                  icon: Icons.favorite_outline,
                                  gradient: AppColors.pulseGradient,
                                  isActive: true,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ScheduleEditPage(isNew: false),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ScheduleItem(
                                  title: 'Вечернее измерение',
                                  time: '20:30',
                                  repeat: 'Каждый день',
                                  icon: Icons.nightlight_outlined,
                                  gradient: AppColors.pressureGradient,
                                  isActive: true,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ScheduleEditPage(isNew: false),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ScheduleItem(
                                  title: 'Взвешивание',
                                  time: '08:00',
                                  repeat: 'Каждую неделю',
                                  icon: Icons.monitor_weight_outlined,
                                  gradient: AppColors.weightGradient,
                                  isActive: true,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ScheduleEditPage(isNew: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            // Inactive section
                            ScheduleSection(
                              title: 'Неактивные',
                              children: [
                                ScheduleItem(
                                  title: 'Записать сахар',
                                  time: '12:00',
                                  repeat: 'По будням',
                                  icon: Icons.water_drop_outlined,
                                  gradient: AppColors.sugarGradient,
                                  isActive: false,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ScheduleEditPage(isNew: false),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ScheduleItem(
                                  title: 'Визит к врачу',
                                  time: '10:00',
                                  repeat: 'Раз в месяц',
                                  icon: Icons.medical_services_outlined,
                                  gradient: const LinearGradient(
                                    colors: [AppColors.neutral500, AppColors.neutral600],
                                  ),
                                  isActive: false,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const ScheduleEditPage(isNew: false),
                                    ),
                                  ),
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
