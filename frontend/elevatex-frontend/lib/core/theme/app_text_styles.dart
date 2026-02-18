import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'Inter';

  static const TextStyle h1 = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static const TextStyle h2 = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    height: 1.57,
  );

  static const TextStyle h3 = TextStyle(
    color: AppColors.white,
    fontSize: 17,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    height: 1.65,
  );

  static const TextStyle bodyLg = TextStyle(
    color: AppColors.white,
    fontSize: 15,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    height: 1.83,
  );

  static const TextStyle bodyMd = TextStyle(
    color: AppColors.textBody,
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    height: 1.76,
  );

  static const TextStyle bodySm = TextStyle(
    color: AppColors.textBody,
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    height: 1.68,
  );

  static const TextStyle label = TextStyle(
    color: AppColors.textBody,
    fontSize: 10,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    height: 1.57,
  );
}
