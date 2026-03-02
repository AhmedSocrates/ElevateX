import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/roadmap_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class FrontendRoadmapScreen extends ConsumerWidget {
  const FrontendRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(frontendProgressProvider);
    
    final List<Map<String, dynamic>> nodes = [
      {'title': 'HTML Basics', 'icon': Icons.code},
      {'title': 'CSS Magic', 'icon': Icons.brush},
      {'title': 'JS Spells', 'icon': Icons.bolt},
      {'title': 'React Sorcery', 'icon': Icons.auto_awesome},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Frontend Roadmap', style: AppTextStyles.h2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/career'),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        itemCount: nodes.length,
        itemBuilder: (context, index) {
          final node = nodes[index];
          final isCompleted = index < progress;
          final isUnlocked = index == progress;
          final isLocked = index > progress;

          return Column(
            children: [
              _buildNode(
                context: context,
                title: node['title'],
                icon: node['icon'],
                isCompleted: isCompleted,
                isUnlocked: isUnlocked,
                isLocked: isLocked,
                onTap: isUnlocked ? () => context.go('/career/frontend/quiz') : null,
              ),
              if (index < nodes.length - 1)
                _buildConnector(isCompleted: isCompleted),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNode({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isCompleted,
    required bool isUnlocked,
    required bool isLocked,
    VoidCallback? onTap,
  }) {
    Color borderColor;
    Color iconColor;
    Color bgColor;
    List<BoxShadow>? shadows;

    if (isCompleted) {
      borderColor = Colors.greenAccent;
      iconColor = Colors.greenAccent;
      bgColor = Colors.greenAccent.withOpacity(0.1);
    } else if (isUnlocked) {
      borderColor = AppColors.primary;
      iconColor = AppColors.accentGold;
      bgColor = AppColors.surfaceLight;
      shadows = [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.5),
          blurRadius: 15,
          spreadRadius: 2,
        )
      ];
    } else {
      borderColor = AppColors.border;
      iconColor = Colors.grey;
      bgColor = AppColors.surface.withOpacity(0.5);
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3),
              boxShadow: shadows,
            ),
            child: Icon(
              isLocked ? Icons.lock : (isCompleted ? Icons.check : icon),
              color: iconColor,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodyMd.copyWith(
              color: isLocked ? Colors.grey : Colors.white,
              fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector({required bool isCompleted}) {
    return Container(
      width: 4,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.greenAccent : AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}