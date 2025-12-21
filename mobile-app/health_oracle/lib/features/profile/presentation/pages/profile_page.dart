import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../widgets/widgets.dart';
import 'settings_page.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Background
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar (Title & Settings)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Профиль',
                        style: TextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SettingsPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Profile Header (Avatar, Name, Button)
                const Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: ProfileHeader(),
                ),

                // White Sheet with Info Cards
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
                          children: const [
                            ProfileCard(
                              icon: Icons.person_outline,
                              title: 'Личные данные',
                              items: [
                                ProfileItem(label: 'Имя', value: 'Иван'),
                                ProfileItem(label: 'Фамилия', value: 'Петров'),
                                ProfileItem(label: 'Дата рождения', value: '12.05.1985'),
                              ],
                            ),
                            SizedBox(height: 20),
                            ProfileCard(
                              icon: Icons.monitor_weight_outlined,
                              title: 'Физические параметры',
                              items: [
                                ProfileItem(label: 'Рост', value: '178 см'),
                                ProfileItem(label: 'Вес', value: '75 кг'),
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
