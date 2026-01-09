import '../entities/user_progress.dart';

/// Repository interface for user progress
abstract class ProgressRepository {
  /// Get progress for a specific level
  Future<UserProgress?> getProgress(int levelId);
  
  /// Get all progress
  Future<List<UserProgress>> getAllProgress();
  
  /// Save progress for a level
  Future<void> saveProgress(UserProgress progress);
  
  /// Get total completed levels
  Future<int> getCompletedCount();
  
  /// Get the highest unlocked level
  Future<int> getHighestUnlockedLevel();
  
  /// Clear all progress (reset game)
  Future<void> clearAllProgress();
}
