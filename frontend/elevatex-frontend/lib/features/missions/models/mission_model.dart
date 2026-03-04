class MissionModel {
  final String id;
  final String title;
  final String description;
  final String type; // e.g., 'Bug Fix', 'Refactor', 'Algorithm', 'Frontend'
  final int xpReward;
  final String initialCode;
  final String goal;
  final String difficulty; // 'Easy', 'Medium', 'Hard'

  MissionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.xpReward,
    required this.initialCode,
    required this.goal,
    this.difficulty = 'Medium',
  });

  MissionModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    int? xpReward,
    String? initialCode,
    String? goal,
    String? difficulty,
  }) {
    return MissionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      xpReward: xpReward ?? this.xpReward,
      initialCode: initialCode ?? this.initialCode,
      goal: goal ?? this.goal,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
