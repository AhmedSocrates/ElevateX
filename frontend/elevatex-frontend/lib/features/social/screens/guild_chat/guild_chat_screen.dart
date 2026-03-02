import 'package:elevatex/core/theme/app_colors.dart';
import 'package:elevatex/features/ai_mentor/widgets/customIconButton.dart';
import 'package:elevatex/features/ai_mentor/widgets/customMultiLineTextField.dart';
import 'package:elevatex/features/social/screens/guild_chat/avatar_glow.dart';
import 'package:elevatex/features/social/screens/guild_chat/guild_chat_header.dart';
import 'package:elevatex/features/social/screens/guild_chat/message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GuildChatScreen extends StatefulWidget {

  const GuildChatScreen({super.key});

  @override
  State<GuildChatScreen> createState() => _GuildChatScreenState();
}

class _GuildChatScreenState extends State<GuildChatScreen> {
 
  final TextEditingController _messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const GuildChatHeader(),
              const SizedBox(height: 28),
              Expanded(
                child: Stack(
                  children: const [
                    Positioned(
                      left: 60,
                      top: 18,
                      child: MessageBubble(
                        width: 255,
                        sender: 'MagicDev - Leader',
                        message:
                            'Hello guys, let us complete today\'s quest!!\nWho is in?',
                      ),
                    ),
                    Positioned(left: 0, top: 108, child: AvatarGlow()),
                    Positioned(
                      left: 60,
                      top: 172,
                      child: MessageBubble(
                        width: 164,
                        sender: 'CodeWizard - Member',
                        message: 'Count me in!!',
                      ),
                    ),
                    Positioned(left: 0, top: 204, child: AvatarGlow()),
                    Positioned(
                      left: 116,
                      top: 286,
                      child: MessageBubble(
                        width: 195,
                        sender: 'DragonCoder - Co-Leader',
                        message: 'I am also in!!\nLet us do it.',
                      ),
                    ),
                    Positioned(right: 0, top: 324, child: AvatarGlow()),
                  ],
                  
                ),
              ),
              _bottomBar()
            ],
          ),
        ),
      ),
    );
  }
  Widget _bottomBar() {
  return Container(
    color: Colors.transparent,
    child: Padding(
      padding: EdgeInsetsGeometry.directional(
        start: 15,
        end: 10,
        top: 34,
        bottom: 30,
      ),
      child: Row(
        children: [
          CustomMultilinetextfield(
            messageController: _messageController,
            placeholder: "Send your message...",
          ),

          CustomIconButton(
            icon: CupertinoIcons.paperplane,
            onPressed: (){},
            valueListenable: _messageController,
          ),
        ],
      ),
    ),
  );
}
}
