import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/history/presentation/pages/history_page.dart';
import 'features/group/presentation/pages/group_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'core/widgets/bottom_navigation_bar.dart';
import 'core/helpers/modal_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Oracle',
      theme: ThemeData(
        fontFamily: 'Manrope',
        useMaterial3: true,
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  NavTab _selectedTab = NavTab.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedTab: _selectedTab,
        onTabChanged: (tab) {
          if (tab == NavTab.add) {
            ModalHelper.showBottomEntryMenu(context);
          } else {
            setState(() => _selectedTab = tab);
          }
        },
      ),
    );
  }

  Widget _getPage() {
    switch (_selectedTab) {
      case NavTab.home:
        return const HomePage();
      case NavTab.history:
        return const HistoryPage();
      case NavTab.group:
        return const GroupPage();
      case NavTab.profile:
        return const ProfilePage();
      case NavTab.add:
        return const HomePage();
    }
  }
}