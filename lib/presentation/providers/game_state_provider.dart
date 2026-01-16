import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/level_item.dart';
import '../../domain/entities/user_progress.dart';
import '../../data/datasources/local_database.dart';
import '../../core/services/achievement_service.dart';
import 'game_providers.dart';
import 'game_stats_provider.dart';
import 'daily_challenge_provider.dart';

/// Phase of gameplay for memory mode
enum GamePhase {
  ready,       // Initial state
  memorizing,  // User is memorizing items (memory mode only)
  sorting,     // User is sorting items
  checking,    // Checking answer
  completed,   // Game completed
}

/// State for the active game
class GameState {
  final Level level;
  final List<LevelItem> currentOrder;
  final Duration elapsedTime;
  final bool isRunning;
  final bool isCompleted;
  final bool isCorrect;
  final int failedAttempts;
  
  // Memory mode (SORGAwy) fields
  final GamePhase phase;
  final bool labelsVisible;       // Show item values or "?"
  final Duration memorizeTime;    // Time spent memorizing
  final Map<String, int> originalIndices; // Track original position of each item
  
  const GameState({
    required this.level,
    required this.currentOrder,
    this.elapsedTime = Duration.zero,
    this.isRunning = false,
    this.isCompleted = false,
    this.isCorrect = false,
    this.failedAttempts = 0,
    this.phase = GamePhase.ready,
    this.labelsVisible = true,
    this.memorizeTime = Duration.zero,
    this.originalIndices = const {},
  });
  
  /// Can continue after failure (only if less than 2 failed attempts)
  bool get canContinue => failedAttempts < 2;
  
  /// Is this a memory mode game
  bool get isMemoryMode => level.isMemory;
  
  /// Get original index for an item (1-based for display)
  int getOriginalIndex(LevelItem item) {
    return (originalIndices[item.id] ?? 0) + 1;
  }
  
  GameState copyWith({
    Level? level,
    List<LevelItem>? currentOrder,
    Duration? elapsedTime,
    bool? isRunning,
    bool? isCompleted,
    bool? isCorrect,
    int? failedAttempts,
    GamePhase? phase,
    bool? labelsVisible,
    Duration? memorizeTime,
    Map<String, int>? originalIndices,
  }) {
    return GameState(
      level: level ?? this.level,
      currentOrder: currentOrder ?? this.currentOrder,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isRunning: isRunning ?? this.isRunning,
      isCompleted: isCompleted ?? this.isCompleted,
      isCorrect: isCorrect ?? this.isCorrect,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      phase: phase ?? this.phase,
      labelsVisible: labelsVisible ?? this.labelsVisible,
      memorizeTime: memorizeTime ?? this.memorizeTime,
      originalIndices: originalIndices ?? this.originalIndices,
    );
  }
  
  String get formattedTime {
    final minutes = elapsedTime.inMinutes;
    final seconds = elapsedTime.inSeconds % 60;
    final ms = (elapsedTime.inMilliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }
  
  String get formattedMemorizeTime {
    final seconds = memorizeTime.inSeconds;
    final ms = (memorizeTime.inMilliseconds % 1000) ~/ 10;
    return '${seconds.toString()}.${ms.toString().padLeft(2, '0')}s';
  }
}

/// Notifier for game state
class GameStateNotifier extends StateNotifier<GameState?> {
  final Ref _ref;
  Timer? _timer;
  
  GameStateNotifier(this._ref) : super(null);
  
  /// Start a new game with a level ID
  void startGame(int levelId) {
    _stopTimer();
    
    final level = _ref.read(levelProvider(levelId));
    _initializeGameWithLevel(level);
  }

  /// Start a new game with a Level object directly (for Daily Challenge)
  void startGameWithLevel(Level level) {
    _stopTimer();
    _initializeGameWithLevel(level);
  }

  /// Start a MEMORY game (SORGAwy mode) with a level ID
  void startGameMemory(int levelId) {
    _stopTimer();
    
    // Get memory level (uses different seed for different items)
    final generator = _ref.read(levelGeneratorProvider);
    final memoryLevel = generator.getMemoryLevel(levelId);
    _initializeGameWithLevel(memoryLevel);
  }

  /// Initialize game state with a level
  void _initializeGameWithLevel(Level level) {
    // Store original indices before any reordering (for memory mode display)
    final Map<String, int> originalIndices = {};
    for (int i = 0; i < level.items.length; i++) {
      originalIndices[level.items[i].id] = i;
    }
    
    // Items start in original order (will be shuffled by user or for display)
    final shuffled = List<LevelItem>.from(level.items);
    
    state = GameState(
      level: level,
      currentOrder: shuffled,
      isRunning: false, // Start paused for countdown
      originalIndices: originalIndices,
    );
    
    // Timer will be started by startPlaying() after countdown
  }
  
