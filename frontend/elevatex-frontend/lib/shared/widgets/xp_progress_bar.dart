import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class XpProgressBar extends StatelessWidget {
  final double progress; // Value between 0.0 and 1.0
  final double height;

  const XpProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.00, 0.50),
              end: Alignment(1.00, 0.50),
              colors: [AppColors.primary, AppColors.secondary],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x7F8E74FF),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
