import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/core/theme/app_text_styles.dart';
import 'package:elevatex/features/ai_mentor/widgets/customIconButton.dart';
import 'package:elevatex/features/ai_mentor/widgets/customMultiLineTextField.dart';
import 'package:elevatex/features/ai_mentor/widgets/message_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../providers/chat_provider.dart';


// for testing purposes
class ChatMessage {
  final String text;
  // to check whether to put the message on the left or right
  final String senderId;
  // link to the avatar url
  final String? avatar;

  ChatMessage({required this.text,this.senderId = "0", this.avatar});
}

class AiMentorScreen extends ConsumerStatefulWidget {
  const AiMentorScreen({super.key});

  @override
  ConsumerState<AiMentorScreen> createState() => _AiMentorScreenState();
}

class _AiMentorScreenState extends ConsumerState<AiMentorScreen> {
  
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSend() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    
    final currentUser = ref.read(authProvider).value;
    final userId = currentUser?.id ?? '1';
    final userAvatar = "https://placehold.co/100x100.png";

    ref.read(chatProvider.notifier).sendMessage(text, userId, userAvatar);
    
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("AI MENTOR", style: AppTextStyles.h3),
        centerTitle: true,
      ),
      
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(          
              child: chatState.when(
                data: (messages) {
                  final reversedMessages = messages.reversed.toList();
                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: reversedMessages.length,
                    itemBuilder: (context, index) {
                      final msg = reversedMessages[index];
                      return MessageContainer(
                        message: msg.text,
                        senderId: msg.senderId,
                        avatarUrl: msg.avatarUrl,
                      );
                    }
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error loading chat: $err')),
              ),
            ),
            
            // bottom text field and send button
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsetsGeometry.directional(start: 10, end: 10, top: 10, bottom: 5),
                child: Row(
                  children: [
                    CustomMultilinetextfield(messageController: _messageController, placeholder: "Send your message...",),

                    CustomIconButton(
                      icon: CupertinoIcons.paperplane,
                      onPressed: _handleSend,
                      valueListenable: _messageController,
                      
                      ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}