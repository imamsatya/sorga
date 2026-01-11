import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'game_stats.g.dart';

/// Global game statistics including streak tracking
@HiveType(typeId: 1)
class GameStats extends Equatable {
  /// Current consecutive days streak
  @HiveField(0)
  final int currentStreak;
  
  /// All-time longest streak
  @HiveField(1)
  final int longestStreak;
  
  /// Last date the user played (completed a level)
  @HiveField(2)
  final DateTime? lastPlayedDate;
  
  /// Total play time in milliseconds
  @HiveField(3)
  final int totalPlayTimeMs;
  
  /// Whether the user has seen the tutorial
  @HiveField(4)
  final bool hasSeenTutorial;
  
  /// First time the app was opened
  @HiveField(5)
  final DateTime? firstOpenedAt;

  const GameStats({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastPlayedDate,
    this.totalPlayTimeMs = 0,
    this.hasSeenTutorial = false,
    this.firstOpenedAt,
  });

  /// Get total play time as Duration
  Duration get totalPlayTime => Duration(milliseconds: totalPlayTimeMs);

  /// Format total play time as string
  String get totalPlayTimeFormatted {
    final duration = totalPlayTime;
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  /// Check if user played today
  bool get playedToday {
    if (lastPlayedDate == null) return false;
    final now = DateTime.now();
    return lastPlayedDate!.year == now.year &&
        lastPlayedDate!.month == now.month &&
        lastPlayedDate!.day == now.day;
  }

  /// Check if streak should continue (played yesterday or today)
  bool get isStreakActive {
    if (lastPlayedDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastPlayed = DateTime(
      lastPlayedDate!.year, 
      lastPlayedDate!.month, 
      lastPlayedDate!.day,
    );
    final difference = today.difference(lastPlayed).inDays;
    return difference <= 1;
  }

  /// Update streak when level is completed
  GameStats recordPlay({required int playTimeMs}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    int newStreak = currentStreak;
    
    if (lastPlayedDate == null) {
      // First play ever
      newStreak = 1;
    } else {
      final lastPlayed = DateTime(
        lastPlayedDate!.year, 
        lastPlayedDate!.month, 
        lastPlayedDate!.day,
      );
      final difference = today.difference(lastPlayed).inDays;
      
      if (difference == 0) {
        // Same day, streak unchanged
        newStreak = currentStreak;
      } else if (difference == 1) {
        // Next day, increment streak
        newStreak = currentStreak + 1;
      } else {
        // Streak broken, reset to 1
        newStreak = 1;
      }
    }
    
    final newLongest = newStreak > longestStreak ? newStreak : longestStreak;
    
    return GameStats(
      currentStreak: newStreak,
      longestStreak: newLongest,
      lastPlayedDate: now,
      totalPlayTimeMs: totalPlayTimeMs + playTimeMs,
      hasSeenTutorial: hasSeenTutorial,
      firstOpenedAt: firstOpenedAt ?? now,
    );
  }

  GameStats copyWith({
    int? currentStreak,
    int? longestStreak,
    DateTime? lastPlayedDate,
    int? totalPlayTimeMs,
    bool? hasSeenTutorial,
    DateTime? firstOpenedAt,
  }) {
    return GameStats(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      totalPlayTimeMs: totalPlayTimeMs ?? this.totalPlayTimeMs,
      hasSeenTutorial: hasSeenTutorial ?? this.hasSeenTutorial,
      firstOpenedAt: firstOpenedAt ?? this.firstOpenedAt,
    );
  }

  @override
  List<Object?> get props => [
    currentStreak, 
    longestStreak, 
    lastPlayedDate, 
    totalPlayTimeMs, 
    hasSeenTutorial,
    firstOpenedAt,
  ];
}
