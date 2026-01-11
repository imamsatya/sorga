import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/entities/game_stats.dart';
import '../../core/constants/app_constants.dart';

/// Local database service using Hive
class LocalDatabase {
  static LocalDatabase? _instance;
  static LocalDatabase get instance => _instance ??= LocalDatabase._();
  
  LocalDatabase._();
  
  late Box<UserProgress> _progressBox;
  late Box<GameStats> _statsBox;
  
  static const String _statsBoxName = 'game_stats';
  static const String _statsKey = 'stats';
  
  /// Initialize the database
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProgressAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GameStatsAdapter());
    }
    
    // Open boxes
    _progressBox = await Hive.openBox<UserProgress>(AppConstants.progressBoxName);
    _statsBox = await Hive.openBox<GameStats>(_statsBoxName);
  }
  
  /// Get the progress box
  Box<UserProgress> get progressBox => _progressBox;
  
  /// Get current game stats
  GameStats getStats() {
    return _statsBox.get(_statsKey) ?? const GameStats();
  }
  
  /// Save game stats
  Future<void> saveStats(GameStats stats) async {
    await _statsBox.put(_statsKey, stats);
  }
  
  /// Record a play session (updates streak and play time)
  Future<GameStats> recordPlay({required int playTimeMs}) async {
    final currentStats = getStats();
    final updatedStats = currentStats.recordPlay(playTimeMs: playTimeMs);
    await saveStats(updatedStats);
    return updatedStats;
  }
  
  /// Mark tutorial as seen
  Future<void> markTutorialSeen() async {
    final stats = getStats();
    await saveStats(stats.copyWith(hasSeenTutorial: true));
  }
  
  /// Increment consecutive perfect count
  Future<void> incrementPerfect() async {
    final stats = getStats();
    await saveStats(stats.incrementPerfect());
  }
  
  /// Reset consecutive perfect count
  Future<void> resetPerfect() async {
    final stats = getStats();
    await saveStats(stats.resetPerfect());
  }
  
  /// Close the database
  Future<void> close() async {
    await _progressBox.close();
    await _statsBox.close();
  }
}
