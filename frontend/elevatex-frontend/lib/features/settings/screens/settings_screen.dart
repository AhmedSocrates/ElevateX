import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _muteSounds = false;
  bool _pushNotifications = true;
  bool _dailyReminders = true;
  bool _darkMode = true; // Always on for ElevateX vibe
  bool _streakAlerts = true;
  bool _hapticFeedback = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar
            _buildAppBar(),
            // Settings list
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Sound & Haptics section
                    _buildSectionLabel('SOUND & HAPTICS'),
                    const SizedBox(height: 8),
                    _buildSettingsCard([
                      _buildSwitchTile(
                        icon: Icons.volume_off_rounded,
                        iconColor: AppColors.accentOrange,
                        title: 'Mute Sounds',
                        subtitle: 'Silence all in-app sounds',
                        value: _muteSounds,
                        onChanged: (v) => setState(() => _muteSounds = v),
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        icon: Icons.vibration_rounded,
                        iconColor: AppColors.primary,
                        title: 'Haptic Feedback',
                        subtitle: 'Vibrations on interactions',
                        value: _hapticFeedback,
                        onChanged: (v) => setState(() => _hapticFeedback = v),
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Notifications section
                    _buildSectionLabel('NOTIFICATIONS'),
                    const SizedBox(height: 8),
                    _buildSettingsCard([
                      _buildSwitchTile(
                        icon: Icons.notifications_rounded,
                        iconColor: AppColors.accentGold,
                        title: 'Push Notifications',
                        subtitle: 'Receive updates & challenges',
                        value: _pushNotifications,
                        onChanged: (v) =>
                            setState(() => _pushNotifications = v),
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        icon: Icons.alarm_rounded,
                        iconColor: const Color(0xFF57CFFF),
                        title: 'Daily Reminders',
                        subtitle: 'Get reminded to practice',
                        value: _dailyReminders,
                        onChanged: (v) =>
                            setState(() => _dailyReminders = v),
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        icon: Icons.local_fire_department_rounded,
                        iconColor: AppColors.accentOrange,
                        title: 'Streak Alerts',
                        subtitle: 'Don\'t lose your streak!',
                        value: _streakAlerts,
                        onChanged: (v) =>
                            setState(() => _streakAlerts = v),
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Appearance section
                    _buildSectionLabel('APPEARANCE'),
                    const SizedBox(height: 8),
                    _buildSettingsCard([
                      _buildSwitchTile(
                        icon: Icons.dark_mode_rounded,
                        iconColor: AppColors.secondary,
                        title: 'Dark Mode',
                        subtitle: 'The way it was meant to be',
                        value: _darkMode,
                        onChanged: (v) => setState(() => _darkMode = v),
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Account section
                    _buildSectionLabel('ACCOUNT'),
                    const SizedBox(height: 8),
                    _buildSettingsCard([
                      _buildNavTile(
                        icon: Icons.person_rounded,
                        iconColor: AppColors.primary,
                        title: 'Edit Profile',
                        subtitle: 'Update your name & avatar',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildNavTile(
                        icon: Icons.lock_rounded,
                        iconColor: AppColors.textBody,
                        title: 'Change Password',
                        subtitle: 'Update your security credentials',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildNavTile(
                        icon: Icons.shield_rounded,
                        iconColor: const Color(0xFF57FF8E),
                        title: 'Privacy & Data',
                        subtitle: 'Manage your data preferences',
                        onTap: () {},
                      ),
                    ]),
                    const SizedBox(height: 24),

                    // Danger zone
                    _buildSectionLabel('DANGER ZONE'),
                    const SizedBox(height: 8),
                    _buildSettingsCard([
                      _buildNavTile(
                        icon: Icons.logout_rounded,
                        iconColor: AppColors.accentOrange,
                        title: 'Log Out',
                        subtitle: 'Sign out of your account',
                        onTap: () {
                          // TODO: Wire up auth logout
                        },
                        isDestructive: true,
                      ),
                      _buildDivider(),
                      _buildNavTile(
                        icon: Icons.delete_forever_rounded,
                        iconColor: const Color(0xFFFF5252),
                        title: 'Delete Account',
                        subtitle: 'Permanently remove your data',
                        onTap: () {},
                        isDestructive: true,
                      ),
                    ]),
                    const SizedBox(height: 32),

                    // Version info
                    Center(
                      child: Text(
                        'ElevateX v1.0.0',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.textBody.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.white, size: 18),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.settings_rounded,
              color: AppColors.textBody, size: 22),
          const SizedBox(width: 8),
          Text('Settings', style: AppTextStyles.h3),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color: AppColors.textBody,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 72),
      color: AppColors.border.withValues(alpha: 0.5),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(subtitle,
                    style: AppTextStyles.label
                        .copyWith(color: AppColors.textBody, fontSize: 11)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.4),
            inactiveThumbColor: AppColors.textBody,
            inactiveTrackColor: AppColors.surfaceLight,
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMd.copyWith(
                        color: isDestructive
                            ? AppColors.accentOrange
                            : AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(subtitle,
                        style: AppTextStyles.label
                            .copyWith(color: AppColors.textBody, fontSize: 11)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: isDestructive
                      ? AppColors.accentOrange.withValues(alpha: 0.5)
                      : AppColors.textBody,
                  size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
