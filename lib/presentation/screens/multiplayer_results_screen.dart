import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/multiplayer_session.dart';
import '../providers/multiplayer_provider.dart';

class MultiplayerResultsScreen extends ConsumerWidget {
  const MultiplayerResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(multiplayerSessionProvider);
    if (session == null) {
      return const Scaffold(backgroundColor: AppTheme.backgroundDark, body: Center(child: Text('No session', style: TextStyle(color: Colors.white))));
    }

    final leaderboard = ref.read(multiplayerSessionProvider.notifier).getLeaderboard();
    final winnerTime = leaderboard.isNotEmpty ? leaderboard.first.timeMs : 0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text('🏆 Leaderboard', style: TextStyle(color: AppTheme.textPrimary, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(session.isMemoryMode ? '✨ Memory Mode' : '${session.itemCount} items', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 16)),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  final result = leaderboard[index];
                  final playerName = ref.read(multiplayerSessionProvider.notifier).getPlayerName(result.playerId);
                  final timeDiff = result.timeMs - winnerTime;
                  return _buildLeaderboardItem(context, rank: index + 1, playerName: playerName, result: result, timeDiff: timeDiff, isWinner: index == 0, session: session);
                },
              ),
            ),
            _buildActionButtons(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardItem(BuildContext context, {required int rank, required String playerName, required PlayerResult result, required int timeDiff, required bool isWinner, required MultiplayerSession session}) {
    final rankColors = {1: const Color(0xFFFFD700), 2: const Color(0xFFC0C0C0), 3: const Color(0xFFCD7F32)};
    final rankColor = rankColors[rank] ?? AppTheme.textSecondary;
    final playerColor = _getPlayerColor(session.players.indexWhere((p) => p.id == result.playerId));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWinner ? rankColor.withOpacity(0.15) : AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isWinner ? rankColor : AppTheme.primaryColor.withOpacity(0.3), width: isWinner ? 2 : 1),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(color: rankColor.withOpacity(isWinner ? 1 : 0.2), borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: isWinner && rank == 1
                  ? const Text('👑', style: TextStyle(fontSize: 24))
                  : Text('#$rank', style: TextStyle(color: isWinner ? Colors.black : rankColor, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: playerColor, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Text(playerName, style: TextStyle(color: isWinner ? rankColor : AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 4),
                if (session.isMemoryMode && result.memorizeTimeMs != null)
                  Text('Memorize: ${_formatTime(result.memorizeTimeMs!)} • Sort: ${_formatTime(result.sortTimeMs ?? 0)}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(result.formattedTime, style: TextStyle(color: isWinner ? rankColor : AppTheme.textPrimary, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              if (timeDiff > 0)
                Text('+${_formatTime(timeDiff)}', style: const TextStyle(color: AppTheme.errorColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(int ms) {
    final totalSeconds = ms / 1000;
    final minutes = (totalSeconds / 60).floor();
    final seconds = (totalSeconds % 60).floor();
    final centiseconds = ((totalSeconds * 100) % 100).floor();
    if (minutes > 0) return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
    return '${seconds}.${centiseconds.toString().padLeft(2, '0')}s';
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () { ref.read(multiplayerSessionProvider.notifier).endSession(); context.go('/'); },
              icon: const Icon(Icons.home),
              label: const Text('Home'),
              style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary, side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3)), padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () { ref.read(multiplayerSessionProvider.notifier).playAgain(); context.go('/multiplayer/transition'); },
              icon: const Icon(Icons.replay),
              label: const Text('Play Again'),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPlayerColor(int index) {
    const colors = [Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFFFF9800), Color(0xFF9C27B0)];
    return colors[index % colors.length];
  }
}
