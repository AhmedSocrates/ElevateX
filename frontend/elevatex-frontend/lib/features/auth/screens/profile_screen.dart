import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../../dashboard/providers/progress_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_surface_card.dart';
import '../../../shared/widgets/xp_progress_bar.dart';
import '../../../shared/widgets/custom_primary_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final progress = ref.watch(progressProvider);

    return Scaffold(
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Please log in'));
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  const SizedBox(height: 24),
                  _buildProfileHeader(user),
                  const SizedBox(height: 24),
                  _buildStatsRow(user),
                  const SizedBox(height: 24),
                  _buildLevelProgress(progress),
                  const SizedBox(height: 24),
                  CustomPrimaryButton(
                    text: 'Edit Profile',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Recent Achievements'),
                  const SizedBox(height: 16),
                  _buildAchievementItem(
                    icon: Icons.auto_awesome,
                    title: 'First Steps',
                    subtitle: 'Complete your first quest',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 12),
                  _buildAchievementItem(
                    icon: Icons.local_fire_department,
                    title: 'Streak Master',
                    subtitle: 'Maintain a 7-day streak',
                    color: AppColors.accentOrange,
                  ),
                  const SizedBox(height: 32),
                  _buildMenuTile(Icons.notifications_none, 'Notifications', onTap: () {}),
                  _buildMenuTile(
                    Icons.logout, 
                    'Log Out', 
                    onTap: () => ref.read(authProvider.notifier).logout(), 
                    isLast: true
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(Icons.arrow_back, onTap: () => Navigator.pop(context)),
        _buildIconButton(Icons.settings_outlined, onTap: () {}),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: 22),
      ),
    );
  }

  Widget _buildProfileHeader(user) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.5),
                  blurRadius: 20,
                )
              ],
              image: const DecorationImage(
                image: NetworkImage("https://placehold.co/100x100"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(user.name, style: AppTextStyles.h2),
          Text('@${user.name.toLowerCase().replaceAll(' ', '_')}', style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildStatsRow(user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(Icons.workspace_premium, 'Level ${user.level}', 'Apprentice', AppColors.accentGold),
        _buildVerticalDivider(),
        _buildStatItem(Icons.local_fire_department, '${user.currentStreak} days', 'Streak', AppColors.accentOrange),
        _buildVerticalDivider(),
        _buildStatItem(Icons.bolt, '12', 'Quests', AppColors.primary),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(value, style: AppTextStyles.bodyMd.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.label),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.border,
    );
  }

  Widget _buildLevelProgress(progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Next level', style: AppTextStyles.bodyMd),
            Text('${progress.currentXp} / ${progress.nextLevelXp} XP', style: AppTextStyles.bodyMd.copyWith(color: AppColors.accentGold)),
          ],
        ),
        const SizedBox(height: 12),
        XpProgressBar(progress: progress.progress, height: 8),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        const Icon(Icons.emoji_events_outlined, color: AppColors.white, size: 22),
        const SizedBox(width: 8),
        Text(title, style: AppTextStyles.h3),
      ],
    );
  }

  Widget _buildAchievementItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return CustomSurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.bold)),
                Text(subtitle, style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, {required VoidCallback onTap, bool isLast = false}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CustomSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF241445),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Text(title, style: AppTextStyles.bodyMd),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
        if (!isLast) const SizedBox(height: 12),
      ],
    );
  }
}