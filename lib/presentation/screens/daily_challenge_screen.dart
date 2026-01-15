import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/level.dart';
import '../providers/daily_challenge_provider.dart';
import 'game_screen.dart';

class DailyChallengeScreen extends ConsumerWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyChallenge = ref.watch(dailyChallengeProvider);
    final streak = ref.watch(dailyStreakProvider);
    
    if (dailyChallenge == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDateCard(dailyChallenge),
                      const SizedBox(height: 20),
                      _buildStreakCard(streak),
                      const SizedBox(height: 20),
                      _buildChallengeCard(context, ref, dailyChallenge),
                      const SizedBox(height: 20),
                      if (dailyChallenge.isCompletedToday)
                        _buildCompletedBadge(dailyChallenge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
          ),
          const Expanded(
            child: Text(
              'Daily Challenge',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildDateCard(DailyChallengeState challenge) {
    final months = ['January', 'February', 'March', 'April', 'May', 'June',
                    'July', 'August', 'September', 'October', 'November', 'December'];
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '📅',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 8),
          Text(
            weekdays[challenge.date.weekday - 1],
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textPrimary.withValues(alpha: 0.8),
            ),
          ),
          Text(
            '${months[challenge.date.month - 1]} ${challenge.date.day}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            '${challenge.date.year}',
            style: TextStyle(
              fontSize: 18,
              color: AppTheme.textPrimary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(int streak) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.textMuted.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$streak ${streak == 1 ? 'Day' : 'Days'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.warningColor,
                ),
              ),
              const Text(
                'Daily Streak',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(BuildContext context, WidgetRef ref, DailyChallengeState challenge) {
    final categoryEmoji = _getCategoryEmoji(challenge.level.category);
    final categoryName = challenge.level.category.displayName;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.textMuted.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(categoryEmoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Text(
                categoryName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            challenge.level.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: challenge.level.sortOrder == SortOrder.ascending
                  ? AppTheme.successColor.withValues(alpha: 0.2)
                  : AppTheme.warningColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  challenge.level.sortOrder == SortOrder.ascending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  size: 16,
                  color: challenge.level.sortOrder == SortOrder.ascending
                      ? AppTheme.successColor
                      : AppTheme.warningColor,
                ),
                const SizedBox(width: 4),
                Text(
                  challenge.level.sortOrder.shortName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: challenge.level.sortOrder == SortOrder.ascending
                        ? AppTheme.successColor
                        : AppTheme.warningColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Best Time Display
          if (challenge.bestTimeMs != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events, color: AppTheme.primaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Best: ${_formatTime(challenge.bestTimeMs!)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Play Button - Outlined style for "Play Again", Gradient for "Start Challenge"
          GestureDetector(
            onTap: () {
              context.go('/daily/play', extra: challenge.level);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: challenge.isCompletedToday
                    ? Colors.transparent
                    : null,
                gradient: challenge.isCompletedToday
                    ? null
                    : AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                border: challenge.isCompletedToday
                    ? Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.5), width: 2)
                    : null,
                boxShadow: challenge.isCompletedToday
                    ? null
                    : [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (challenge.isCompletedToday) ...[
                    Icon(
                      Icons.replay_rounded,
                      color: AppTheme.textSecondary,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    challenge.isCompletedToday ? 'Play Again' : 'START CHALLENGE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: challenge.isCompletedToday
                          ? AppTheme.textSecondary
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedBadge(DailyChallengeState challenge) {
    return Column(
      children: [
        // Completed status
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.successColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.successColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('✅', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Completed Today!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.successColor,
                      ),
                    ),
                    Text(
                      'Come back tomorrow for a new challenge',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Share button
        _buildShareButton(challenge),
      ],
    );
  }

  Widget _buildShareButton(DailyChallengeState challenge) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => _shareDailyResult(context, challenge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.accentColor, Color(0xFF00D4AA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'Share Result 🎯',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareDailyResult(BuildContext context, DailyChallengeState challenge) async {
    // Import share_plus at top of file if not already
    final streak = challenge.isCompletedToday ? 1 : 0; // fallback
    
    // Format date
    final now = DateTime.now();
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateStr = '${now.day} ${monthNames[now.month - 1]} ${now.year}';
    
    // Format time
    final timeMs = challenge.bestTimeMs ?? 0;
    final seconds = timeMs ~/ 1000;
    final ms = (timeMs % 1000) ~/ 10;
    final timeStr = '$seconds.${ms.toString().padLeft(2, '0')}s';
    
    final shareText = '''
🎯 Sorga Daily Challenge
📅 $dateStr

⏱️ $timeStr
🔥 Daily Streak Active!

Can you beat my time? 💪
#SorgaDaily #PuzzleGame
'''.trim();
    
    try {
      await Share.share(shareText);
    } catch (e) {
      debugPrint('Error sharing: $e');
    }
  }

  String _getCategoryEmoji(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return '🔢';
      case LevelCategory.formatted:
        return '📐';
      case LevelCategory.time:
        return '⏱️';
      case LevelCategory.names:
        return '👥';
      case LevelCategory.mixed:
        return '🎲';
      case LevelCategory.knowledge:
        return '🧠';
    }
  }

  String _formatTime(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final ms = (milliseconds % 1000) ~/ 10;
    
    if (minutes > 0) {
      return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
    }
    return '$remainingSeconds.${ms.toString().padLeft(2, '0')}s';
  }
}
