import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/ai_mentor/screens/ai_mentor_screen.dart';
import '../../features/career_path/screens/career_path_screen.dart';
import '../../features/social/screens/guilds_screen.dart';
import '../../features/quests/screens/frontend_quest_screen.dart';
import '../../features/battles/screens/battles_screen.dart';
import '../../features/progress/screens/progress_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'mentor',
            builder: (context, state) => const AiMentorScreen(),
          ),
          GoRoute(
            path: 'career',
            builder: (context, state) => const CareerPathSelectionScreen(),
          ),
          GoRoute(
            path: 'social',
            builder: (context, state) => const GuildsScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'quests',
            builder: (context, state) => const FrontendQuestScreen(),
          ),
          GoRoute(
            path: 'battles',
            builder: (context, state) => const BattlesScreen(),
          ),
          GoRoute(
            path: 'progress',
            builder: (context, state) => const ProgressScreen(),
          ),
        ],
      ),
      // Auth routes (placeholders as I need to verify LoginScreen)
      /*
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      */
    ],
  );
}
