import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/level_item.dart';
import '../../domain/entities/multiplayer_session.dart';
import '../../levels/level_generator.dart';

/// Provider for the multiplayer session
final multiplayerSessionProvider = StateNotifierProvider<MultiplayerNotifier, MultiplayerSession?>(
  (ref) => MultiplayerNotifier(),
);

/// Notifier for managing multiplayer game state
class MultiplayerNotifier extends StateNotifier<MultiplayerSession?> {
  MultiplayerNotifier() : super(null);
  
  final LevelGenerator _levelGenerator = LevelGenerator();
  
  /// Start a new multiplayer session
  void startSession({
    required int itemCount,
    required LevelCategory category,
    required bool isMemoryMode,
    required List<String> playerNames,
  }) {
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Create players
    final players = playerNames.asMap().entries.map((entry) {
      return MultiplayerPlayer(
        id: 'player_${entry.key}',
        name: entry.value,
      );
    }).toList();
    
    // Generate a custom level for this session
    final level = _generateCustomLevel(
      category: category,
      itemCount: itemCount,
      isMemoryMode: isMemoryMode,
      sessionId: sessionId,
    );
    
    state = MultiplayerSession(
      sessionId: sessionId,
      itemCount: itemCount,
      category: category,
      isMemoryMode: isMemoryMode,
      players: players,
      level: level,
      results: {},
      currentPlayerIndex: 0,
      isComplete: false,
    );
  }
  
  /// Generate a custom level based on session settings
  Level _generateCustomLevel({
    required LevelCategory category,
    required int itemCount,
    required bool isMemoryMode,
    required String sessionId,
  }) {
    // Use a sample level from the category and adjust item count
    final sampleLevel = _levelGenerator.getLevelsByCategory(category).first;
    final random = Random(sessionId.hashCode);
    
    // Generate items based on category
    List<LevelItem> items = _generateItemsForCategory(category, itemCount, random);
    
    // Shuffle initial order
    items.shuffle(random);
    
    // Random sort order
    final sortOrder = random.nextBool() ? SortOrder.ascending : SortOrder.descending;
    
    return Level(
      id: 9999, // Special ID for multiplayer
      localId: 1,
      category: category,
      sortOrder: sortOrder,
      title: 'Multiplayer',
      description: 'Sort $itemCount items ${sortOrder.shortName}',
      items: items,
      isMemory: isMemoryMode,
    );
  }
  
  /// Generate items for the given category
  List<LevelItem> _generateItemsForCategory(LevelCategory category, int itemCount, Random random) {
    switch (category) {
      case LevelCategory.basic:
        // Generate random numbers
        final numbers = <int>{};
        while (numbers.length < itemCount) {
          numbers.add(random.nextInt(1000) + 1);
        }
        return numbers.map((n) => LevelItem(
          id: 'item_$n',
          displayValue: n.toString(),
          sortValue: n.toDouble(),
        )).toList();
        
      case LevelCategory.formatted:
        // Generate formatted numbers (with commas, decimals, etc.)
        final numbers = <int>{};
        while (numbers.length < itemCount) {
          numbers.add(random.nextInt(100000) + 100);
        }
        return numbers.map((n) {
          final formatted = n.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
          return LevelItem(
            id: 'item_$n',
            displayValue: formatted,
            sortValue: n.toDouble(),
          );
        }).toList();
        
      case LevelCategory.time:
        // Generate time durations
        final times = <int>{};
        while (times.length < itemCount) {
          times.add(random.nextInt(7200) + 60); // 1 min to 2 hours in seconds
        }
        return times.map((t) {
          final hours = t ~/ 3600;
          final minutes = (t % 3600) ~/ 60;
          final seconds = t % 60;
          String display;
          if (hours > 0) {
            display = '${hours}h ${minutes}m';
          } else if (minutes > 0) {
            display = '${minutes}m ${seconds}s';
          } else {
            display = '${seconds}s';
          }
          return LevelItem(
            id: 'item_$t',
            displayValue: display,
            sortValue: t.toDouble(),
          );
        }).toList();
        
      case LevelCategory.names:
        // Generate random names
        const firstNames = ['Alex', 'Emma', 'Liam', 'Olivia', 'Noah', 'Ava', 'Elijah', 'Sophia', 
          'James', 'Isabella', 'Benjamin', 'Mia', 'Lucas', 'Charlotte', 'Henry', 'Amelia',
          'Alexander', 'Harper', 'Sebastian', 'Evelyn', 'Jack', 'Abigail', 'Aiden', 'Emily',
          'Owen', 'Elizabeth', 'Samuel', 'Sofia', 'Ryan', 'Avery'];
        final shuffled = List<String>.from(firstNames)..shuffle(random);
        final selected = shuffled.take(itemCount).toList();
        return selected.asMap().entries.map((entry) {
          final name = entry.value;
          return LevelItem(
            id: 'item_$name',
            displayValue: name,
            sortValue: name.toLowerCase().codeUnits.fold(0.0, (sum, c) => sum * 26 + c - 96),
          );
        }).toList();
        
      case LevelCategory.mixed:
        // Mix of numbers and formatted values
        final numbers = <int>{};
        while (numbers.length < itemCount) {
          numbers.add(random.nextInt(10000) + 1);
        }
        return numbers.map((n) {
          // Randomly format some as decimals, some as plain
          final useDecimal = random.nextBool();
          if (useDecimal) {
            final decimal = n + random.nextDouble();
            return LevelItem(
              id: 'item_$n',
              displayValue: decimal.toStringAsFixed(2),
              sortValue: decimal,
            );
          } else {
            return LevelItem(
              id: 'item_$n',
              displayValue: n.toString(),
              sortValue: n.toDouble(),
            );
          }
        }).toList();
        
      case LevelCategory.knowledge:
        // Knowledge not supported in multiplayer, fallback to basic
        return _generateItemsForCategory(LevelCategory.basic, itemCount, random);
    }
  }
  
