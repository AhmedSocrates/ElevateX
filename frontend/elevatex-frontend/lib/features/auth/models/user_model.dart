class UserModel {
  final String id;
  final String name;
  final int level;
  final int totalXp;
  final int currentStreak;

  UserModel({
    required this.id,
    required this.name,
    required this.level,
    required this.totalXp,
    required this.currentStreak,
  });

  UserModel copyWith({
    String? id,
    String? name,
    int? level,
    int? totalXp,
    int? currentStreak,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      totalXp: totalXp ?? this.totalXp,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }
}
