import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'nav_item.dart';

enum NavTab { home, history, add, group, profile }

class CustomBottomNavigationBar extends StatelessWidget {
  final NavTab selectedTab;
  final Function(NavTab) onTabChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavItem(
                icon: Icons.home_outlined,
                label: 'Главная',
                isSelected: selectedTab == NavTab.home,
                onTap: () => onTabChanged(NavTab.home),
              ),
              NavItem(
                icon: Icons.history,
                label: 'История',
                isSelected: selectedTab == NavTab.history,
                onTap: () => onTabChanged(NavTab.history),
              ),
              NavItem(
                icon: Icons.add,
                label: 'Добавить',
                isSelected: selectedTab == NavTab.add,
                isCenter: true,
                onTap: () => onTabChanged(NavTab.add),
              ),
              NavItem(
                icon: Icons.people_outline,
                label: 'Группа',
                isSelected: selectedTab == NavTab.group,
                onTap: () => onTabChanged(NavTab.group),
              ),
              NavItem(
                icon: Icons.person_outline,
                label: 'Профиль',
                isSelected: selectedTab == NavTab.profile,
                onTap: () => onTabChanged(NavTab.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
