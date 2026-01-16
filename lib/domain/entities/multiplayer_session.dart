import 'package:flutter/foundation.dart';
import '../entities/level.dart';

/// Represents a local multiplayer game session
class MultiplayerSession {
  final String sessionId;
  final int itemCount;
  final LevelCategory category;
  final bool isMemoryMode;
  final List<MultiplayerPlayer> players;
  final Level level;
  final Map<String, PlayerResult> results;
  final int currentPlayerIndex;
  final bool isComplete;

  const MultiplayerSession({
    required this.sessionId,
    required this.itemCount,
    required this.category,
    required this.isMemoryMode,
    required this.players,
    required this.level,
    this.results = const {},
    this.currentPlayerIndex = 0,
    this.isComplete = false,
  });

  MultiplayerPlayer get currentPlayer => players[currentPlayerIndex];
  
  bool get allPlayersCompleted => results.length == players.length;
  
  int get remainingPlayers => players.length - results.length;

  MultiplayerSession copyWith({
    String? sessionId,
    int? itemCount,
    LevelCategory? category,
    bool? isMemoryMode,
    List<MultiplayerPlayer>? players,
    Level? level,
    Map<String, PlayerResult>? results,
    int? currentPlayerIndex,
    bool? isComplete,
  }) {
    return MultiplayerSession(
      sessionId: sessionId ?? this.sessionId,
      itemCount: itemCount ?? this.itemCount,
      category: category ?? this.category,
      isMemoryMode: isMemoryMode ?? this.isMemoryMode,
      players: players ?? this.players,
      level: level ?? this.level,
      results: results ?? this.results,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

/// Represents a player in a multiplayer session
@immutable
class MultiplayerPlayer {
  final String id;
  final String name;

  const MultiplayerPlayer({
    required this.id,
    required this.name,
  });
}

/// Status of player result
enum ResultStatus {
  success,  // Completed successfully
  failed,   // Ran out of attempts
  gaveUp,   // Manually gave up
}

/// Represents the result of a player's turn
@immutable
class PlayerResult {
  final String playerId;
  final int timeMs;
  final int? memorizeTimeMs;  // For memory mode
  final int? sortTimeMs;      // For memory mode
  final int attempts;
  final bool isCompleted;
  final ResultStatus status;

  const PlayerResult({
    required this.playerId,
    required this.timeMs,
    this.memorizeTimeMs,
    this.sortTimeMs,
    required this.attempts,
    required this.isCompleted,
    this.status = ResultStatus.success,
  });
  
  /// Total time in seconds for display
  double get timeSeconds => timeMs / 1000.0;
  
  /// Check if this is a DNF (did not finish)
  bool get isDNF => status != ResultStatus.success;
  
  /// Get display text for status
  String get statusText {
    switch (status) {
      case ResultStatus.success:
        return formattedTime;
      case ResultStatus.failed:
        return 'Gagal';
      case ResultStatus.gaveUp:
        return 'Menyerah';
    }
  }
  
  /// Format time as MM:SS.cc
  String get formattedTime {
    final totalSeconds = timeMs / 1000;
    final minutes = (totalSeconds / 60).floor();
    final seconds = (totalSeconds % 60).floor();
    final centiseconds = ((totalSeconds * 100) % 100).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
  }
}
