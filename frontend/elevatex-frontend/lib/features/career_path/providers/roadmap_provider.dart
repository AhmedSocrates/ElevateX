import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the user's progress in the Frontend Career Roadmap.
/// 0: HTML Basics unlocked
/// 1: CSS Magic unlocked (HTML complete)
/// 2: JS Spells unlocked (CSS complete)
/// 3: React Sorcery unlocked (JS complete)
/// 4: All complete
final frontendProgressProvider = StateProvider<int>((ref) => 1);
