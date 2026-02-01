import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_progress.g.dart';

/// Represents user progress for a single level
@HiveType(typeId: 0)
class UserProgress extends Equatable {
  /// Level ID
  @HiveField(0)
  final int levelId;
  
  /// Whether the level is completed
  @HiveField(1)
  final bool completed;
  
  /// Best time in milliseconds (null if not completed)
  @HiveField(2)
  final int? bestTimeMs;
  
  /// When the level was first completed
  @HiveField(3)
  final DateTime? completedAt;
  
  /// Number of attempts
  @HiveField(4)
  final int attempts;
  
  /// Memory mode: best memorize time in milliseconds
  @HiveField(5)
  final int? memorizeTimeMs;
  
  /// Memory mode: best sort time in milliseconds
  @HiveField(6)
  final int? sortTimeMs;

  const UserProgress({
    required this.levelId,
    this.completed = false,
    this.bestTimeMs,
    this.completedAt,
    this.attempts = 0,
    this.memorizeTimeMs,
    this.sortTimeMs,
  });

  /// Get best time as Duration
  Duration? get bestTime => 
      bestTimeMs != null ? Duration(milliseconds: bestTimeMs!) : null;
  
  /// Get memorize time as Duration
  Duration? get memorizeTime =>
      memorizeTimeMs != null ? Duration(milliseconds: memorizeTimeMs!) : null;
  
  /// Get sort time as Duration  
  Duration? get sortTime =>
      sortTimeMs != null ? Duration(milliseconds: sortTimeMs!) : null;
  
  /// Format best time as string
  String get bestTimeFormatted {
    if (bestTimeMs == null) return '--:--';
    final duration = Duration(milliseconds: bestTimeMs!);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final ms = (duration.inMilliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }
  
  /// Format memorize time as string
  String get memorizeTimeFormatted {
    if (memorizeTimeMs == null) return '--';
    final duration = Duration(milliseconds: memorizeTimeMs!);
    final seconds = duration.inSeconds;
    final ms = (duration.inMilliseconds % 1000) ~/ 10;
    return '${seconds.toString()}.${ms.toString().padLeft(2, '0')}s';
  }
  
  /// Format sort time as string
  String get sortTimeFormatted {
    if (sortTimeMs == null) return '--:--';
    final duration = Duration(milliseconds: sortTimeMs!);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final ms = (duration.inMilliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }
  
  /// Check if this is a memory level progress (has memory time data)
  bool get isMemoryProgress => memorizeTimeMs != null || sortTimeMs != null;

  /// Create a copy with updated values
  UserProgress copyWith({
    int? levelId,
    bool? completed,
    int? bestTimeMs,
    DateTime? completedAt,
    int? attempts,
    int? memorizeTimeMs,
    int? sortTimeMs,
  }) {
    return UserProgress(
      levelId: levelId ?? this.levelId,
      completed: completed ?? this.completed,
      bestTimeMs: bestTimeMs ?? this.bestTimeMs,
      completedAt: completedAt ?? this.completedAt,
      attempts: attempts ?? this.attempts,
      memorizeTimeMs: memorizeTimeMs ?? this.memorizeTimeMs,
      sortTimeMs: sortTimeMs ?? this.sortTimeMs,
    );
  }

  /// Create a new progress with a new attempt recorded
  UserProgress withNewAttempt(
    Duration time, {
    required bool success,
    Duration? memorizeTime,
    Duration? sortTime,
  }) {
    if (!success) {
      return copyWith(attempts: attempts + 1);
    }
    
    final timeMs = time.inMilliseconds;
    final isBetter = bestTimeMs == null || timeMs < bestTimeMs!;
    
    return UserProgress(
      levelId: levelId,
      completed: true,
      bestTimeMs: isBetter ? timeMs : bestTimeMs,
      completedAt: completedAt ?? DateTime.now(),
      attempts: attempts + 1,
      // For memory mode: store breakdown times if this is a better total time
      memorizeTimeMs: isBetter && memorizeTime != null 
          ? memorizeTime.inMilliseconds 
          : memorizeTimeMs,
      sortTimeMs: isBetter && sortTime != null 
          ? sortTime.inMilliseconds 
          : sortTimeMs,
    );
  }

  @override
  List<Object?> get props => [
    levelId, 
    completed, 
    bestTimeMs, 
    completedAt, 
    attempts,
    memorizeTimeMs,
    sortTimeMs,
  ];
}
