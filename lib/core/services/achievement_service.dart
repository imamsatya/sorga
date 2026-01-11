import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/game_stats.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/entities/level.dart';
import '../constants/app_constants.dart';

/// Service for managing achievements
class AchievementService {
  static AchievementService? _instance;
  static AchievementService get instance => _instance ??= AchievementService._();
  
  AchievementService._();
  
  static const String _boxName = 'achievements';
  late Box<List<String>> _box;
  
  /// Initialize the service
  Future<void> init() async {
    _box = await Hive.openBox<List<String>>(_boxName);
  }
  
  /// Get list of unlocked achievement types
  Set<AchievementType> get unlockedTypes {
    final List<String>? stored = _box.get('unlocked');
    if (stored == null) return {};
    return stored.map((s) => AchievementType.values.firstWhere(
      (t) => t.name == s,
      orElse: () => AchievementType.firstLevel,
    )).toSet();
  }
  
  /// Check if an achievement is unlocked
  bool isUnlocked(AchievementType type) => unlockedTypes.contains(type);
  
  /// Unlock an achievement (returns true if newly unlocked)
  Future<bool> unlock(AchievementType type) async {
    final current = unlockedTypes;
    if (current.contains(type)) return false;
    
    current.add(type);
    await _box.put('unlocked', current.map((t) => t.name).toList());
    return true;
  }
  
  /// Check and unlock achievements based on game state
  /// Returns list of newly unlocked achievements
  Future<List<Achievement>> checkUnlocks({
    required int completedLevels,
    required int currentStreak,
    required int totalPlayTimeMs,
    required int? lastLevelTimeMs,
    required Map<LevelCategory, int> completedPerCategory,
    required int consecutivePerfect, // levels completed without mistakes in a row
  }) async {
    List<Achievement> newlyUnlocked = [];
    
    // Level milestones
    if (completedLevels >= 1) {
      if (await unlock(AchievementType.firstLevel)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.firstLevel));
      }
    }
    if (completedLevels >= 10) {
      if (await unlock(AchievementType.level10)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.level10));
      }
    }
    if (completedLevels >= 50) {
      if (await unlock(AchievementType.level50)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.level50));
      }
    }
    if (completedLevels >= 100) {
      if (await unlock(AchievementType.level100)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.level100));
      }
    }
    if (completedLevels >= 500) {
      if (await unlock(AchievementType.level500)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.level500));
      }
    }
    if (completedLevels >= 1000) {
      if (await unlock(AchievementType.level1000)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.level1000));
      }
    }
    
    // Streak milestones
    if (currentStreak >= 3) {
      if (await unlock(AchievementType.streak3)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.streak3));
      }
    }
    if (currentStreak >= 7) {
      if (await unlock(AchievementType.streak7)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.streak7));
      }
    }
    if (currentStreak >= 30) {
      if (await unlock(AchievementType.streak30)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.streak30));
      }
    }
    
    // Speed achievements
    if (lastLevelTimeMs != null) {
      if (lastLevelTimeMs < 5000) {
        if (await unlock(AchievementType.speedDemon)) {
          newlyUnlocked.add(Achievement.getByType(AchievementType.speedDemon));
        }
      }
      if (lastLevelTimeMs < 3000) {
        if (await unlock(AchievementType.lightning)) {
          newlyUnlocked.add(Achievement.getByType(AchievementType.lightning));
        }
      }
    }
    
    // Category mastery (using AppConstants ranges)
    if ((completedPerCategory[LevelCategory.basic] ?? 0) >= 60) {
      if (await unlock(AchievementType.basicMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.basicMaster));
      }
    }
    if ((completedPerCategory[LevelCategory.formatted] ?? 0) >= 190) {
      if (await unlock(AchievementType.formattedMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.formattedMaster));
      }
    }
    if ((completedPerCategory[LevelCategory.time] ?? 0) >= 200) {
      if (await unlock(AchievementType.timeMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.timeMaster));
      }
    }
    if ((completedPerCategory[LevelCategory.names] ?? 0) >= 200) {
      if (await unlock(AchievementType.namesMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.namesMaster));
      }
    }
    if ((completedPerCategory[LevelCategory.mixed] ?? 0) >= 200) {
      if (await unlock(AchievementType.mixedMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.mixedMaster));
      }
    }
    if ((completedPerCategory[LevelCategory.knowledge] ?? 0) >= 150) {
      if (await unlock(AchievementType.knowledgeMaster)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.knowledgeMaster));
      }
    }
    
    // Special achievements
    if (consecutivePerfect >= 10) {
      if (await unlock(AchievementType.perfectRun)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.perfectRun));
      }
    }
    
    // Time-based achievements
    final hourMs = 60 * 60 * 1000;
    if (totalPlayTimeMs >= hourMs) {
      if (await unlock(AchievementType.dedicated)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.dedicated));
      }
    }
    if (totalPlayTimeMs >= 5 * hourMs) {
      if (await unlock(AchievementType.marathon)) {
        newlyUnlocked.add(Achievement.getByType(AchievementType.marathon));
      }
    }
    
    return newlyUnlocked;
  }
  
  /// Get all achievements with unlock status
  List<({Achievement achievement, bool unlocked})> getAllWithStatus() {
    final unlocked = unlockedTypes;
    return Achievement.all.map((a) => (
      achievement: a,
      unlocked: unlocked.contains(a.type),
    )).toList();
  }
  
  /// Get count of unlocked achievements
  int get unlockedCount => unlockedTypes.length;
  
  /// Get total achievement count
  int get totalCount => Achievement.all.length;
}
