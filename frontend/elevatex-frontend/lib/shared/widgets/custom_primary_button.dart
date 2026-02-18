import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: isOutlined
          ? ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: AppColors.primary),
                borderRadius: BorderRadius.circular(9999),
              ),
            )
          : ShapeDecoration(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(9999),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd.copyWith(
                color: isOutlined ? AppColors.primary : AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
