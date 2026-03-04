import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/career_path/providers/roadmap_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/ai_mentor/screens/ai_mentor_screen.dart';
import '../../features/career_path/screens/career_path_screen.dart';
import '../../features/social/screens/guilds_screen.dart';
import '../../features/career_path/screens/frontend_roadmap_screen.dart';
import '../../features/quests/screens/quiz_screen.dart';
import '../../features/quests/screens/frontend_quest_screen.dart';
import '../../features/battles/screens/battles_screen.dart';
import '../../features/progress/screens/progress_screen.dart';
import '../../features/missions/screens/missions_screen.dart';
import '../../features/missions/screens/mission_solve_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/store/screens/store_screen.dart';

import '../widgets/main_scaffold.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _shellNavigatorRoadmapKey = GlobalKey<NavigatorState>(debugLabel: 'roadmap');
  static final _shellNavigatorMissionsKey = GlobalKey<NavigatorState>(debugLabel: 'missions');
  static final _shellNavigatorGuildKey = GlobalKey<NavigatorState>(debugLabel: 'guild');

  static final GoRouter router = GoRouter(
    initialLocation: '/dashboard',
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0 (Home)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const DashboardScreen(),
                routes: [
                  GoRoute(
                    path: 'mentor',
                    builder: (context, state) => const AiMentorScreen(),
                  ),
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => const ProfileScreen(),
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
            ],
          ),
          // Branch 1 (Roadmap)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorRoadmapKey,
            routes: [
              GoRoute(
                path: '/career',
                builder: (context, state) => const CareerPathSelectionScreen(),
                routes: [
                  GoRoute(
                    path: 'frontend',
                    builder: (context, state) => const FrontendRoadmapScreen(),
                    routes: [
                      GoRoute(
                        path: 'quiz',
                        builder: (context, state) => const QuizScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Branch 2 (Missions)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMissionsKey,
            routes: [
              GoRoute(
                path: '/missions',
                builder: (context, state) => const MissionsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final missionId = state.pathParameters['id']!;
                      return MissionSolveScreen(missionId: missionId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch 3 (Guild)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorGuildKey,
            routes: [
              GoRoute(
                path: '/social',
                builder: (context, state) => const GuildsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/',
        redirect: (context, state) => '/dashboard',
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/store',
        builder: (context, state) => const StoreScreen(),
      ),
    ],
  );
}

