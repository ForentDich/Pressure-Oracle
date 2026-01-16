import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/i18n/l10n_extension.dart';
import '../../../../data/data.dart';
import '../widgets/widgets.dart';
import 'settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile _profile = UserProfile(firstName: '');

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final profile = ProfileService.getProfile();
    if (profile != null) {
      setState(() {
        _profile = profile;
      });
    }
  }

  String _formatDate(BuildContext context, DateTime? date) {
    if (date == null) return context.l10n.notSpecified;
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatHeight(BuildContext context, double? height) {
    if (height == null) return context.l10n.notSpecified;
    return '${height.toStringAsFixed(0)} ${context.l10n.unitCm}';
  }

  String _formatWeight(BuildContext context, double? weight) {
    if (weight == null) return context.l10n.notSpecified;
    return '${weight.toStringAsFixed(1)} ${context.l10n.unitKg}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: AppColors.purpleGradient,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.profile,
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
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ProfileHeader(
                    profile: _profile,
                    onEditComplete: _loadProfile,
                  ),
                ),


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
                          children: [
                            ProfileCard(
                              icon: Icons.person_outline,
                              title: context.l10n.personalData,
                              items: [
                                ProfileItem(
                                  label: context.l10n.firstName, 
                                  value: _profile.firstName.isEmpty 
                                      ? context.l10n.notSpecified 
                                      : _profile.firstName,
                                ),
                                ProfileItem(
                                  label: context.l10n.birthDate, 
                                  value: _formatDate(context, _profile.birthDate),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ProfileCard(
                              icon: Icons.monitor_weight_outlined,
                              title: context.l10n.physicalParams,
                              items: [
                                ProfileItem(
                                  label: context.l10n.height, 
                                  value: _formatHeight(context, _profile.height),
                                ),
                                ProfileItem(
                                  label: context.l10n.weight, 
                                  value: _formatWeight(context, _profile.weight),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            // Debug button - clear all data
                            TextButton(
                              onPressed: () async {
                                await ProfileService.deleteProfile();
                                if (mounted) {
                                  _loadProfile();
                                }
                              },
                              child: Text(
                                'Очистить данные',
                                style: TextStyles.bodyMedium.copyWith(
                                  color: Colors.red,
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
