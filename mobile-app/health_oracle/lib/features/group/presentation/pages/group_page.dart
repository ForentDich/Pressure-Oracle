import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Группа', style: TextStyles.titleMedium),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          'Группа пользователей',
          style: TextStyles.bodyMedium.copyWith(
            color: AppColors.neutral600,
          ),
        ),
      ),
    );
  }
}
