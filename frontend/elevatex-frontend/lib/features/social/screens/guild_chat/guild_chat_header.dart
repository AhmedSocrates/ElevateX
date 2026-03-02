import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/social/screens/guild_chat/header_circle_button.dart';
import 'package:flutter/material.dart';

class GuildChatHeader extends StatelessWidget {
  const GuildChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderCircleButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(width: 12),
        const Text(
          'Wizard Guild',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
