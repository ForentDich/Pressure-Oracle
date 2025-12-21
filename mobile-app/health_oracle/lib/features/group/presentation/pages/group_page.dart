import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Расписание',
                          style: TextStyles.headlineLarge.copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Управляйте напоминаниями',
                          style: TextStyles.bodyMedium.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const _ScheduleEditPage(isNew: true),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.actionPrimary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Stats cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: 'Активных',
                        value: '3',
                        icon: Icons.notifications_active_outlined,
                        gradient: AppColors.primaryGradient,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
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
              // Section title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Активные',
                  style: TextStyles.titleMedium.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Active schedule items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _ScheduleItem(
                      title: 'Измерить давление',
                      time: '09:00',
                      repeat: 'Каждый день',
                      icon: Icons.favorite_outline,
                      gradient: AppColors.pulseGradient,
                      isActive: true,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _ScheduleEditPage(isNew: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScheduleItem(
                      title: 'Вечернее измерение',
                      time: '20:30',
                      repeat: 'Каждый день',
                      icon: Icons.nightlight_outlined,
                      gradient: AppColors.pressureGradient,
                      isActive: true,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _ScheduleEditPage(isNew: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScheduleItem(
                      title: 'Взвешивание',
                      time: '08:00',
                      repeat: 'Каждую неделю',
                      icon: Icons.monitor_weight_outlined,
                      gradient: AppColors.weightGradient,
                      isActive: true,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _ScheduleEditPage(isNew: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Inactive section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Неактивные',
                  style: TextStyles.titleMedium.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _ScheduleItem(
                      title: 'Записать сахар',
                      time: '12:00',
                      repeat: 'По будням',
                      icon: Icons.water_drop_outlined,
                      gradient: AppColors.sugarGradient,
                      isActive: false,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const _ScheduleEditPage(isNew: false),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ScheduleItem(
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
                          builder: (_) => const _ScheduleEditPage(isNew: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyles.headlineLarge.copyWith(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: TextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final String title;
  final String time;
  final String repeat;
  final IconData icon;
  final Gradient gradient;
  final bool isActive;
  final VoidCallback onTap;

  const _ScheduleItem({
    required this.title,
    required this.time,
    required this.repeat,
    required this.icon,
    required this.gradient,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isActive ? gradient : null,
                color: isActive ? null : AppColors.neutral200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : AppColors.neutral500,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      color: isActive ? AppColors.neutral900 : AppColors.neutral600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.neutral500,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppColors.neutral600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.neutral400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        repeat,
                        style: TextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: AppColors.neutral500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Switch(
              value: isActive,
              onChanged: (_) {},
              activeColor: AppColors.success500,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleEditPage extends StatelessWidget {
  final bool isNew;

  const _ScheduleEditPage({required this.isNew});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          isNew ? 'Создание уведомления' : 'Изменение уведомления',
          style: TextStyles.titleMedium.copyWith(color: AppColors.neutral900),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionCard(
              title: 'Основные данные',
              child: Column(
                children: [
                  _TextFieldMock(label: 'Название уведомления', value: 'Измерить давление'),
                  const SizedBox(height: 12),
                  _TextFieldMock(label: 'Описание', value: 'Сделать 2–3 измерения подряд, сидя.'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Время и повтор',
              child: Column(
                children: [
                  _SelectorMock(icon: Icons.access_time, label: 'Время', value: '20:30'),
                  const SizedBox(height: 12),
                  _SelectorMock(icon: Icons.repeat, label: 'Повтор', value: 'Каждый день'),
                  const SizedBox(height: 12),
                  _SelectorMock(icon: Icons.calendar_today_outlined, label: 'Дата начала', value: 'Сегодня'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Оформление уведомления',
              child: Column(
                children: [
                  _SelectorMock(icon: Icons.notifications, label: 'Тип уведомления', value: 'Стандартное'),
                  const SizedBox(height: 12),
                  _SelectorMock(icon: Icons.palette_outlined, label: 'Цвет карточки', value: 'Фиолетовый'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.neutral700,
                      side: BorderSide(color: AppColors.neutral300),
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(isNew ? 'Сохранить' : 'Сохранить изменения'),
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

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.titleMedium.copyWith(
            fontSize: 16,
            color: AppColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

class _TextFieldMock extends StatelessWidget {
  final String label;
  final String value;

  const _TextFieldMock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            fontSize: 14,
            color: AppColors.neutral600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.neutral200),
          ),
          width: double.infinity,
          child: Text(
            value,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral900),
          ),
        ),
      ],
    );
  }
}

class _SelectorMock extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SelectorMock({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyMedium.copyWith(
            fontSize: 14,
            color: AppColors.neutral600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.neutral200),
          ),
          width: double.infinity,
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.neutral600),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: TextStyles.bodyMedium.copyWith(color: AppColors.neutral900),
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.neutral400),
            ],
          ),
        ),
      ],
    );
  }
}

