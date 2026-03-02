import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';


// this class is for icon button near the multiLine text field
// the boolean variable isTyping is to change the color of the button and make it clickable
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final ValueListenable valueListenable;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.valueListenable,
    });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (context, value, child) {
        final isTyping = value.text.isNotEmpty;
        return Padding(
          padding: const EdgeInsetsGeometry.only(left: 10),
          child: GestureDetector(
            onTap: () {
              if(isTyping) {
                onPressed();
              }
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isTyping ? AppColors.secondary : AppColors.border , width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 3, right: 5),
                child: Icon(icon, color: isTyping ? AppColors.secondary : AppColors.border, size: 30,),
              ),
            ),
          ),
        );
      }
    );
  }
}