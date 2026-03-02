import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class CustomMultilinetextfield extends StatelessWidget {
  
  final TextEditingController messageController;
  final String placeholder;
  const CustomMultilinetextfield({
    super.key,
    required this.messageController,
    required this.placeholder
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: messageController,
        minLines: 1,
        maxLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTextStyles.bodyMd,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border, width: 3),
            borderRadius: BorderRadius.circular(10)
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border, width: 3),
            borderRadius: BorderRadius.circular(10)
          ),
          
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondary, width: 3),
            borderRadius: BorderRadius.circular(10)
          ),
          
        ),
        
      ),
    );
  }
}