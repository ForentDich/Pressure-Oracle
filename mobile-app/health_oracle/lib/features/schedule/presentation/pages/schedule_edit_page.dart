import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/widgets.dart';

class ScheduleEditPage extends StatelessWidget {
  final bool isNew;

  const ScheduleEditPage({super.key, required this.isNew});

  @override
  Widget build(BuildContext context) {
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
          isNew ? 'Новое напоминание' : 'Редактирование',
          style: TextStyles.titleMedium.copyWith(color: AppColors.neutral900),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScheduleFormSection(
              title: 'Основные данные',
              child: Column(
                children: [
                  ScheduleTextField(
                    label: 'Название уведомления',
                    value: 'Измерить давление',
                  ),
                  const SizedBox(height: 12),
                  ScheduleTextField(
                    label: 'Описание',
                    value: 'Сделать 2–3 измерения подряд, сидя.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ScheduleFormSection(
              title: 'Время и повтор',
              child: Column(
                children: [
                  ScheduleSelector(
                    icon: Icons.access_time,
                    label: 'Время',
                    value: '20:30',
                  ),
                  const SizedBox(height: 12),
                  ScheduleSelector(
                    icon: Icons.repeat,
                    label: 'Повтор',
                    value: 'Каждый день',
                  ),
                  const SizedBox(height: 12),
                  ScheduleSelector(
                    icon: Icons.calendar_today_outlined,
                    label: 'Дата начала',
                    value: 'Сегодня',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ScheduleFormSection(
              title: 'Оформление уведомления',
              child: Column(
                children: [
                  ScheduleSelector(
                    icon: Icons.notifications,
                    label: 'Тип уведомления',
                    value: 'Стандартное',
                  ),
                  const SizedBox(height: 12),
                  ScheduleSelector(
                    icon: Icons.palette_outlined,
                    label: 'Цвет карточки',
                    value: 'Фиолетовый',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.neutral700,
                      side: const BorderSide(color: AppColors.neutral300),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Отмена'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(isNew ? 'Сохранить' : 'Сохранить'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
