import '../../domain/entities/level.dart';
import '../../domain/repositories/level_repository.dart';
import '../../levels/level_generator.dart';
import '../../core/constants/app_constants.dart';

/// Implementation of LevelRepository using LevelGenerator
class LevelRepositoryImpl implements LevelRepository {
  final LevelGenerator _generator;
  
  LevelRepositoryImpl(this._generator);
  
  @override
  Level getLevel(int levelId) {
    return _generator.getLevel(levelId);
  }
  
  @override
  List<Level> getAllLevels() {
    return _generator.getAllLevels();
  }
  
  @override
  List<Level> getLevelsByCategory(LevelCategory category) {
    return _generator.getLevelsByCategory(category);
  }
  
  @override
  int get totalLevels => AppConstants.totalLevels;
}
