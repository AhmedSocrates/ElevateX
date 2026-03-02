enum GuildRankingScope { global, friends }

class GuildRankingEntry {
  const GuildRankingEntry({
    required this.rank,
    required this.name,
    required this.level,
    required this.xp,
    required this.streak,
    required this.avatarLabel,
    this.isCurrentUser = false,
  });

  final int rank;
  final String name;
  final int level;
  final int xp;
  final int streak;
  final String avatarLabel;
  final bool isCurrentUser;
}

class GuildRankingData {
  static const List<GuildRankingEntry> global = <GuildRankingEntry>[
    GuildRankingEntry(
      rank: 1,
      name: 'DragonCoder',
      level: 12,
      xp: 8750,
      streak: 24,
      avatarLabel: 'D',
    ),
    GuildRankingEntry(
      rank: 2,
      name: 'CodeWizard',
      level: 10,
      xp: 7200,
      streak: 16,
      avatarLabel: 'C',
    ),
    GuildRankingEntry(
      rank: 3,
      name: 'Apprentice Wizard',
      level: 3,
      xp: 2150,
      streak: 7,
      avatarLabel: 'A',
      isCurrentUser: true,
    ),
    GuildRankingEntry(
      rank: 4,
      name: 'MagicDev',
      level: 3,
      xp: 2050,
      streak: 5,
      avatarLabel: 'M',
    ),
    GuildRankingEntry(
      rank: 5,
      name: 'SpellCaster',
      level: 2,
      xp: 1600,
      streak: 3,
      avatarLabel: 'S',
    ),
  ];

  static const List<GuildRankingEntry> friends = <GuildRankingEntry>[
    GuildRankingEntry(
      rank: 1,
      name: 'DragonCoder',
      level: 12,
      xp: 8750,
      streak: 24,
      avatarLabel: 'D',
    ),
    GuildRankingEntry(
      rank: 2,
      name: 'Apprentice Wizard',
      level: 3,
      xp: 2150,
      streak: 7,
      avatarLabel: 'A',
      isCurrentUser: true,
    ),
    GuildRankingEntry(
      rank: 3,
      name: 'MagicDev',
      level: 3,
      xp: 2050,
      streak: 5,
      avatarLabel: 'M',
    ),
    GuildRankingEntry(
      rank: 4,
      name: 'SpellCaster',
      level: 2,
      xp: 1600,
      streak: 3,
      avatarLabel: 'S',
    ),
    GuildRankingEntry(
      rank: 5,
      name: 'CodeWizard',
      level: 10,
      xp: 7200,
      streak: 16,
      avatarLabel: 'C',
    ),
  ];
}

String formatXp(int value) {
  return value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (Match match) => ',',
  );
}
