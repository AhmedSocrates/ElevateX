import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_models.dart';
import 'package:flutter/material.dart';

class GuildRankingScopeToggle extends StatelessWidget {
  const GuildRankingScopeToggle({
    super.key,
    required this.selectedScope,
    required this.onScopeChanged,
  });

  final GuildRankingScope selectedScope;
  final ValueChanged<GuildRankingScope> onScopeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF241445),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _ScopeOption(
              title: 'Global',
              isSelected: selectedScope == GuildRankingScope.global,
              onTap: () => onScopeChanged(GuildRankingScope.global),
            ),
          ),
          Expanded(
            child: _ScopeOption(
              title: 'Friends',
              isSelected: selectedScope == GuildRankingScope.friends,
              onTap: () => onScopeChanged(GuildRankingScope.friends),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScopeOption extends StatelessWidget {
  const _ScopeOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceLight : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.textBody,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
