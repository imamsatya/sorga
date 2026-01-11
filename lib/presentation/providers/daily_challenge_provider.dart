import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/level.dart';
import '../../data/datasources/local_database.dart';
import '../../levels/daily_challenge_generator.dart';

/// Daily Challenge state
class DailyChallengeState {
  final Level level;
  final int? bestTimeMs;
  final bool isCompletedToday;
  final DateTime date;

  DailyChallengeState({
    required this.level,
    required this.date,
    this.bestTimeMs,
    this.isCompletedToday = false,
  });

  DailyChallengeState copyWith({
    Level? level,
    int? bestTimeMs,
    bool? isCompletedToday,
    DateTime? date,
  }) {
    return DailyChallengeState(
      level: level ?? this.level,
      date: date ?? this.date,
      bestTimeMs: bestTimeMs ?? this.bestTimeMs,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
    );
  }
}

/// Daily Challenge notifier
class DailyChallengeNotifier extends StateNotifier<DailyChallengeState?> {
  final DailyChallengeGenerator _generator = DailyChallengeGenerator();
  
  DailyChallengeNotifier() : super(null) {
    _loadTodaysChallenge();
  }

  void _loadTodaysChallenge() {
    final today = DateTime.now();
    final level = _generator.generateTodaysChallenge();
    final dateKey = _getDateKey(today);
    
    // Load progress from Hive
    final bestTime = LocalDatabase.instance.settingsBox.get('daily_best_$dateKey');
    final completed = LocalDatabase.instance.settingsBox.get('daily_completed_$dateKey') ?? false;
    
    state = DailyChallengeState(
      level: level,
      date: today,
      bestTimeMs: bestTime is int ? bestTime : null,
      isCompletedToday: completed is bool ? completed : false,
    );
  }

  String _getDateKey(DateTime date) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
  }

  /// Complete today's challenge with a time
  Future<void> completeChallenge(int timeMs) async {
    if (state == null) return;
    
    final dateKey = _getDateKey(state!.date);
    final currentBest = state!.bestTimeMs;
    
    // Save as best if new record or first completion
    if (currentBest == null || timeMs < currentBest) {
      await LocalDatabase.instance.settingsBox.put('daily_best_$dateKey', timeMs);
    }
    
    await LocalDatabase.instance.settingsBox.put('daily_completed_$dateKey', true);
    
    // Update streak
    await _updateStreak();
    
    state = state!.copyWith(
      bestTimeMs: currentBest == null || timeMs < currentBest ? timeMs : currentBest,
      isCompletedToday: true,
    );
  }

  Future<void> _updateStreak() async {
    final currentStreak = LocalDatabase.instance.settingsBox.get('daily_streak') ?? 0;
    final lastCompletedDate = LocalDatabase.instance.settingsBox.get('daily_last_completed');
    
    final today = DateTime.now();
    final todayKey = _getDateKey(today);
    
    if (lastCompletedDate == null) {
      // First completion ever
      await LocalDatabase.instance.settingsBox.put('daily_streak', 1);
    } else {
      final yesterday = today.subtract(const Duration(days: 1));
      final yesterdayKey = _getDateKey(yesterday);
      
      if (lastCompletedDate == yesterdayKey) {
        // Consecutive day - increment streak
        await LocalDatabase.instance.settingsBox.put('daily_streak', currentStreak + 1);
      } else if (lastCompletedDate != todayKey) {
        // Missed days - reset streak
        await LocalDatabase.instance.settingsBox.put('daily_streak', 1);
      }
    }
    
    await LocalDatabase.instance.settingsBox.put('daily_last_completed', todayKey);
  }

  /// Refresh to load today's challenge
  void refresh() {
    _loadTodaysChallenge();
  }

  /// Get current daily streak
  int getDailyStreak() {
    return LocalDatabase.instance.settingsBox.get('daily_streak') ?? 0;
  }
}

/// Provider for daily challenge
final dailyChallengeProvider = StateNotifierProvider<DailyChallengeNotifier, DailyChallengeState?>((ref) {
  return DailyChallengeNotifier();
});

/// Provider for daily streak count
final dailyStreakProvider = Provider<int>((ref) {
  final dailyChallenge = ref.watch(dailyChallengeProvider);
  return LocalDatabase.instance.settingsBox.get('daily_streak') ?? 0;
});
