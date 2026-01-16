import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/category_select_screen.dart';
import '../screens/level_select_screen.dart';
import '../screens/game_screen.dart';
import '../screens/result_screen.dart';
import '../screens/achievements_screen.dart';
import '../screens/statistics_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/daily_challenge_screen.dart';
import '../screens/multiplayer_setup_screen.dart';
import '../screens/multiplayer_transition_screen.dart';
import '../screens/multiplayer_results_screen.dart';

import 'package:sorga/domain/entities/level.dart';
import 'package:sorga/levels/level_generator.dart';

/// App routes
class AppRoutes {
  static const String home = '/';
  static const String categories = '/levels';
  static const String levelSelect = '/levels/:category';
  static const String game = '/game/:category/:localId';
  static const String result = '/result';
  static const String achievements = '/achievements';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String dailyChallenge = '/daily';
}

/// App router configuration
final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => const CategorySelectScreen(),
    ),
    GoRoute(
      path: '/levels/:category',
      builder: (context, state) {
        final category = state.pathParameters['category'] ?? 'basic';
        final isMemory = state.uri.queryParameters['memory'] == 'true';
        return LevelSelectScreen(categoryName: category, isMemory: isMemory);
      },
    ),
    GoRoute(
      path: '/game/:category/:localId',
      builder: (context, state) {
        try {
          final categoryStr = state.pathParameters['category'] ?? 'basic';
          final localIdStr = state.pathParameters['localId'] ?? '1';
          final isMemory = state.uri.queryParameters['memory'] == 'true';
          
          final category = LevelCategory.values.firstWhere(
            (e) => e.name == categoryStr,
            orElse: () => LevelCategory.basic,
          );
          final localId = int.tryParse(localIdStr) ?? 1;
          
          // Convert to global ID
          final generator = LevelGenerator();
          final levelId = generator.getGlobalId(category, localId);
          
          return GameScreen(levelId: levelId, isMemory: isMemory);
        } catch (e) {
          // Fallback to home/categories on error (prevent crash)
          return const CategorySelectScreen();
        }
      },
    ),
    GoRoute(
      path: AppRoutes.result,
      builder: (context, state) => const ResultScreen(),
    ),
    GoRoute(
      path: AppRoutes.achievements,
      builder: (context, state) => const AchievementsScreen(),
    ),
    GoRoute(
      path: AppRoutes.statistics,
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.dailyChallenge,
      builder: (context, state) => const DailyChallengeScreen(),
    ),
    GoRoute(
      path: '/daily/play',
      builder: (context, state) {
        // Safety check: redirect to daily challenge screen if extra is null
        final level = state.extra as Level?;
        if (level == null) {
          return const DailyChallengeScreen();
        }
        return GameScreen(
          levelId: level.id,
          isDailyChallenge: true,
          dailyLevel: level,
        );
      },
    ),
    // Multiplayer routes
    GoRoute(
      path: '/multiplayer/setup',
      builder: (context, state) => const MultiplayerSetupScreen(),
    ),
    GoRoute(
      path: '/multiplayer/transition',
      builder: (context, state) => const MultiplayerTransitionScreen(),
    ),
    GoRoute(
      path: '/multiplayer/game',
      builder: (context, state) => const GameScreen(levelId: 9999, isMultiplayer: true),
    ),
    GoRoute(
      path: '/multiplayer/results',
      builder: (context, state) => const MultiplayerResultsScreen(),
    ),
  ],
);
