import 'package:elevatex/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AvatarGlow extends StatelessWidget {
  const AvatarGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 41,
      height: 41,
      decoration: BoxDecoration(
        color: AppColors.accentOrange.withAlpha(31),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: const Icon(Icons.person, color: AppColors.white, size: 18),
        ),
      ),
    );
  }
}
