import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/history_list_panel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'История',
          style: TextStyles.headlineLarge.copyWith(
            color: AppColors.neutral900,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Implement export
              },
              icon: const Icon(Icons.file_download_outlined, size: 18),
              label: const Text('Экспорт'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.neutral200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: HistoryListPanel(),
      ),
    );
  }

}
