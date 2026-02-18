import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_surface_card.dart';
import '../../../shared/widgets/xp_progress_bar.dart';
import '../../../shared/widgets/custom_primary_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildStreakCard(),
              const SizedBox(height: 24),
              _buildLevelProgressCard(),
              const SizedBox(height: 24),
              _buildSectionHeader('Daily Quests', onSeeAll: () {}),
              const SizedBox(height: 12),
              _buildQuestCard(),
              const SizedBox(height: 24),
              _buildSectionHeader('Your Career Path', onSeeAll: () {}),
              const SizedBox(height: 12),
              _buildCareerPathCard(),
              const SizedBox(height: 24),
              _buildSectionHeader('Magic Streak'),
              const SizedBox(height: 12),
              _buildMagicStreakCalendar(),
              const SizedBox(height: 100), // Bottom padding for content
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: AppTextStyles.h2),
            Text('Apprentice Wizard', style: AppTextStyles.bodyMd),
          ],
        ),
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 15,
              )
            ],
            image: const DecorationImage(
              image: NetworkImage("https://placehold.co/64x64"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard() {
    return CustomSurfaceCard(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_fire_department, color: AppColors.accentOrange, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily Streak', style: AppTextStyles.bodyMd.copyWith(color: AppColors.white, fontWeight: FontWeight.w500)),
                    Text('7 days', style: AppTextStyles.bodyMd.copyWith(color: AppColors.accentGold, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 8),
                const XpProgressBar(progress: 0.7),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgressCard() {
    return CustomSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Apprentice Level 3', style: AppTextStyles.bodyLg),
              Text('750 / 1000 XP', style: AppTextStyles.bodySm.copyWith(color: AppColors.accentGold)),
            ],
          ),
          const SizedBox(height: 12),
          const XpProgressBar(progress: 0.75, height: 10),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('12', 'Quests'),
              _buildStatItem('3', 'Skills'),
              _buildStatItem('240', 'Coins', isGold: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, {bool isGold = false}) {
    return Container(
      width: 96,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF241445),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: isGold ? AppColors.accentGold : AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.label),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.bolt, color: AppColors.primary, size: 22),
            const SizedBox(width: 8),
            Text(title, style: AppTextStyles.h3),
          ],
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'View All',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildQuestCard() {
    return CustomSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frontend Enchantment', style: AppTextStyles.bodyMd.copyWith(color: AppColors.white, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text('+50 XP', style: AppTextStyles.label),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Complete the CSS styling challenge', style: AppTextStyles.bodySm),
          const SizedBox(height: 20),
          SizedBox(
            width: 150,
            child: CustomPrimaryButton(
              text: 'Continue Quest',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerPathCard() {
    return CustomSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Frontend Developer', style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Level 3 of 12 completed', style: AppTextStyles.bodySm),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progress', style: AppTextStyles.label.copyWith(color: AppColors.white)),
              Text('25%', style: AppTextStyles.label.copyWith(color: AppColors.white)),
            ],
          ),
          const SizedBox(height: 8),
          const XpProgressBar(progress: 0.25),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.white, size: 16),
              const SizedBox(width: 8),
              Text('Next skill: React Mastery', style: AppTextStyles.bodySm.copyWith(color: AppColors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMagicStreakCalendar() {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return CustomSurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final isToday = index == 2; // Wednesday placeholder
          final isCompleted = index < 2;
          return Column(
            children: [
              Text(days[index], style: AppTextStyles.label),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.primary : (isToday ? AppColors.surfaceLight : Colors.transparent),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isToday ? AppColors.primary : AppColors.border,
                    width: isToday ? 2 : 1,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, color: AppColors.white, size: 18)
                    : null,
              ),
            ],
          );
        }),
      ),
    );
  }
}