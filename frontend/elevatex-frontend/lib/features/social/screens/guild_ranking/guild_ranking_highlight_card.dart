import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_rank_badge.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_models.dart';
import 'package:elevatex/features/social/screens/guild_ranking/guild_ranking_stat_chip.dart';
import 'package:flutter/material.dart';

class GuildRankingHighlightCard extends StatelessWidget {
  const GuildRankingHighlightCard({super.key, required this.entry});

  final GuildRankingEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          GuildRankBadge(rank: entry.rank, large: true),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.22),
            child: Text(
              entry.avatarLabel,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    GuildRankingStatChip(
                      label: 'Level',
                      value: '${entry.level}',
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${formatXp(entry.xp)} XP',
                      style: const TextStyle(
                        color: AppColors.textBody,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF241445),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${entry.streak}',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
