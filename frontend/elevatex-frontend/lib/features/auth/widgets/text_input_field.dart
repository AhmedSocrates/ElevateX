import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ElevateTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const ElevateTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.textInputAction,
    required this.textInputType,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          labelStyle: AppTextStyles.label,
          hintText: hintText,
          hintStyle: AppTextStyles.label,
      
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
      
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border, width: 3),
            borderRadius: BorderRadius.circular(10)
          )
        ),
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        validator: validator
      ),
    );
    
  }
}