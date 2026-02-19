import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quest_model.dart';

final questProvider = AsyncNotifierProvider<QuestNotifier, List<QuestModel>>(QuestNotifier.new);

class QuestNotifier extends AsyncNotifier<List<QuestModel>> {
  @override
  Future<List<QuestModel>> build() async {
    return fetchQuests();
  }

  Future<List<QuestModel>> fetchQuests() async {
    state = const AsyncLoading();
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    final quests = [
      QuestModel(
        id: '1',
        title: 'React Fundamentals',
        description: 'Master the basics of React hooks and components.',
        xpReward: 500,
        isCompleted: false,
      ),
      QuestModel(
        id: '2',
        title: 'State Management Wizardry',
        description: 'Learn how to manage complex state in modern web apps.',
        xpReward: 750,
        isCompleted: false,
      ),
      QuestModel(
        id: '3',
        title: 'API Sorcery',
        description: 'Connect your frontend to powerful backend services.',
        xpReward: 1000,
        isCompleted: true,
      ),
    ];
    
    state = AsyncData(quests);
    return quests;
  }
}
