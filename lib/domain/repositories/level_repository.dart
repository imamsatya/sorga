import '../entities/level.dart';

/// Repository interface for levels
abstract class LevelRepository {
  /// Get a specific level by ID
  Level getLevel(int levelId);
  
  /// Get all levels
  List<Level> getAllLevels();
  
  /// Get levels by category
  List<Level> getLevelsByCategory(LevelCategory category);
  
  /// Get total number of levels
  int get totalLevels;
}
