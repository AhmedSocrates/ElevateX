import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/providers/auth_provider.dart';

// this will be the container that holds the messages sent between the user and the chatbot

class MessageContainer extends ConsumerWidget {
  final String message;
  final String senderId;
  final String? avatarUrl;

  const MessageContainer({
    super.key,
    required this.message,
    this.senderId = '0',
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final currentUser = ref.watch(authProvider).value;
    
    final isMe = currentUser?.id == senderId;

    final avatarWidget = CircleAvatar(
      radius: 16,
      backgroundColor: AppColors.primary,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      // Fallback to bot icon if no avatar URL is provided
      child: avatarUrl == null 
          ? const Icon(Icons.smart_toy, size: 20, color: Colors.white) 
          : null,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            avatarWidget,
            const SizedBox(width: 8),
          ],

          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.75, 
            ),
            
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.secondary : AppColors.surfaceLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  // Flat corner at the bottom depending on who sent it
                  bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: AppTextStyles.bodyLg,
              ),
            ),
          ),

          if (isMe) ...[
            const SizedBox(width: 8),
            avatarWidget,
          ],
        ],
      ),
    );
  }
}