  /// Start the actual gameplay and timer
  void startPlaying() {
    if (state == null) return;
    
    // For memory mode, start memorizing phase first
    if (state!.level.isMemory) {
      state = state!.copyWith(
        isRunning: true,
        phase: GamePhase.memorizing,
        labelsVisible: true,
      );
      _startTimer();
    } else {
      state = state!.copyWith(
        isRunning: true,
        phase: GamePhase.sorting,
      );
      _startTimer();
    }
  }
  
  /// Finish memorizing and start sorting (memory mode only)
  void finishMemorizing() {
    if (state == null || !state!.level.isMemory) return;
    if (state!.phase != GamePhase.memorizing) return;
    
    // Record memorize time and switch to sorting phase
    state = state!.copyWith(
      phase: GamePhase.sorting,
      labelsVisible: false, // Hide labels for sorting
      memorizeTime: state!.elapsedTime,
      elapsedTime: Duration.zero, // Reset timer for sorting phase
    );
    
    // Restart timer for sorting phase
    _stopTimer();
    _startTimer();
  }
  
  /// Reorder items - swap positions
  void reorderItems(int oldIndex, int newIndex) {
    if (state == null) return;
    if (oldIndex == newIndex) return;
    
    final items = List<LevelItem>.from(state!.currentOrder);
    // Swap the items
    final temp = items[oldIndex];
    items[oldIndex] = items[newIndex];
    items[newIndex] = temp;
    
    state = state!.copyWith(currentOrder: items);
  }
  
  /// Insert item at new position (shift others)
  void insertItem(int fromIndex, int toIndex) {
    if (state == null) return;
    if (fromIndex == toIndex) return;
    
    final items = List<LevelItem>.from(state!.currentOrder);
    final item = items.removeAt(fromIndex);
    
    // Insert at toIndex - this correctly handles both directions
    // When moving forward: item ends up at toIndex (target's original position)
    // When moving backward: item ends up at toIndex (target's position)
    items.insert(toIndex, item);
    
    state = state!.copyWith(currentOrder: items);
  }
  
  /// Check if the current order is correct
  Future<bool> checkAnswer() async {
    if (state == null) return false;
    
    _stopTimer();
    
    final level = state!.level;
    final currentOrder = state!.currentOrder;
    bool isCorrect = true;
    
    // Check if items are correctly sorted by comparing sortValues
    for (int i = 0; i < currentOrder.length - 1; i++) {
      final current = currentOrder[i].sortValue;
      final next = currentOrder[i + 1].sortValue;
      
      if (level.sortOrder == SortOrder.ascending) {
        // For ascending: current should be <= next
        if (current > next) {
          isCorrect = false;
          break;
        }
      } else {
        // For descending: current should be >= next
        if (current < next) {
          isCorrect = false;
          break;
        }
      }
    }
    
    state = state!.copyWith(
      isRunning: false,
      isCompleted: true,
      isCorrect: isCorrect,
      // Increment failed attempts if wrong
      failedAttempts: isCorrect ? state!.failedAttempts : state!.failedAttempts + 1,
    );
    
    // Save progress (update attempts and completion)
    try {
      await _saveProgress(isCorrect);
    } catch (e) {
      debugPrint('Error saving progress: $e');
      // Continue anyway so game doesn't freeze
    }
    
    return isCorrect;
  }
  
  /// Continue playing after a failed attempt (keeps current order and time)
  void continueGame() {
    if (state == null || !state!.canContinue) return;
    
    state = state!.copyWith(
      isRunning: true,
      isCompleted: false,
      isCorrect: false,
    );
    
    _startTimer();
  }
  
