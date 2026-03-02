import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';


class ChatMessage {
  final String text;
  final String senderId;
  final String? avatarUrl;

  ChatMessage({
    required this.text,
    this.senderId = "0",
    this.avatarUrl,
  });
}

// 2. The AsyncNotifier
class ChatNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  FutureOr<List<ChatMessage>> build() async {
    return [
      ChatMessage(
        text: "Hello! I am your AI Mentor. How can I help you level up today?",
        senderId: "0",
      ),
    ];
  }

  
  Future<void> sendMessage(String text, String userId, String? userAvatar) async {
    
    final currentMessages = state.value ?? [];

    final userMessage = ChatMessage(
      text: text,
      senderId: userId,
      avatarUrl: userAvatar,
    );
    state = AsyncData([...currentMessages, userMessage]);

    // simulate the request time
    await Future.delayed(const Duration(seconds: 2));
    final updatedMessages = state.value ?? [];

    // response test
    final botMessage = ChatMessage(
      text: "I received your message: '$text'. Let's break that down into an actionable quest!",
      senderId: "0",
    );
    
    state = AsyncData([...updatedMessages, botMessage]);
  }
}


final chatProvider = AsyncNotifierProvider<ChatNotifier, List<ChatMessage>>(
  ChatNotifier.new,
);