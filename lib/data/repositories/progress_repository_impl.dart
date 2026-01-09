import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/local_database.dart';

/// Implementation of ProgressRepository using Hive
class ProgressRepositoryImpl implements ProgressRepository {
  final LocalDatabase _database;
  
  ProgressRepositoryImpl(this._database);
  
  @override
  Future<UserProgress?> getProgress(int levelId) async {
    return _database.progressBox.get(levelId);
  }
  
  @override
  Future<List<UserProgress>> getAllProgress() async {
    return _database.progressBox.values.toList();
  }
  
  @override
  Future<void> saveProgress(UserProgress progress) async {
    await _database.progressBox.put(progress.levelId, progress);
  }
  
  @override
  Future<int> getCompletedCount() async {
    return _database.progressBox.values
        .where((p) => p.completed)
        .length;
  }
  
  @override
  Future<int> getHighestUnlockedLevel() async {
    // First level is always unlocked
    if (_database.progressBox.isEmpty) return 1;
    
    // Find the highest completed level
    int highest = 0;
    for (final progress in _database.progressBox.values) {
      if (progress.completed && progress.levelId > highest) {
        highest = progress.levelId;
      }
    }
    
    // Unlock the next level
    return highest + 1;
  }
  
  @override
  Future<void> clearAllProgress() async {
    await _database.progressBox.clear();
  }
}
