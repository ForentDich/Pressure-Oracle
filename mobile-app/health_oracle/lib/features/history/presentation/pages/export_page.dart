import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/widgets.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

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
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 24),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Экспорт истории',
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
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ExportSection(
                              title: 'Диапазон дат',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.calendar_today_outlined,
                                    label: 'Период',
                                    value: 'Последние 30 дней',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const ExportSection(
                              title: 'Формат и содержимое',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.description_outlined,
                                    label: 'Формат файла',
                                    value: 'PDF отчёт',
                                  ),
                                  SizedBox(height: 12),
                                  ExportSelectorRow(
                                    icon: Icons.list_alt_outlined,
                                    label: 'Детализация',
                                    value: 'Все измерения и статистика',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const ExportSection(
                              title: 'Способ отправки',
                              child: Column(
                                children: [
                                  ExportSelectorRow(
                                    icon: Icons.mail_outline,
                                    label: 'Отправить на e-mail',
                                    value: 'doctor@example.com',
                                  ),
                                  SizedBox(height: 12),
                                  ExportSelectorRow(
                                    icon: Icons.download_outlined,
                                    label: 'Сохранить в файлы',
                                    value: 'Внутренняя память',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.neutral700,
                                      side: const BorderSide(color: AppColors.neutral300),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: const Text('Отмена'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Text(
                                        'Экспортировать',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
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
