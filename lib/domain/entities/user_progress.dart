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

  const UserProgress({
    required this.levelId,
    this.completed = false,
    this.bestTimeMs,
    this.completedAt,
    this.attempts = 0,
  });

  /// Get best time as Duration
  Duration? get bestTime => 
      bestTimeMs != null ? Duration(milliseconds: bestTimeMs!) : null;
  
  /// Format best time as string
  String get bestTimeFormatted {
    if (bestTimeMs == null) return '--:--';
    final duration = Duration(milliseconds: bestTimeMs!);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    final ms = (duration.inMilliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }

  /// Create a copy with updated values
  UserProgress copyWith({
    int? levelId,
    bool? completed,
    int? bestTimeMs,
    DateTime? completedAt,
    int? attempts,
  }) {
    return UserProgress(
      levelId: levelId ?? this.levelId,
      completed: completed ?? this.completed,
      bestTimeMs: bestTimeMs ?? this.bestTimeMs,
      completedAt: completedAt ?? this.completedAt,
      attempts: attempts ?? this.attempts,
    );
  }

  /// Create a new progress with a new attempt recorded
  UserProgress withNewAttempt(Duration time, {required bool success}) {
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
    );
  }

  @override
  List<Object?> get props => [levelId, completed, bestTimeMs, completedAt, attempts];
}
