import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class _StoreItem {
  final String id;
  final String name;
  final String description;
  final int cost;
  final IconData icon;
  final Color accentColor;
  final String category;

  const _StoreItem({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.icon,
    required this.accentColor,
    required this.category,
  });
}

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({super.key});

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  int _userGems = 240; // Mock gem balance derived from XP

  final List<_StoreItem> _items = const [
    _StoreItem(
      id: 'streak_pauser',
      name: 'Streak Pauser',
      description: 'Protects your streak if you miss a day. Use it wisely!',
      cost: 50,
      icon: Icons.pause_circle_filled_rounded,
      accentColor: AppColors.accentOrange,
      category: 'Power-Ups',
    ),
    _StoreItem(
      id: 'exclusive_badge',
      name: 'Exclusive Badge',
      description:
          'Show off your dedication with this rare collector\'s badge.',
      cost: 100,
      icon: Icons.workspace_premium_rounded,
      accentColor: AppColors.accentGold,
      category: 'Badges',
    ),
    _StoreItem(
      id: 'xp_doubler',
      name: 'XP Doubler',
      description:
          'Double your XP earnings for the next 24 hours. Stack the gains!',
      cost: 150,
      icon: Icons.bolt_rounded,
      accentColor: AppColors.primary,
      category: 'Power-Ups',
    ),
    _StoreItem(
      id: 'mystery_chest',
      name: 'Mystery Chest',
      description:
          'Contains a random reward — could be gems, badges, or XP boosts.',
      cost: 75,
      icon: Icons.inventory_2_rounded,
      accentColor: AppColors.secondary,
      category: 'Chests',
    ),
  ];

  void _handleBuy(_StoreItem item) {
    if (_userGems < item.cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.surface,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.accentOrange, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Not enough gems! You need ${item.cost - _userGems} more.',
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }

    setState(() => _userGems -= item.cost);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _buildPurchaseDialog(ctx, item),
    );
  }

  Widget _buildPurchaseDialog(BuildContext ctx, _StoreItem item) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: item.accentColor.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: item.accentColor.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.accentColor,
                    item.accentColor.withValues(alpha: 0.5),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: item.accentColor.withValues(alpha: 0.3),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(item.icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 16),
            Text('Item Acquired!',
                style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(
              item.name,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.textBody),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Cost deducted badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: item.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9999),
                border:
                    Border.all(color: item.accentColor.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.diamond_rounded,
                      color: AppColors.accentGold, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    '-${item.cost} Gems',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.accentGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Awesome!',
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    _buildGemBalance(),
                    const SizedBox(height: 24),
                    _buildSectionLabel('POWER-UPS'),
                    const SizedBox(height: 12),
                    ..._items
                        .where((i) => i.category == 'Power-Ups')
                        .map((item) => _buildStoreCard(item)),
                    const SizedBox(height: 24),
                    _buildSectionLabel('COLLECTIBLES'),
                    const SizedBox(height: 12),
                    ..._items
                        .where(
                            (i) => i.category == 'Badges' || i.category == 'Chests')
                        .map((item) => _buildStoreCard(item)),
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
          const Icon(Icons.storefront_rounded,
              color: AppColors.accentGold, size: 22),
          const SizedBox(width: 8),
          Text('Store', style: AppTextStyles.h3),
          const Spacer(),
          // Gems badge in app bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9999),
              border:
                  Border.all(color: AppColors.accentGold.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.diamond_rounded,
                    color: AppColors.accentGold, size: 16),
                const SizedBox(width: 6),
                Text(
                  '$_userGems',
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildGemBalance() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.surfaceLight.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Gem icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accentGold,
                  AppColors.accentGold.withValues(alpha: 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGold.withValues(alpha: 0.3),
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Icon(Icons.diamond_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Gems',
                    style: AppTextStyles.bodySm
                        .copyWith(color: AppColors.textBody)),
                const SizedBox(height: 2),
                Text(
                  '$_userGems',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.accentGold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          // Buy more gems button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              '+ Buy Gems',
              style: AppTextStyles.bodySm
                  .copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
            ),
          ),
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

  Widget _buildStoreCard(_StoreItem item) {
    final canAfford = _userGems >= item.cost;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Top accent bar
            Container(
              height: 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                gradient: LinearGradient(
                  colors: [
                    item.accentColor,
                    item.accentColor.withValues(alpha: 0.2),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item icon
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: item.accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: item.accentColor.withValues(alpha: 0.2)),
                    ),
                    child: Icon(item.icon, color: item.accentColor, size: 26),
                  ),
                  const SizedBox(width: 14),

                  // Info column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppTextStyles.bodyMd.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: AppTextStyles.bodySm.copyWith(height: 1.4),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),

                        // Price + Buy row
                        Row(
                          children: [
                            // Price tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF241445),
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.diamond_rounded,
                                      color: AppColors.accentGold, size: 14),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${item.cost}',
                                    style: AppTextStyles.bodySm.copyWith(
                                      color: AppColors.accentGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),

                            // Buy button
                            GestureDetector(
                              onTap: () => _handleBuy(item),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: canAfford
                                      ? LinearGradient(
                                          colors: [
                                            item.accentColor,
                                            item.accentColor
                                                .withValues(alpha: 0.7),
                                          ],
                                        )
                                      : null,
                                  color: canAfford
                                      ? null
                                      : AppColors.surfaceLight,
                                  borderRadius: BorderRadius.circular(9999),
                                  boxShadow: canAfford
                                      ? [
                                          BoxShadow(
                                            color: item.accentColor
                                                .withValues(alpha: 0.3),
                                            blurRadius: 8,
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Text(
                                  canAfford ? 'Buy' : 'Not enough',
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: canAfford
                                        ? AppColors.white
                                        : AppColors.textBody,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
