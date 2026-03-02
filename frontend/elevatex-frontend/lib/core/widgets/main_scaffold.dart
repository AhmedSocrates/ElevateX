import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: _CustomBottomNavigationBar(
        navigationShell: navigationShell,
      ),

      floatingActionButton: AiMentorFAB(),
    );
  }
}

class _CustomBottomNavigationBar extends StatelessWidget {
  const _CustomBottomNavigationBar({
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
      decoration: const ShapeDecoration(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NavBarItem(
            label: 'Home',
            icon: Icons.home_rounded,
            isSelected: navigationShell.currentIndex == 0,
            onTap: () => _onTap(0),
          ),
          _NavBarItem(
            label: 'Roadmap',
            icon: Icons.map_rounded,
            isSelected: navigationShell.currentIndex == 1,
            onTap: () => _onTap(1),
          ),
          _NavBarItem(
            label: 'Missions',
            icon: Icons.assignment_rounded,
            isSelected: navigationShell.currentIndex == 2,
            onTap: () => _onTap(2),
          ),
          _NavBarItem(
            label: 'Guild',
            icon: Icons.shield_rounded,
            isSelected: navigationShell.currentIndex == 3,
            onTap: () => _onTap(3),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: isSelected ? AppColors.surfaceLight : Colors.transparent,
                shape: const CircleBorder(),
                shadows: isSelected
                    ? [
                        const BoxShadow(
                          color: Color(0x00000000),
                          blurRadius: 0,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        ),
                        const BoxShadow(
                          color: Color(0x00000000),
                          blurRadius: 0,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        ),
                        const BoxShadow(
                          color: AppColors.primary,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.accentGold : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? AppColors.accentGold : AppColors.textSecondary,
                fontSize: 10.20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.57,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// floating action button to navigate to the mentor page
class AiMentorFAB extends StatelessWidget {
  const AiMentorFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: AppColors.surfaceLight,
        onPressed: () {
          context.push('/dashboard/mentor'); 
        },
        child: const Icon(Icons.auto_awesome, color: AppColors.accentGold), // Magic/AI icon
      );
  }
}