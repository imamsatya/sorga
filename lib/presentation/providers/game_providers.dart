import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_database.dart';
import '../../data/repositories/progress_repository_impl.dart';
import '../../data/repositories/level_repository_impl.dart';
import '../../domain/repositories/progress_repository.dart';
import '../../domain/repositories/level_repository.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/user_progress.dart';
import '../../levels/level_generator.dart';
import '../../core/constants/app_constants.dart';

// ==================== CORE PROVIDERS ====================

/// Database provider
final databaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabase.instance;
});

/// Level generator provider
final levelGeneratorProvider = Provider<LevelGenerator>((ref) {
  return LevelGenerator();
});

/// Progress repository provider
final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ProgressRepositoryImpl(database);
});

/// Level repository provider
final levelRepositoryProvider = Provider<LevelRepository>((ref) {
  final generator = ref.watch(levelGeneratorProvider);
  return LevelRepositoryImpl(generator);
});

// ==================== LEVEL PROVIDERS ====================

/// Get a specific level
final levelProvider = Provider.family<Level, int>((ref, levelId) {
  final repository = ref.watch(levelRepositoryProvider);
  return repository.getLevel(levelId);
});

/// Get all levels for a category
final levelsByCategoryProvider = Provider.family<List<Level>, LevelCategory>((ref, category) {
  final repository = ref.watch(levelRepositoryProvider);
  return repository.getLevelsByCategory(category);
});

// ==================== PROGRESS PROVIDERS ====================

/// All progress data
final allProgressProvider = FutureProvider<List<UserProgress>>((ref) async {
  final repository = ref.watch(progressRepositoryProvider);
  return repository.getAllProgress();
});

/// Progress for a specific level
final levelProgressProvider = FutureProvider.family<UserProgress?, int>((ref, levelId) async {
  final repository = ref.watch(progressRepositoryProvider);
  return repository.getProgress(levelId);
});

/// Completed levels count
final completedCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(progressRepositoryProvider);
  return repository.getCompletedCount();
});

/// Highest unlocked level
final highestUnlockedProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(progressRepositoryProvider);
  return repository.getHighestUnlockedLevel();
});

/// Check if a level is unlocked
final isLevelUnlockedProvider = FutureProvider.family<bool, int>((ref, levelId) async {
  // In dev mode, all levels are unlocked
  if (AppConstants.isDevMode) return true;
  
  // Always unlock the first level of each category
  const categoryStarts = [
    AppConstants.basicNumbersStart,
    AppConstants.formattedNumbersStart,
    AppConstants.timeFormatsStart,
    AppConstants.nameSortingStart,
    AppConstants.mixedFormatsStart,
    AppConstants.knowledgeStart,
  ];
  
  if (categoryStarts.contains(levelId)) return true;
  
  // Check if previous level is completed (allows progression within a category)
  if (levelId > 1) {
    final prevProgress = await ref.watch(levelProgressProvider(levelId - 1).future);
    if (prevProgress != null && prevProgress.completed) {
      return true;
    }
  }
  
  final highest = await ref.watch(highestUnlockedProvider.future);
  return levelId <= highest;
});

/// Total levels constant
final totalLevelsProvider = Provider<int>((ref) {
  return AppConstants.totalLevels;
});

// ==================== STATS PROVIDERS ====================

/// Game statistics
final gameStatsProvider = FutureProvider<GameStats>((ref) async {
  final allProgress = await ref.watch(allProgressProvider.future);
  final completed = allProgress.where((p) => p.completed).toList();
  
  int? bestTimeMs;
  int totalAttempts = 0;
  Duration totalTime = Duration.zero;
  
  for (final p in completed) {
    totalAttempts += p.attempts;
    if (p.bestTimeMs != null) {
      totalTime += Duration(milliseconds: p.bestTimeMs!);
      if (bestTimeMs == null || p.bestTimeMs! < bestTimeMs) {
        bestTimeMs = p.bestTimeMs;
      }
    }
  }
  
  return GameStats(
    completedLevels: completed.length,
    totalLevels: AppConstants.totalLevels,
    totalAttempts: totalAttempts,
    totalPlayTime: totalTime,
    bestSingleLevelTime: bestTimeMs != null ? Duration(milliseconds: bestTimeMs) : null,
  );
});

/// Game statistics data class
class GameStats {
  final int completedLevels;
  final int totalLevels;
  final int totalAttempts;
  final Duration totalPlayTime;
  final Duration? bestSingleLevelTime;
  
  const GameStats({
    required this.completedLevels,
    required this.totalLevels,
    required this.totalAttempts,
    required this.totalPlayTime,
    this.bestSingleLevelTime,
  });
  
  double get completionPercentage => 
      totalLevels > 0 ? (completedLevels / totalLevels) * 100 : 0;
  
  String get formattedPlayTime {
    final hours = totalPlayTime.inHours;
    final minutes = totalPlayTime.inMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}
