import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/history/presentation/pages/history_page.dart';
import 'features/schedule/presentation/pages/schedule_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'core/helpers/modal_helper.dart';
import 'core/theme/colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/text_styles.dart';
import 'core/i18n/l10n_extension.dart';
import 'data/services/profile_service.dart';
import 'data/services/entry_service.dart';
import 'data/services/reminder_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/prediction_service.dart';
import 'data/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProfileService.init();
  await EntryService.init();
  await ReminderService.init();
  await NotificationService.init();
  await ThemeService.init();
  // Модели загружаем без await — не блокируем запуск приложения
  PredictionService.init();
  runApp(const MyApp());
}

/// Проверяет, нужен ли onboarding
bool get needsOnboarding => !ProfileService.hasProfile();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: ThemeService.instance,
      builder: (context, _, __) {
        return MaterialApp(
          title: 'Health Oracle',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeService.instance.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: needsOnboarding
              ? const OnboardingPage()
              : MainNavigator(key: MainNavigator.navigatorKey),
        );
      },
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  static final GlobalKey<_MainNavigatorState> navigatorKey =
      GlobalKey<_MainNavigatorState>();

  static void goToHistory() {
    navigatorKey.currentState?.goToHistory();
  }

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const SchedulePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void goToHistory() {
    setState(() {
      _currentIndex = 1; // История - индекс 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.surface(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.home_outlined,
                      Icons.home,
                      context.l10n.home,
                      0,
                    ),
                    _buildNavItem(
                      Icons.history_outlined,
                      Icons.history,
                      context.l10n.history,
                      1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 54),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      Icons.calendar_month_outlined,
                      Icons.calendar_month,
                      context.l10n.schedule,
                      2,
                    ),
                    _buildNavItem(
                      Icons.person_outlined,
                      Icons.person,
                      context.l10n.profile,
                      3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildCenterButton(),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColor = isDark ? Colors.white : AppColors.primary;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? selectedColor : AppTheme.textHint(context),
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyles.labelSmall.copyWith(
                fontSize: 10,
                color: isSelected ? selectedColor : AppTheme.textHint(context),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => ModalHelper.showBottomEntryMenu(context),
      child: Container(
        width: 48,
        height: 48,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          gradient: AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8E2DE2).withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
