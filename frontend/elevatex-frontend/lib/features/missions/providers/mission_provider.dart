import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mission_model.dart';

final missionProvider =
    AsyncNotifierProvider<MissionNotifier, List<MissionModel>>(
        MissionNotifier.new);

class MissionNotifier extends AsyncNotifier<List<MissionModel>> {
  @override
  Future<List<MissionModel>> build() async {
    return fetchMissions();
  }

  Future<List<MissionModel>> fetchMissions() async {
    state = const AsyncLoading();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final missions = [
      MissionModel(
        id: '1',
        title: 'The Enchanted Interface',
        description:
            'A dark sorcerer has corrupted the kingdom\'s dashboard. The layout is shattered — columns overlap, spacing is broken, and the sacred grid has collapsed. You must restore order using the ancient arts of Flexbox and CSS Grid.',
        type: 'Frontend',
        xpReward: 120,
        difficulty: 'Medium',
        goal: 'Rebuild the dashboard layout using Flexbox for the nav bar and CSS Grid for the content area. All elements must be responsive.',
        initialCode:
            '/* The Enchanted Interface - Restore the Dashboard */\n\n.dashboard {\n  /* TODO: Use CSS Grid to create a 2-column layout */\n  display: ;\n  grid-template-columns: ;\n  gap: ;\n}\n\n.nav-bar {\n  /* TODO: Use Flexbox for horizontal navigation */\n  display: ;\n  justify-content: ;\n  align-items: ;\n}\n\n.card {\n  background: #2D1B58;\n  border-radius: 12px;\n  padding: 20px;\n  /* TODO: Add a subtle glow effect */\n}\n',
      ),
      MissionModel(
        id: '2',
        title: 'The Bug Slayer\'s Trial',
        description:
            'The kingdom\'s authentication spell is failing! Users are getting logged out randomly and the token refresh ritual is broken. Dive into the code and slay the bugs that lurk within.',
        type: 'Bug Fix',
        xpReward: 150,
        difficulty: 'Hard',
        goal: 'Find and fix the 3 bugs in the authentication flow. The token refresh should work seamlessly.',
        initialCode:
            '// The Bug Slayer\'s Trial - Fix the Auth Flow\n\nclass AuthService {\n  String? _token;\n  DateTime? _expiry;\n\n  bool get isAuthenticated {\n    // BUG 1: This comparison is inverted\n    return _expiry?.isBefore(DateTime.now()) ?? false;\n  }\n\n  Future<void> login(String email, String password) async {\n    final response = await api.post(\'/login\', {\n      \'email\': email,\n      \'password\': password,\n    });\n    _token = response[\'token\'];\n    // BUG 2: Expiry is not being set\n  }\n\n  Future<void> refreshToken() async {\n    if (_token == null) return;\n    final response = await api.post(\'/refresh\', {\n      \'token\': _token,\n    });\n    // BUG 3: Old token is not being replaced\n    _expiry = DateTime.now().add(Duration(hours: 1));\n  }\n}\n',
      ),
      MissionModel(
        id: '3',
        title: 'The Refactor Ritual',
        description:
            'The ancient codebase has grown tangled and unreadable. A massive function does everything — fetching data, transforming it, caching, and rendering. Your quest: refactor this monolith into clean, single-responsibility modules.',
        type: 'Refactor',
        xpReward: 200,
        difficulty: 'Hard',
        goal: 'Split the monolithic function into at least 4 separate, well-named functions. Each should have a single responsibility.',
        initialCode:
            '// The Refactor Ritual - Clean the Monolith\n\nFuture<Widget> doEverything(String userId) async {\n  // Fetch user data\n  final response = await http.get(\'/users/\$userId\');\n  final userData = json.decode(response.body);\n  \n  // Transform data\n  final name = userData[\'first\'] + \' \' + userData[\'last\'];\n  final level = (userData[\'xp\'] / 1000).floor();\n  final badges = userData[\'achievements\']\n      .where((a) => a[\'type\'] == \'badge\')\n      .toList();\n  \n  // Cache it\n  await cache.put(\'user_\$userId\', userData);\n  await cache.put(\'user_level_\$userId\', level);\n  \n  // Build UI\n  return Column(\n    children: [\n      Text(name),\n      Text(\'Level: \$level\'),\n      ...badges.map((b) => BadgeWidget(b)),\n    ],\n  );\n}\n',
      ),
      MissionModel(
        id: '4',
        title: 'The Sorting Sorcery',
        description:
            'The Grand Library\'s scroll index is in chaos! Thousands of magical scrolls are unsorted, and the librarian needs an efficient sorting algorithm. Implement a merge sort to restore order to the library.',
        type: 'Algorithm',
        xpReward: 180,
        difficulty: 'Medium',
        goal: 'Implement a merge sort algorithm that correctly sorts the given list of integers in ascending order.',
        initialCode:
            '// The Sorting Sorcery - Implement Merge Sort\n\nList<int> mergeSort(List<int> list) {\n  // Base case\n  if (list.length <= 1) return list;\n\n  // TODO: Find the middle point\n  int mid = ;\n\n  // TODO: Split the list into two halves\n  List<int> left = ;\n  List<int> right = ;\n\n  // TODO: Recursively sort both halves\n  left = ;\n  right = ;\n\n  // TODO: Merge the sorted halves\n  return merge(left, right);\n}\n\nList<int> merge(List<int> left, List<int> right) {\n  List<int> result = [];\n  int i = 0, j = 0;\n\n  // TODO: Compare and merge elements\n  while (i < left.length && j < right.length) {\n    // Your code here\n  }\n\n  // TODO: Add remaining elements\n\n  return result;\n}\n',
      ),
      MissionModel(
        id: '5',
        title: 'The State Enchantment',
        description:
            'The kingdom\'s shopping cart is haunted! Items appear and disappear randomly, quantities never update correctly, and the total price is always wrong. Master the arts of state management to lift this curse.',
        type: 'Frontend',
        xpReward: 160,
        difficulty: 'Medium',
        goal: 'Fix the state management in the shopping cart. Items should add/remove correctly and the total should always be accurate.',
        initialCode:
            '// The State Enchantment - Fix the Cart State\n\nclass CartNotifier extends StateNotifier<CartState> {\n  CartNotifier() : super(CartState.empty());\n\n  void addItem(Product product) {\n    final existingIndex = state.items\n        .indexWhere((item) => item.product.id == product.id);\n\n    if (existingIndex >= 0) {\n      // TODO: Increment the quantity of existing item\n      // Hint: Create a new list, don\'t mutate!\n    } else {\n      // TODO: Add new item to cart\n    }\n\n    // TODO: Recalculate the total\n  }\n\n  void removeItem(String productId) {\n    // TODO: Remove item and recalculate total\n  }\n\n  double _calculateTotal() {\n    // TODO: Sum up price * quantity for all items\n    return 0.0;\n  }\n}\n',
      ),
    ];

    state = AsyncData(missions);
    return missions;
  }
}
