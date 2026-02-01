import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_stats.dart';
import '../../data/datasources/local_database.dart';

/// Provider for game stats
final gameStatsNotifierProvider = StateNotifierProvider<GameStatsNotifier, GameStats>((ref) {
  return GameStatsNotifier();
});

/// Notifier for game stats state
class GameStatsNotifier extends StateNotifier<GameStats> {
  GameStatsNotifier() : super(const GameStats()) {
    _loadStats();
  }

  void _loadStats() {
    state = LocalDatabase.instance.getStats();
  }

  /// Record a play session (call when level is completed)
  Future<void> recordPlay({required int playTimeMs}) async {
    final updatedStats = await LocalDatabase.instance.recordPlay(playTimeMs: playTimeMs);
    state = updatedStats;
  }

  /// Mark tutorial as seen
  Future<void> markTutorialSeen() async {
    await LocalDatabase.instance.markTutorialSeen();
    state = state.copyWith(hasSeenTutorial: true);
  }

  /// Reload stats from database
  void refresh() {
    _loadStats();
  }
}
