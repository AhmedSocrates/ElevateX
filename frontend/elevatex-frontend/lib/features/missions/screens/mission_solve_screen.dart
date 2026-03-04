import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../providers/mission_provider.dart';
import '../models/mission_model.dart';

class MissionSolveScreen extends ConsumerStatefulWidget {
  final String missionId;

  const MissionSolveScreen({super.key, required this.missionId});

  @override
  ConsumerState<MissionSolveScreen> createState() => _MissionSolveScreenState();
}

class _MissionSolveScreenState extends ConsumerState<MissionSolveScreen>
    with TickerProviderStateMixin {
  late TextEditingController _codeController;
  bool _isDescriptionExpanded = true;
  bool _isCompilerExpanded = true;
  bool _isSubmitting = false;
  bool _isInitialized = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _initializeCode(MissionModel mission) {
    if (!_isInitialized) {
      _codeController.text = mission.initialCode;
      _isInitialized = true;
    }
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

  Future<void> _handleSubmit(MissionModel mission) async {
    setState(() => _isSubmitting = true);

    // Simulate a 2-second compile/check
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _buildSuccessDialog(ctx, mission),
    );
  }

  Widget _buildSuccessDialog(BuildContext ctx, MissionModel mission) {
    final typeColor = _getTypeColor(mission.type);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: typeColor.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: typeColor.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated checkmark circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [typeColor, typeColor.withOpacity(0.6)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: typeColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.check_rounded,
                  color: Colors.white, size: 44),
            ),
            const SizedBox(height: 20),
            Text(
              'Mission Accomplished!',
              style: AppTextStyles.h2.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              mission.title,
              style: AppTextStyles.bodySm,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // XP badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.accentGold.withOpacity(0.15),
                borderRadius: BorderRadius.circular(9999),
                border:
                    Border.all(color: AppColors.accentGold.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome,
                      color: AppColors.accentGold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '+${mission.xpReward} XP',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.accentGold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Back button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: typeColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final missionsState = ref.watch(missionProvider);

    return missionsState.when(
      data: (missions) {
        final mission = missions.firstWhere(
          (m) => m.id == widget.missionId,
          orElse: () => MissionModel(
            id: '0',
            title: 'Mission Not Found',
            description: 'This mission could not be found.',
            type: 'Unknown',
            xpReward: 0,
            initialCode: '',
            goal: '',
          ),
        );

        if (mission.id == '0') {
          return _buildErrorState();
        }

        _initializeCode(mission);
        return _buildContent(mission);
      },
      loading: () => Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
      error: (err, stack) => _buildErrorState(),
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline,
                color: AppColors.accentOrange, size: 56),
            const SizedBox(height: 16),
            Text('Mission not found', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text('This mission may have been removed.',
                style: AppTextStyles.bodySm),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.pop(),
              child: Text('Go Back',
                  style: AppTextStyles.bodyMd
                      .copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(MissionModel mission) {
    final typeColor = _getTypeColor(mission.type);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            _buildAppBar(mission, typeColor),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    _buildDescriptionSection(mission, typeColor),
                    const SizedBox(height: 16),
                    _buildCompilerSection(mission, typeColor),
                    const SizedBox(height: 24),
                    _buildSubmitButton(mission, typeColor),
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

  Widget _buildAppBar(MissionModel mission, Color typeColor) {
    return Container(
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
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.white, size: 18),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.title,
                  style: AppTextStyles.bodyLg
                      .copyWith(fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(_getTypeIcon(mission.type),
                        color: typeColor, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      mission.type,
                      style: AppTextStyles.label.copyWith(
                        color: typeColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textBody.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.auto_awesome,
                        color: AppColors.accentGold, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      '${mission.xpReward} XP',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.accentGold,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(MissionModel mission, Color typeColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header - tappable to expand/collapse
          InkWell(
            onTap: () =>
                setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                      Radius.circular(_isDescriptionExpanded ? 0 : 12),
                  bottomRight:
                      Radius.circular(_isDescriptionExpanded ? 0 : 12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.menu_book_rounded, color: typeColor, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Mission Briefing',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isDescriptionExpanded ? 0.0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: typeColor, size: 24),
                  ),
                ],
              ),
            ),
          ),

          // Expandable body
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isDescriptionExpanded
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Narrative description
                        Text(mission.description,
                            style: AppTextStyles.bodyMd.copyWith(height: 1.6)),
                        const SizedBox(height: 16),

                        // Goal section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.accentGold.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    AppColors.accentGold.withOpacity(0.2)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.flag_rounded,
                                  color: AppColors.accentGold, size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GOAL',
                                      style: AppTextStyles.label.copyWith(
                                        color: AppColors.accentGold,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      mission.goal,
                                      style: AppTextStyles.bodySm.copyWith(
                                          color: AppColors.white,
                                          height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // XP + Difficulty row
                        Row(
                          children: [
                            _buildInfoChip(
                              icon: Icons.auto_awesome,
                              label: '${mission.xpReward} XP',
                              color: AppColors.accentGold,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              icon: Icons.signal_cellular_alt_rounded,
                              label: mission.difficulty,
                              color: mission.difficulty == 'Hard'
                                  ? AppColors.accentOrange
                                  : AppColors.accentGold,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              icon: _getTypeIcon(mission.type),
                              label: mission.type,
                              color: typeColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompilerSection(MissionModel mission, Color typeColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () =>
                setState(() => _isCompilerExpanded = !_isCompilerExpanded),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E).withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft:
                      Radius.circular(_isCompilerExpanded ? 0 : 12),
                  bottomRight:
                      Radius.circular(_isCompilerExpanded ? 0 : 12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.terminal_rounded,
                      color: Color(0xFF57FF8E), size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Code Editor',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  // File indicator
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      mission.type == 'Frontend' ? 'style.css' : 'main.dart',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textBody,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: _isCompilerExpanded ? 0.0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF57FF8E), size: 24),
                  ),
                ],
              ),
            ),
          ),

          // Code editor body
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isCompilerExpanded
                ? Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 280),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Line numbers + code area
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Line numbers
                              SizedBox(
                                width: 32,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(
                                    _codeController.text.split('\n').length,
                                    (i) => Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 0.5),
                                      child: Text(
                                        '${i + 1}',
                                        style: const TextStyle(
                                          color: Color(0xFF555555),
                                          fontSize: 13,
                                          fontFamily: 'monospace',
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 1,
                                height: _codeController.text.split('\n').length *
                                    19.5,
                                color: const Color(0xFF333333),
                              ),
                              const SizedBox(width: 8),
                              // Code input
                              Expanded(
                                child: TextField(
                                  controller: _codeController,
                                  maxLines: null,
                                  style: const TextStyle(
                                    color: Color(0xFFD4D4D4),
                                    fontSize: 13,
                                    fontFamily: 'monospace',
                                    height: 1.5,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                  cursorColor: const Color(0xFF57FF8E),
                                  cursorWidth: 2,
                                  onChanged: (_) => setState(() {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Bottom toolbar
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF262626),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline_rounded,
                                  color: Color(0xFF555555), size: 14),
                              const SizedBox(width: 6),
                              Text(
                                '${_codeController.text.split('\n').length} lines',
                                style: const TextStyle(
                                  color: Color(0xFF555555),
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              const Spacer(),
                              Text(
                                mission.type == 'Frontend' ? 'CSS' : 'Dart',
                                style: const TextStyle(
                                  color: Color(0xFF555555),
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(MissionModel mission, Color typeColor) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: _isSubmitting
                  ? [
                      AppColors.surfaceLight,
                      AppColors.surface,
                    ]
                  : [
                      typeColor,
                      typeColor.withOpacity(0.7),
                    ],
            ),
            boxShadow: _isSubmitting
                ? []
                : [
                    BoxShadow(
                      color: typeColor
                          .withOpacity(0.4 * _pulseAnimation.value),
                      blurRadius: 16,
                      spreadRadius: 0,
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _isSubmitting ? null : () => _handleSubmit(mission),
              borderRadius: BorderRadius.circular(9999),
              child: Center(
                child: _isSubmitting
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: typeColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Compiling & Testing...',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.textBody,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.play_arrow_rounded,
                              color: Colors.white, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Run Code & Submit',
                            style: AppTextStyles.bodyMd.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
