import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_surface_card.dart';
import '../providers/mission_provider.dart';
import '../models/mission_model.dart';

class MissionsScreen extends ConsumerStatefulWidget {
  const MissionsScreen({super.key});

  @override
  ConsumerState<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends ConsumerState<MissionsScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  late AnimationController _shimmerController;

  final List<String> _filters = [
    'All',
    'Frontend',
    'Bug Fix',
    'Refactor',
    'Algorithm',
  ];

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Frontend':
        return AppColors.primary;
      case 'Bug Fix':
        return AppColors.accentOrange;
      case 'Refactor':
        return const Color(0xFF57CFFF);
      case 'Algorithm':
        return AppColors.accentGold;
      default:
        return AppColors.primary;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Frontend':
        return Icons.web_rounded;
      case 'Bug Fix':
        return Icons.bug_report_rounded;
      case 'Refactor':
        return Icons.auto_fix_high_rounded;
      case 'Algorithm':
        return Icons.data_array_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Icons.signal_cellular_alt_1_bar_rounded;
      case 'Medium':
        return Icons.signal_cellular_alt_2_bar_rounded;
      case 'Hard':
        return Icons.signal_cellular_alt_rounded;
      default:
        return Icons.signal_cellular_alt_2_bar_rounded;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return const Color(0xFF57FF8E);
      case 'Medium':
        return AppColors.accentGold;
      case 'Hard':
        return AppColors.accentOrange;
      default:
        return AppColors.accentGold;
    }
  }

  @override
  Widget build(BuildContext context) {
    final missionsState = ref.watch(missionProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 8),
            Expanded(
              child: missionsState.when(
                data: (missions) {
                  final filtered = _selectedFilter == 'All'
                      ? missions
                      : missions
                          .where((m) => m.type == _selectedFilter)
                          .toList();
                  return _buildMissionList(filtered);
                },
                loading: () => _buildLoadingShimmer(),
                error: (err, stack) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline,
                          color: AppColors.accentOrange, size: 48),
                      const SizedBox(height: 12),
                      Text('Failed to load missions',
                          style: AppTextStyles.bodyMd),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(missionProvider),
                        child: Text('Retry',
                            style: AppTextStyles.bodyMd
                                .copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.rocket_launch_rounded,
                    color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Epic Missions', style: AppTextStyles.h2),
                  Text('Advanced coding challenges',
                      style: AppTextStyles.bodySm),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.filter_list_rounded,
                color: AppColors.textBody, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: ShapeDecoration(
                  color: isSelected
                      ? AppColors.surfaceLight
                      : const Color(0xFF241445),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Text(
                  filter,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: isSelected ? AppColors.white : AppColors.textBody,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMissionList(List<MissionModel> missions) {
    if (missions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                color: AppColors.textBody.withOpacity(0.5), size: 64),
            const SizedBox(height: 12),
            Text(
              'No missions found',
              style: AppTextStyles.bodyLg.copyWith(color: AppColors.textBody),
            ),
            const SizedBox(height: 4),
            Text(
              'Try selecting a different filter',
              style: AppTextStyles.bodySm,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: missions.length,
      itemBuilder: (context, index) {
        return _buildMissionCard(missions[index], index);
      },
    );
  }

  Widget _buildMissionCard(MissionModel mission, int index) {
    final typeColor = _getTypeColor(mission.type);
    final difficultyColor = _getDifficultyColor(mission.difficulty);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.go('/missions/${mission.id}'),
            borderRadius: BorderRadius.circular(12),
            splashColor: typeColor.withOpacity(0.1),
            highlightColor: typeColor.withOpacity(0.05),
            child: CustomSurfaceCard(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top gradient accent bar
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: [typeColor, typeColor.withOpacity(0.3)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type badge + Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(_getTypeIcon(mission.type),
                                    color: typeColor, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  mission.type,
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: typeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: ShapeDecoration(
                                color: AppColors.textBody.withOpacity(0.15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                              child: Text(
                                'available',
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.textBody,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Title
                        Text(
                          mission.title,
                          style: AppTextStyles.h3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),

                        // Description
                        Text(
                          mission.description,
                          style: AppTextStyles.bodySm,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),

                        // Bottom row: XP + Difficulty + Arrow
                        Row(
                          children: [
                            // XP badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF241445),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.auto_awesome,
                                      color: AppColors.accentGold, size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${mission.xpReward} XP',
                                    style: AppTextStyles.bodySm.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Difficulty badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF241445),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                      _getDifficultyIcon(mission.difficulty),
                                      color: difficultyColor,
                                      size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    mission.difficulty,
                                    style: AppTextStyles.bodySm.copyWith(
                                      color: difficultyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(),

                            // Navigate arrow
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: typeColor.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.arrow_forward_rounded,
                                  color: typeColor, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, _) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.surface,
                        AppColors.surfaceLight.withOpacity(0.5),
                        AppColors.surface,
                      ],
                      stops: [
                        _shimmerController.value - 0.3,
                        _shimmerController.value,
                        _shimmerController.value + 0.3,
                      ].map((s) => s.clamp(0.0, 1.0)).toList(),
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 200,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 80,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}