  /// Save progress to database
  Future<void> _saveProgress(bool success) async {
    if (state == null) return;
    
    final repository = _ref.read(progressRepositoryProvider);
    
    // Use offset for memory levels to track separately from regular levels
    // Memory levels: ID = levelId + 10000
    final int progressId = state!.level.isMemory 
        ? state!.level.id + 10000 
        : state!.level.id;
    
    final existingProgress = await repository.getProgress(progressId);
    
    // For memory mode, calculate total time (memorize + sort)
    final Duration totalTime = state!.level.isMemory 
        ? state!.memorizeTime + state!.elapsedTime  // memorize + sort
        : state!.elapsedTime;
    
    UserProgress newProgress;
    if (existingProgress != null) {
      newProgress = existingProgress.withNewAttempt(
        totalTime,
        success: success,
        memorizeTime: state!.level.isMemory ? state!.memorizeTime : null,
        sortTime: state!.level.isMemory ? state!.elapsedTime : null,
      );
    } else {
      newProgress = UserProgress(
        levelId: progressId,
        completed: success,
        bestTimeMs: success ? totalTime.inMilliseconds : null,
        completedAt: success ? DateTime.now() : null,
        attempts: 1,
        memorizeTimeMs: success && state!.level.isMemory 
            ? state!.memorizeTime.inMilliseconds : null,
        sortTimeMs: success && state!.level.isMemory 
            ? state!.elapsedTime.inMilliseconds : null,
      );
    }
    
    await repository.saveProgress(newProgress);
    
    // Invalidate all progress providers FIRST to refresh counts
    _ref.invalidate(allProgressProvider);
    _ref.invalidate(completedCountProvider);
    _ref.invalidate(highestUnlockedProvider);
    _ref.invalidate(levelProgressProvider(progressId));
    
    // Record play time for streak tracking on successful completion
    if (success) {
      await LocalDatabase.instance.recordPlay(
        playTimeMs: state!.elapsedTime.inMilliseconds,
      );
      // Update consecutive perfect counter
      await LocalDatabase.instance.incrementPerfect();
      // Refresh game stats provider to update streak badge
      _ref.read(gameStatsNotifierProvider.notifier).refresh();
      
      // Update daily challenge streak if this is a daily challenge (localId == 0)
      if (state!.level.localId == 0) {
        await _ref.read(dailyChallengeProvider.notifier).completeChallenge(
          state!.elapsedTime.inMilliseconds,
        );
      }
      
      // Check for new achievements AFTER invalidation
      await _checkAchievements();
    } else {
      // Reset consecutive perfect on failure
      await LocalDatabase.instance.resetPerfect();
      _ref.read(gameStatsNotifierProvider.notifier).refresh();
    }
  }

  /// Check and unlock achievements
  Future<void> _checkAchievements() async {
    final gameStats = LocalDatabase.instance.getStats();
    
    // Count completed levels directly from database
    final progressBox = LocalDatabase.instance.progressBox;
    final allProgress = progressBox.values.toList();
    int completedCount = 0;
    final completedPerCategory = <LevelCategory, int>{};
    final levelGenerator = _ref.read(levelGeneratorProvider);
    
    for (final progress in allProgress) {
      if (progress.completed) {
        completedCount++;
        try {
          // Skip daily challenge levels (IDs > 1000 are likely date-based)
          if (progress.levelId > 1000) continue;
          final level = levelGenerator.getLevel(progress.levelId);
          completedPerCategory[level.category] = 
              (completedPerCategory[level.category] ?? 0) + 1;
        } catch (e) {
          // Skip levels that don't exist in generator (e.g., daily challenges)
        }
      }
    }
    
    // Check achievements
    final newlyUnlocked = await AchievementService.instance.checkUnlocks(
      completedLevels: completedCount,
      currentStreak: gameStats.currentStreak,
      totalPlayTimeMs: gameStats.totalPlayTimeMs,
      lastLevelTimeMs: state?.elapsedTime.inMilliseconds,
      completedPerCategory: completedPerCategory,
      consecutivePerfect: gameStats.consecutivePerfect,
    );
    
    // Store newly unlocked for display (can be shown in result screen)
    if (newlyUnlocked.isNotEmpty) {
      _lastUnlockedAchievements = newlyUnlocked;
    }
  }

  /// Get last unlocked achievements (for notification display)
  static List<dynamic> _lastUnlockedAchievements = [];
  static List<dynamic> get lastUnlockedAchievements => _lastUnlockedAchievements;
  static void clearLastUnlockedAchievements() => _lastUnlockedAchievements = [];

  
  /// Retry the current level
  void retry() {
    if (state == null) return;
    final levelId = state!.level.id;
    final isMemory = state!.level.isMemory;
    
    if (isMemory) {
      startGameMemory(levelId);
    } else {
      startGame(levelId);
    }
  }

  /// Retry with the same level object (for Daily Challenge)
  void retryWithLevel(Level level) {
    if (level.isMemory) {
      // For memory mode, use startGameMemory
      startGameMemory(level.id);
    } else {
      startGameWithLevel(level);
    }
  }
  
  /// Stop and clear the game
  void endGame() {
    _stopTimer();
    state = null;
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (state != null && state!.isRunning) {
        state = state!.copyWith(
          elapsedTime: state!.elapsedTime + const Duration(milliseconds: 10),
        );
      }
    });
  }
  
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
  
  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}

/// Provider for game state
final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState?>((ref) {
  return GameStateNotifier(ref);
});
