import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/level_item.dart';
import '../../domain/entities/user_progress.dart';
import 'game_providers.dart';

/// State for the active game
class GameState {
  final Level level;
  final List<LevelItem> currentOrder;
  final Duration elapsedTime;
  final bool isRunning;
  final bool isCompleted;
  final bool isCorrect;
  final int failedAttempts; // Track failed attempts this session
  
  const GameState({
    required this.level,
    required this.currentOrder,
    this.elapsedTime = Duration.zero,
    this.isRunning = false,
    this.isCompleted = false,
    this.isCorrect = false,
    this.failedAttempts = 0,
  });
  
  /// Can continue after failure (only if less than 2 failed attempts)
  bool get canContinue => failedAttempts < 2;
  
  GameState copyWith({
    Level? level,
    List<LevelItem>? currentOrder,
    Duration? elapsedTime,
    bool? isRunning,
    bool? isCompleted,
    bool? isCorrect,
    int? failedAttempts,
  }) {
    return GameState(
      level: level ?? this.level,
      currentOrder: currentOrder ?? this.currentOrder,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isRunning: isRunning ?? this.isRunning,
      isCompleted: isCompleted ?? this.isCompleted,
      isCorrect: isCorrect ?? this.isCorrect,
      failedAttempts: failedAttempts ?? this.failedAttempts,
    );
  }
  
  String get formattedTime {
    final minutes = elapsedTime.inMinutes;
    final seconds = elapsedTime.inSeconds % 60;
    final ms = (elapsedTime.inMilliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }
}

/// Notifier for game state
class GameStateNotifier extends StateNotifier<GameState?> {
  final Ref _ref;
  Timer? _timer;
  
  GameStateNotifier(this._ref) : super(null);
  
  /// Start a new game with a level
  void startGame(int levelId) {
    _stopTimer();
    
    final level = _ref.read(levelProvider(levelId));
    // Shuffle items for initial display
    final shuffled = List<LevelItem>.from(level.items);
    
    state = GameState(
      level: level,
      currentOrder: shuffled,
      isRunning: false, // Start paused for countdown
    );
    
    // Timer will be started by startPlaying() after countdown
  }
  
  /// Start the actual gameplay and timer
  void startPlaying() {
    if (state == null) return;
    
    state = state!.copyWith(isRunning: true);
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
    
    final correctOrder = state!.level.correctOrder;
    bool isCorrect = true;
    
    for (int i = 0; i < state!.currentOrder.length; i++) {
      if (state!.currentOrder[i].id != correctOrder[i].id) {
        isCorrect = false;
        break;
      }
    }
    
    state = state!.copyWith(
      isRunning: false,
      isCompleted: true,
      isCorrect: isCorrect,
      // Increment failed attempts if wrong
      failedAttempts: isCorrect ? state!.failedAttempts : state!.failedAttempts + 1,
    );
    
    // Save progress only if correct
    if (isCorrect) {
      await _saveProgress();
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
  Future<void> _saveProgress() async {
    if (state == null) return;
    
    final repository = _ref.read(progressRepositoryProvider);
    final existingProgress = await repository.getProgress(state!.level.id);
    
    UserProgress newProgress;
    if (existingProgress != null) {
      newProgress = existingProgress.withNewAttempt(
        state!.elapsedTime,
        success: true,
      );
    } else {
      newProgress = UserProgress(
        levelId: state!.level.id,
        completed: true,
        bestTimeMs: state!.elapsedTime.inMilliseconds,
        completedAt: DateTime.now(),
        attempts: 1,
      );
    }
    
    await repository.saveProgress(newProgress);
    
    // Invalidate all progress providers to refresh UI
    _ref.invalidate(allProgressProvider);
    _ref.invalidate(completedCountProvider);
    _ref.invalidate(highestUnlockedProvider);
    // Also invalidate the specific level progress
    _ref.invalidate(levelProgressProvider(state!.level.id));
  }
  
  /// Retry the current level
  void retry() {
    if (state == null) return;
    final levelId = state!.level.id;
    startGame(levelId);
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
