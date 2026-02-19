class GuildModel {
  final String id;
  final String name;
  final int memberCount;

  GuildModel({
    required this.id,
    required this.name,
    required this.memberCount,
  });

  GuildModel copyWith({
    String? id,
    String? name,
    int? memberCount,
  }) {
    return GuildModel(
      id: id ?? this.id,
      name: name ?? this.name,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}
