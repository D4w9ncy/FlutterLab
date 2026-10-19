import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_logo.dart';

/// Головний каркас навігації (бічна панель для десктопу/веб, нижня панель для мобільних)
class AppShell extends StatelessWidget {
  final Widget child;
  final GoRouterState state;

  const AppShell({
    super.key,
    required this.child,
    required this.state,
  });

  int _calculateSelectedIndex(BuildContext context) {
    final String location = state.uri.path;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/categories')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // /home
  }

  String _getTitleForLocation(String location) {
    if (location == '/tasks/new') return 'Нове завдання';
    if (location.endsWith('/edit')) return 'Редагування завдання';
    if (location.startsWith('/tasks/') && location != '/tasks') return 'Деталі завдання';
    if (location == '/profile/change-password') return 'Заміна пароля';
    if (location.startsWith('/tasks')) return 'Завдання';
    if (location.startsWith('/categories')) return 'Категорії';
    if (location.startsWith('/profile')) return 'Профіль';
    return 'Головна';
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/tasks');
        break;
      case 2:
        context.go('/categories');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);
    final String screenTitle = _getTitleForLocation(state.uri.path);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = constraints.maxWidth >= 800;

        if (isWideScreen) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Row(
              children: [
                // Ліва бічна панель (Sidebar)
                _buildSidebar(context, selectedIndex),

                // Основна частина з верхньою панеллю та контентом
                Expanded(
                  child: Column(
                    children: [
                      // Верхній хедер
                      _buildTopHeader(context, screenTitle),

                      // Контент вибраної сторінки
                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Мобільна версія (екран менше 800px)
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            elevation: 0,
            title: Row(
              children: [
                const AppLogo(iconSize: 32, showText: false),
                const SizedBox(width: AppSpacing.md),
                Text(
                  screenTitle,
                  style: AppTypography.h3,
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: InkWell(
                  onTap: () => context.go('/profile'),
                  borderRadius: BorderRadius.circular(20),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryContainer,
                    child: const Text(
                      MockData.userInitials,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (idx) => _onItemTapped(idx, context),
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.primaryContainer,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home, color: AppColors.primary),
                  label: 'Головна',
                ),
                NavigationDestination(
                  icon: Icon(Icons.format_list_bulleted),
                  selectedIcon: Icon(Icons.format_list_bulleted, color: AppColors.primary),
                  label: 'Завдання',
                ),
                NavigationDestination(
                  icon: Icon(Icons.category_outlined),
                  selectedIcon: Icon(Icons.category, color: AppColors.primary),
                  label: 'Категорії',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person, color: AppColors.primary),
                  label: 'Профіль',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopHeader(BuildContext context, String title) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxl),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                title,
                style: AppTypography.h2.copyWith(fontSize: 20),
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                MockData.appName,
                style: AppTypography.subtitle.copyWith(fontSize: 13),
              ),
            ],
          ),
          InkWell(
            onTap: () => context.go('/profile'),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Text(
                    MockData.userName,
                    style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryContainer,
                    child: const Text(
                      MockData.userInitials,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, int selectedIndex) {
    return Container(
      width: 96,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          const AppLogo(iconSize: 42, showText: false),
          const SizedBox(height: AppSpacing.xxxl),
          _buildNavItem(
            context: context,
            icon: Icons.home_outlined,
            label: 'Головна',
            isSelected: selectedIndex == 0,
            onTap: () => _onItemTapped(0, context),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildNavItem(
            context: context,
            icon: Icons.format_list_bulleted,
            label: 'Завдання',
            isSelected: selectedIndex == 1,
            onTap: () => _onItemTapped(1, context),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildNavItem(
            context: context,
            icon: Icons.category_outlined,
            label: 'Категорії',
            isSelected: selectedIndex == 2,
            onTap: () => _onItemTapped(2, context),
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildNavItem(
            context: context,
            icon: Icons.person_outline,
            label: 'Профіль',
            isSelected: selectedIndex == 3,
            onTap: () => _onItemTapped(3, context),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusMd,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs + 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryContainer : Colors.transparent,
                borderRadius: AppSpacing.borderRadiusPill,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
