import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';

class ScheduleEditPage extends StatefulWidget {
  final bool isNew;
  final Reminder? reminder;

  const ScheduleEditPage({
    super.key,
    required this.isNew,
    this.reminder,
  });

  @override
  State<ScheduleEditPage> createState() => _ScheduleEditPageState();
}

class _ScheduleEditPageState extends State<ScheduleEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TimeOfDay _selectedTime;
  late RepeatType _selectedRepeat;
  late ReminderCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title ?? '');
    _descriptionController = TextEditingController(text: widget.reminder?.description ?? '');
    _selectedTime = widget.reminder != null
        ? TimeOfDay(hour: widget.reminder!.hour, minute: widget.reminder!.minute)
        : const TimeOfDay(hour: 9, minute: 0);
    _selectedRepeat = widget.reminder?.repeatType ?? RepeatType.daily;
    _selectedCategory = widget.reminder?.category ?? ReminderCategory.pressure;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _selectRepeat() {
    final repeatOptions = [RepeatType.daily, RepeatType.weekly, RepeatType.monthly];
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: repeatOptions.map((type) {
            return ListTile(
              title: Text(_getRepeatText(context, type)),
              trailing: _selectedRepeat == type ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedRepeat = type);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _selectCategory() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ReminderCategory.values.map((category) {
            return ListTile(
              title: Text(_getCategoryText(context, category)),
              trailing: _selectedCategory == category ? const Icon(Icons.check, color: AppColors.primary) : null,
              onTap: () {
                setState(() => _selectedCategory = category);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDefaultTitle(BuildContext context, ReminderCategory category) {
    switch (category) {
      case ReminderCategory.pressure:
        return context.l10n.defaultReminderTitlePressure;
      case ReminderCategory.pulse:
        return context.l10n.defaultReminderTitlePulse;
      case ReminderCategory.weight:
        return context.l10n.defaultReminderTitleWeight;
      case ReminderCategory.sugar:
        return context.l10n.defaultReminderTitleSugar;
      case ReminderCategory.other:
        return context.l10n.defaultReminderTitleOther;
    }
  }

  Future<void> _save() async {
    final title = _titleController.text.trim().isEmpty
        ? _getDefaultTitle(context, _selectedCategory)
        : _titleController.text.trim();
    
    final description = _descriptionController.text.trim().isEmpty
        ? context.l10n.defaultReminderDescription
        : _descriptionController.text.trim();

    final hasPermission = await NotificationService.hasPermissions();
    if (!hasPermission) {
      await NotificationService.requestPermissions();
    }

    Reminder? savedReminder;

    try {
      if (widget.isNew) {
        savedReminder = await ReminderService.add(
          title: title,
          description: description,
          hour: _selectedTime.hour,
          minute: _selectedTime.minute,
          repeatType: _selectedRepeat,
          category: _selectedCategory,
        );
      } else if (widget.reminder != null) {
        widget.reminder!.title = title;
        widget.reminder!.description = description;
        widget.reminder!.hour = _selectedTime.hour;
        widget.reminder!.minute = _selectedTime.minute;
        widget.reminder!.repeatType = _selectedRepeat;
        widget.reminder!.category = _selectedCategory;
        await ReminderService.update(widget.reminder!);
        savedReminder = widget.reminder;
      }

      if (savedReminder != null && savedReminder.isActive) {
        await NotificationService.scheduleReminder(savedReminder);
      }
    } catch (e) {
      debugPrint('Error saving reminder: $e');
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    if (widget.reminder == null) return;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.delete),
        content: Text(context.l10n.deleteEntry),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              context.l10n.delete,
              style: const TextStyle(color: AppColors.error500),
            ),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await NotificationService.cancelReminder(widget.reminder!);
      await ReminderService.delete(widget.reminder!.id);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeString = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neutral900),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.isNew ? context.l10n.newReminder : context.l10n.editing,
          style: TextStyles.titleMedium.copyWith(color: AppColors.neutral900),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScheduleFormSection(
              title: context.l10n.notificationType,
              child: ScheduleSelector(
                icon: Icons.category_outlined,
                label: context.l10n.notificationType,
                value: _getCategoryText(context, _selectedCategory),
                onTap: _selectCategory,
              ),
            ),
            const SizedBox(height: 16),
            ScheduleFormSection(
              title: context.l10n.timeAndRepeat,
              child: Column(
                children: [
                  ScheduleSelector(
                    icon: Icons.access_time,
                    label: context.l10n.time,
                    value: timeString,
                    onTap: _selectTime,
                  ),
                  const SizedBox(height: 12),
                  ScheduleSelector(
                    icon: Icons.repeat,
                    label: context.l10n.repeat,
                    value: _getRepeatText(context, _selectedRepeat),
                    onTap: _selectRepeat,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ScheduleFormSection(
              title: context.l10n.basicData,
              child: Column(
                children: [
                  ScheduleTextField(
                    label: context.l10n.notificationTitle,
                    controller: _titleController,
                    hintText: _getDefaultTitle(context, _selectedCategory),
                  ),
                  const SizedBox(height: 12),
                  ScheduleTextField(
                    label: context.l10n.description,
                    controller: _descriptionController,
                    hintText: context.l10n.defaultReminderDescription,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(context.l10n.save),
              ),
            ),
            if (!widget.isNew) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _delete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error500,
                    side: const BorderSide(color: AppColors.error500),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(context.l10n.delete),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
