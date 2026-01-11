import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/category_select_screen.dart';
import '../screens/level_select_screen.dart';
import '../screens/game_screen.dart';
import '../screens/result_screen.dart';
import '../screens/achievements_screen.dart';

/// App routes
class AppRoutes {
  static const String home = '/';
  static const String categories = '/levels';
  static const String levelSelect = '/levels/:category';
  static const String game = '/game/:levelId';
  static const String result = '/result';
  static const String achievements = '/achievements';
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
        return LevelSelectScreen(categoryName: category);
      },
    ),
    GoRoute(
      path: '/game/:levelId',
      builder: (context, state) {
        final levelId = int.parse(state.pathParameters['levelId'] ?? '1');
        return GameScreen(levelId: levelId);
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
  ],
);
