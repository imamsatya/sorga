import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/achievement.dart';
import '../../domain/entities/level.dart';

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
    if (!_box.isOpen) return {};
    
    try {
      final stored = _box.get('unlocked');
      if (stored == null) return {};
      
      final List<String> stringList = (stored as List).map((e) => e.toString()).toList();
      
      return stringList.map((s) => AchievementType.values.firstWhere(
        (t) => t.name == s,
        orElse: () => AchievementType.firstLevel,
      )).toSet();
    } catch (e) {
      return {};
    }
  }
  
  /// Check if an achievement is unlocked
  bool isUnlocked(AchievementType type) => unlockedTypes.contains(type);
  
  /// Unlock an achievement (returns true if newly unlocked)
  Future<bool> unlock(AchievementType type) async {
    if (!_box.isOpen) return false;
    
    try {
      final current = unlockedTypes;
      if (current.contains(type)) return false;
      
      current.add(type);
      await _box.put('unlocked', current.map((t) => t.name).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Helper to unlock and add to list
  Future<void> _tryUnlock(AchievementType type, List<Achievement> newlyUnlocked) async {
    if (await unlock(type)) {
      newlyUnlocked.add(Achievement.getByType(type));
    }
  }
  
  /// Check and unlock achievements based on game state
  Future<List<Achievement>> checkUnlocks({
    required int completedLevels,
    required int currentStreak,
    required int totalPlayTimeMs,
    required int? lastLevelTimeMs,
    required Map<LevelCategory, int> completedPerCategory,
    required int consecutivePerfect,
    // Memory mode
    int memoryCompletions = 0,
    int memoryPerfectCompletions = 0,
    Map<LevelCategory, int> memoryCompletedPerCategory = const {},
    // Daily challenge
    int dailyCompletions = 0,
    int dailyPerfectCompletions = 0,
    // Multiplayer
    int multiplayerGamesHosted = 0,
    // Time-based context
    DateTime? completionTime,
    // Special tracking
    int retryCount = 0,
    int consecutiveDescending = 0,
    int swapOnlyCompletions = 0,
    int shiftOnlyCompletions = 0,
  }) async {
    List<Achievement> newlyUnlocked = [];
    
    // === LEVEL MILESTONES ===
    if (completedLevels >= 1) await _tryUnlock(AchievementType.firstLevel, newlyUnlocked);
    if (completedLevels >= 10) await _tryUnlock(AchievementType.level10, newlyUnlocked);
    if (completedLevels >= 50) await _tryUnlock(AchievementType.level50, newlyUnlocked);
    if (completedLevels >= 100) await _tryUnlock(AchievementType.level100, newlyUnlocked);
    if (completedLevels >= 500) await _tryUnlock(AchievementType.level500, newlyUnlocked);
    if (completedLevels >= 600) await _tryUnlock(AchievementType.level600, newlyUnlocked);
    
    // === STREAK MILESTONES ===
    if (currentStreak >= 3) await _tryUnlock(AchievementType.streak3, newlyUnlocked);
    if (currentStreak >= 7) await _tryUnlock(AchievementType.streak7, newlyUnlocked);
    if (currentStreak >= 30) await _tryUnlock(AchievementType.streak30, newlyUnlocked);
    if (currentStreak >= 100) await _tryUnlock(AchievementType.streak100, newlyUnlocked);
    
    // === SPEED ACHIEVEMENTS ===
    if (lastLevelTimeMs != null) {
      if (lastLevelTimeMs < 5000) await _tryUnlock(AchievementType.speedDemon, newlyUnlocked);
      if (lastLevelTimeMs < 3000) await _tryUnlock(AchievementType.lightning, newlyUnlocked);
      if (lastLevelTimeMs < 2000) await _tryUnlock(AchievementType.instantWin, newlyUnlocked);
    }
    
    // === CATEGORY MASTERY (100 levels each) ===
    if ((completedPerCategory[LevelCategory.basic] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.basicMaster, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.formatted] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.formattedMaster, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.time] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.timeMaster, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.names] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.namesMaster, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.mixed] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.mixedMaster, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.knowledge] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.knowledgeMaster, newlyUnlocked);
    }
    
    // === CATEGORY COMPLETION (100% = all levels) ===
    if ((completedPerCategory[LevelCategory.basic] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.basicComplete, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.formatted] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.formattedComplete, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.time] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.timeComplete, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.names] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.namesComplete, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.mixed] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.mixedComplete, newlyUnlocked);
    }
    if ((completedPerCategory[LevelCategory.knowledge] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.knowledgeComplete, newlyUnlocked);
    }
    
    // === MEMORY MODE - PROGRESS ===
    if (memoryCompletions >= 10) await _tryUnlock(AchievementType.memoryBeginner, newlyUnlocked);
    if (memoryCompletions >= 50) await _tryUnlock(AchievementType.memoryExpert, newlyUnlocked);
    if (memoryCompletions >= 100) await _tryUnlock(AchievementType.memoryMaster, newlyUnlocked);
    
    // === MEMORY MODE - PERFECT ===
    if (memoryPerfectCompletions >= 5) await _tryUnlock(AchievementType.memoryPerfect5, newlyUnlocked);
    if (memoryPerfectCompletions >= 10) await _tryUnlock(AchievementType.memoryPerfect10, newlyUnlocked);
    if (memoryPerfectCompletions >= 25) await _tryUnlock(AchievementType.memoryPerfect25, newlyUnlocked);
    if (memoryPerfectCompletions >= 50) await _tryUnlock(AchievementType.memoryPerfect50, newlyUnlocked);
    if (memoryPerfectCompletions >= 100) await _tryUnlock(AchievementType.memoryPerfect100, newlyUnlocked);
    
    // === MEMORY MODE - CATEGORY COMPLETION ===
    if ((memoryCompletedPerCategory[LevelCategory.basic] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.memoryBasicComplete, newlyUnlocked);
    }
    if ((memoryCompletedPerCategory[LevelCategory.formatted] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.memoryFormattedComplete, newlyUnlocked);
    }
    if ((memoryCompletedPerCategory[LevelCategory.time] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.memoryTimeComplete, newlyUnlocked);
    }
    if ((memoryCompletedPerCategory[LevelCategory.names] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.memoryNamesComplete, newlyUnlocked);
    }
    if ((memoryCompletedPerCategory[LevelCategory.mixed] ?? 0) >= 100) {
      await _tryUnlock(AchievementType.memoryMixedComplete, newlyUnlocked);
    }
    
    // === DAILY CHALLENGE - PROGRESS ===
    if (dailyCompletions >= 1) await _tryUnlock(AchievementType.dailyFirst, newlyUnlocked);
    if (dailyCompletions >= 7) await _tryUnlock(AchievementType.dailyWeek, newlyUnlocked);
    if (dailyCompletions >= 30) await _tryUnlock(AchievementType.dailyMonth, newlyUnlocked);
    if (dailyCompletions >= 100) await _tryUnlock(AchievementType.daily100, newlyUnlocked);
    
    // === DAILY CHALLENGE - PERFECT ===
    if (dailyPerfectCompletions >= 5) await _tryUnlock(AchievementType.dailyPerfect5, newlyUnlocked);
    if (dailyPerfectCompletions >= 10) await _tryUnlock(AchievementType.dailyPerfect10, newlyUnlocked);
    if (dailyPerfectCompletions >= 25) await _tryUnlock(AchievementType.dailyPerfect25, newlyUnlocked);
    if (dailyPerfectCompletions >= 50) await _tryUnlock(AchievementType.dailyPerfect50, newlyUnlocked);
    if (dailyPerfectCompletions >= 100) await _tryUnlock(AchievementType.dailyPerfect100, newlyUnlocked);
    
    // === MULTIPLAYER ===
    if (multiplayerGamesHosted >= 10) await _tryUnlock(AchievementType.multiplayer10, newlyUnlocked);
    if (multiplayerGamesHosted >= 25) await _tryUnlock(AchievementType.multiplayer25, newlyUnlocked);
    if (multiplayerGamesHosted >= 50) await _tryUnlock(AchievementType.multiplayer50, newlyUnlocked);
    
    // === SPECIAL ===
    if (consecutivePerfect >= 10) await _tryUnlock(AchievementType.perfectRun, newlyUnlocked);
    
    final hourMs = 60 * 60 * 1000;
    if (totalPlayTimeMs >= hourMs) await _tryUnlock(AchievementType.dedicated, newlyUnlocked);
    if (totalPlayTimeMs >= 5 * hourMs) await _tryUnlock(AchievementType.marathon, newlyUnlocked);
    
    // Total Master (600 regular + 500 Memory = 1100)
    if (completedLevels + memoryCompletions >= 1100) {
      await _tryUnlock(AchievementType.totalMaster, newlyUnlocked);
    }
    
    // === SECRET ACHIEVEMENTS ===
    
    // Night Owl: Complete between midnight and 5 AM
    if (completionTime != null) {
      final hour = completionTime.hour;
      if (hour >= 0 && hour < 5) {
        await _tryUnlock(AchievementType.nightOwl, newlyUnlocked);
      }
      // Early Bird: Complete between 5 AM and 7 AM
      if (hour >= 5 && hour < 7) {
        await _tryUnlock(AchievementType.earlyBird, newlyUnlocked);
      }
      // New Year: Play on January 1st
      if (completionTime.month == 1 && completionTime.day == 1) {
        await _tryUnlock(AchievementType.newYear, newlyUnlocked);
      }
    }
    
    // Persistent: Use retry 50 times
    if (retryCount >= 50) await _tryUnlock(AchievementType.persistent, newlyUnlocked);
    
    // Descending Fan: 20 descending in a row
    if (consecutiveDescending >= 20) await _tryUnlock(AchievementType.descendingFan, newlyUnlocked);
    
    // Swap Only: 10 levels using only swap
    if (swapOnlyCompletions >= 10) await _tryUnlock(AchievementType.swapOnly, newlyUnlocked);
    
    // Shift Only: 10 levels using only shift
    if (shiftOnlyCompletions >= 10) await _tryUnlock(AchievementType.shiftOnly, newlyUnlocked);
    
    // === COMPLETIONIST (check if all others unlocked) ===
    final allOtherTypes = AchievementType.values.where((t) => t != AchievementType.completionist).toSet();
    if (unlockedTypes.containsAll(allOtherTypes)) {
      await _tryUnlock(AchievementType.completionist, newlyUnlocked);
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
