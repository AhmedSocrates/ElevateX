import 'package:elevatex/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GuildRankBadge extends StatelessWidget {
  const GuildRankBadge({super.key, required this.rank, this.large = false});

  final int rank;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final _RankPalette palette = _paletteForRank(rank);
    final double size = large ? 48 : 40;
    final double fontSize = large ? 16 : 15;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: palette.background,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$rank',
        style: TextStyle(
          color: palette.foreground,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _RankPalette {
  const _RankPalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}

_RankPalette _paletteForRank(int rank) {
  if (rank == 1) {
    return _RankPalette(
      background: AppColors.accentGold.withValues(alpha: 0.2),
      foreground: AppColors.accentGold,
    );
  }
  if (rank == 2) {
    // Silver tone is not part of AppColors, so it stays local here.
    return const _RankPalette(
      background: Color(0x33A0A0A0),
      foreground: Color(0xFFA0A0A0),
    );
  }
  if (rank == 3) {
    // Bronze tone is not part of AppColors, so it stays local here.
    return const _RankPalette(
      background: Color(0x33CD7F32),
      foreground: Color(0xFFCD7F32),
    );
  }
  return const _RankPalette(
    background: Color(0xFF241445),
    foreground: AppColors.textBody,
  );
}
