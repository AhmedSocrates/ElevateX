import 'package:elevatex/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GuildRankingStatChip extends StatelessWidget {
  const GuildRankingStatChip({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF241445),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label $value',
        style: const TextStyle(
          color: AppColors.textBody,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
