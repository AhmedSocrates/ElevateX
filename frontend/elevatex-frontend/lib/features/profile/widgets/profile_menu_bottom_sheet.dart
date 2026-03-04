import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProfileMenuBottomSheet extends StatelessWidget {
  final String userName;
  final int level;

  const ProfileMenuBottomSheet({
    super.key,
    required this.userName,
    required this.level,
  });

  /// Convenience static method to show this sheet from anywhere.
  static void show(BuildContext context,
      {required String userName, required int level}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => ProfileMenuBottomSheet(
        userName: userName,
        level: level,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            const SizedBox(height: 20),

            // Profile header
            _buildProfileHeader(),
            const SizedBox(height: 20),

            // Divider
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              color: AppColors.border,
            ),
            const SizedBox(height: 8),

            // Menu items
            _buildMenuItem(
              context,
              icon: Icons.emoji_events_rounded,
              iconColor: AppColors.accentGold,
              label: 'My Rewards',
              subtitle: 'Badges, trophies & achievements',
              onTap: () {
                context.pop();
                // TODO: Navigate to rewards screen
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.work_rounded,
              iconColor: const Color(0xFF57CFFF),
              label: 'My Portfolio',
              subtitle: 'Projects & completed missions',
              onTap: () {
                context.pop();
                // TODO: Navigate to portfolio screen
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.leaderboard_rounded,
              iconColor: AppColors.accentOrange,
              label: 'My Ranking',
              subtitle: 'Global & guild leaderboards',
              onTap: () {
                context.pop();
                // TODO: Navigate to ranking screen
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.diamond_rounded,
              iconColor: AppColors.secondary,
              label: 'Subscription',
              subtitle: 'Manage your ElevateX plan',
              onTap: () {
                context.pop();
                // TODO: Navigate to subscription screen
              },
            ),

            // Divider
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              color: AppColors.border,
            ),
            const SizedBox(height: 4),

            _buildMenuItem(
              context,
              icon: Icons.person_rounded,
              iconColor: AppColors.primary,
              label: 'Profile',
              subtitle: 'View & edit your profile',
              onTap: () {
                context.pop();
                context.push('/dashboard/profile');
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.storefront_rounded,
              iconColor: AppColors.accentGold,
              label: 'Store',
              subtitle: 'Power-ups, badges & more',
              onTap: () {
                context.pop();
                context.push('/store');
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.settings_rounded,
              iconColor: AppColors.textBody,
              label: 'Settings',
              subtitle: 'App preferences & account',
              onTap: () {
                context.pop();
                context.push('/settings');
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 12,
                ),
              ],
              image: const DecorationImage(
                image: NetworkImage("https://placehold.co/56x56"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name + level
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyles.h3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                            color: AppColors.accentGold.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.auto_awesome,
                              color: AppColors.accentGold, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            'Level $level',
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.accentGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Edit profile icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.edit_rounded,
                color: AppColors.textBody, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: iconColor.withValues(alpha: 0.08),
        highlightColor: iconColor.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),

              // Label + subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textBody,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.textBody, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