  /// Get shuffled items for a specific player (fairness logic)
  /// All players get the SAME shuffled order for fairness
  List<LevelItem> getShuffledItemsForPlayer(String playerId) {
    if (state == null) return [];
    
    // Use session ID as seed so ALL players get the SAME shuffle (fair competition)
    final seed = state!.sessionId.hashCode;
    final random = Random(seed);
    
    final items = List<LevelItem>.from(state!.level.items);
    
    // Shuffle until items are NOT in correct order (avoid instant-win scenario)
    int maxAttempts = 10;
    while (maxAttempts > 0) {
      items.shuffle(random);
      
      // Check if items are in correct order
      bool isAlreadySorted = true;
      for (int i = 0; i < items.length - 1; i++) {
        if (state!.level.sortOrder == SortOrder.ascending) {
          if (items[i].sortValue > items[i + 1].sortValue) {
            isAlreadySorted = false;
            break;
          }
        } else {
          if (items[i].sortValue < items[i + 1].sortValue) {
            isAlreadySorted = false;
            break;
          }
        }
      }
      
      if (!isAlreadySorted) break;
      maxAttempts--;
    }
    
    return items;
  }
  
  /// Submit a player's result
  void submitResult({
    required String playerId,
    required int timeMs,
    int? memorizeTimeMs,
    int? sortTimeMs,
    required int attempts,
    ResultStatus status = ResultStatus.success,
  }) {
    if (state == null) return;
    
    final result = PlayerResult(
      playerId: playerId,
      timeMs: timeMs,
      memorizeTimeMs: memorizeTimeMs,
      sortTimeMs: sortTimeMs,
      attempts: attempts,
      isCompleted: true,
      status: status,
    );
    
    final newResults = Map<String, PlayerResult>.from(state!.results);
    newResults[playerId] = result;
    
    // Check if all players have completed
    final allCompleted = newResults.length == state!.players.length;
    
    state = state!.copyWith(
      results: newResults,
      isComplete: allCompleted,
    );
  }
  
  /// Move to the next player
  void nextPlayer() {
    if (state == null) return;
    
    final nextIndex = state!.currentPlayerIndex + 1;
    if (nextIndex < state!.players.length) {
      state = state!.copyWith(currentPlayerIndex: nextIndex);
    }
  }
  
  /// Get sorted leaderboard results
  List<PlayerResult> getLeaderboard() {
    if (state == null) return [];
    
    final results = state!.results.values.toList();
    results.sort((a, b) => a.timeMs.compareTo(b.timeMs));
    return results;
  }
  
  /// Get player name by ID
  String getPlayerName(String playerId) {
    if (state == null) return '';
    return state!.players.firstWhere((p) => p.id == playerId).name;
  }
  
  /// Reset the session for a new game with same settings
  void playAgain() {
    if (state == null) return;
    
    final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    final newLevel = _generateCustomLevel(
      category: state!.category,
      itemCount: state!.itemCount,
      isMemoryMode: state!.isMemoryMode,
      sessionId: newSessionId,
    );
    
    state = MultiplayerSession(
      sessionId: newSessionId,
      itemCount: state!.itemCount,
      category: state!.category,
      isMemoryMode: state!.isMemoryMode,
      players: state!.players,
      level: newLevel,
      results: {},
      currentPlayerIndex: 0,
      isComplete: false,
    );
  }
  
  /// End the session
  void endSession() {
    state = null;
  }
}
