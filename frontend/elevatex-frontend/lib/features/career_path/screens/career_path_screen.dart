import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_surface_card.dart';

class CareerPathSelectionScreen extends StatelessWidget {
  const CareerPathSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Career Roadmap',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your magical specialization',
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              _buildPathCard(
                context: context,
                title: 'Frontend Developer',
                description: 'Master the art of UI/UX sorcery with HTML, CSS, and React.',
                icon: Icons.auto_awesome,
                color: AppColors.primary,
                onTap: () => context.go('/career/frontend'),
              ),
              const SizedBox(height: 20),
              _buildPathCard(
                context: context,
                title: 'Backend Developer',
                description: 'Forge powerful APIs and databases in the deep forge. Coming soon!',
                icon: Icons.storage_rounded,
                color: Colors.grey,
                isEnabled: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPathCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: CustomSurfaceCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.h3),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              if (isEnabled)
                const Icon(Icons.chevron_right, color: AppColors.textSecondary)
              else
                const Icon(Icons.lock_clock_outlined, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}