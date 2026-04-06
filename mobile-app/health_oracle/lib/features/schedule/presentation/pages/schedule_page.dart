import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';
import 'schedule_edit_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Reminder> _activeReminders = [];
  List<Reminder> _inactiveReminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    setState(() {
      _activeReminders = ReminderService.getActive();
      _inactiveReminders = ReminderService.getInactive();
      _activeReminders.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
      _inactiveReminders.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
    });
  }

  IconData _getCategoryIcon(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return Icons.favorite_outline;
      case ReminderCategory.pulse:
        return Icons.monitor_heart_outlined;
      case ReminderCategory.weight:
        return Icons.monitor_weight_outlined;
      case ReminderCategory.sugar:
        return Icons.water_drop_outlined;
      case ReminderCategory.other:
        return Icons.notifications_outlined;
    }
  }

  Gradient _getCategoryGradient(ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return AppColors.pressureGradient;
      case ReminderCategory.pulse:
        return AppColors.pulseGradient;
      case ReminderCategory.weight:
        return AppColors.weightGradient;
      case ReminderCategory.sugar:
        return AppColors.sugarGradient;
      case ReminderCategory.other:
        return AppColors.primaryGradient;
    }
  }

  String _getRepeatText(BuildContext context, RepeatType type) {
    switch (type) {
      case RepeatType.daily:
        return context.l10n.repeatDaily;
      case RepeatType.weekly:
        return context.l10n.repeatWeekly;
      case RepeatType.monthly:
        return context.l10n.repeatMonthly;
      case RepeatType.weekdays:
        return context.l10n.repeatWeekdays;
    }
  }

  String _getCategoryText(BuildContext context, ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return context.l10n.metricPressure;
      case ReminderCategory.pulse:
        return context.l10n.metricPulse;
      case ReminderCategory.weight:
        return context.l10n.metricWeight;
      case ReminderCategory.sugar:
        return context.l10n.metricSugar;
      case ReminderCategory.other:
        return context.l10n.other;
    }
  }

  Future<void> _toggleReminder(String id) async {
    final reminder = ReminderService.getById(id);
    if (reminder == null) return;
    
    final willBeActive = !reminder.isActive;
    await ReminderService.toggleActive(id);
    
    // Update notification
    if (willBeActive) {
      await NotificationService.scheduleReminder(reminder);
    } else {
      await NotificationService.cancelReminder(reminder);
    }
    
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background для верхней панели
          Container(
            height: MediaQuery.of(context).size.height * 0.35, // измените высоту, если у вас она другая
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Header
                ScheduleHeader(
                  onAddPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ScheduleEditPage(isNew: true),
                      ),
                    );
                    _loadReminders();
                  },
                ),
                // White Sheet with content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.background(context),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: context.l10n.scheduleActiveCount,
                                      value: '${ReminderService.activeCount}',
                                      icon: Icons.notifications_active_outlined,
                                      gradient: AppColors.greenGradient,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ScheduleStatCard(
                                      label: context.l10n.scheduleTotal,
                                      value: '${ReminderService.totalCount}',
                                      icon: Icons.schedule_outlined,
                                      gradient: AppColors.purpleGradient,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            if (_activeReminders.isNotEmpty)
                              ScheduleSection(
                                title: context.l10n.scheduleActive,
                                children: _activeReminders.map((reminder) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ScheduleItem(
                                      title: reminder.title,
                                      time: reminder.timeString,
                                      repeat: _getRepeatText(context, reminder.repeatType),
                                      category: _getCategoryText(context, reminder.category),
                                      icon: _getCategoryIcon(reminder.category),
                                      gradient: _getCategoryGradient(reminder.category),
                                      isActive: true,
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ScheduleEditPage(
                                              isNew: false,
                                              reminder: reminder,
                                            ),
                                          ),
                                        );
                                        _loadReminders();
                                      },
                                      onToggle: (_) => _toggleReminder(reminder.id),
                                    ),
                                  );
                                }).toList(),
                              ),
                            if (_activeReminders.isNotEmpty && _inactiveReminders.isNotEmpty)
                              const SizedBox(height: 16),
                            if (_inactiveReminders.isNotEmpty)
                              ScheduleSection(
                                title: context.l10n.scheduleInactive,
                                children: _inactiveReminders.map((reminder) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: ScheduleItem(
                                      title: reminder.title,
                                      time: reminder.timeString,
                                      repeat: _getRepeatText(context, reminder.repeatType),
                                      category: _getCategoryText(context, reminder.category),
                                      icon: _getCategoryIcon(reminder.category),
                                      gradient: _getCategoryGradient(reminder.category),
                                      isActive: false,
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ScheduleEditPage(
                                              isNew: false,
                                              reminder: reminder,
                                            ),
                                          ),
                                        );
                                        _loadReminders();
                                      },
                                      onToggle: (_) => _toggleReminder(reminder.id),
                                    ),
                                  );
                                }).toList(),
                              ),
                            if (_activeReminders.isEmpty && _inactiveReminders.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.notifications_none_outlined,
                                        size: 64,
                                        color: AppTheme.textHint(context),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        context.l10n.scheduleManageReminders,
                                        style: TextStyle(
                                          color: AppTheme.textHint(context),
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
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
