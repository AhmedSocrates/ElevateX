import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProgress {
  final int currentXp;
  final int level;
  final int nextLevelXp;

  UserProgress({
    required this.currentXp,
    required this.level,
    required this.nextLevelXp,
  });

  double get progress => currentXp / nextLevelXp;
}

final progressProvider = NotifierProvider<ProgressNotifier, UserProgress>(ProgressNotifier.new);

class ProgressNotifier extends Notifier<UserProgress> {
  @override
  UserProgress build() {
    return UserProgress(
      currentXp: 750,
      level: 12,
      nextLevelXp: 1000,
    );
  }

  void addXp(int xp) {
    int newXp = state.currentXp + xp;
    if (newXp >= state.nextLevelXp) {
      state = UserProgress(
        currentXp: newXp - state.nextLevelXp,
        level: state.level + 1,
        nextLevelXp: state.nextLevelXp + 200,
      );
    } else {
      state = UserProgress(
        currentXp: newXp,
        level: state.level,
        nextLevelXp: state.nextLevelXp,
      );
    }
  }
}
