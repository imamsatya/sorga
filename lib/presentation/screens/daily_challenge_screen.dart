import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/level.dart';
import '../../l10n/app_localizations.dart';
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Column(
                    children: [
                      _buildDateCard(context, dailyChallenge),
                      const SizedBox(height: 16),
                      _buildStreakCard(context, streak),
                      const SizedBox(height: 16),
                      _buildChallengeCard(context, ref, dailyChallenge),
                      const SizedBox(height: 16),
                      if (dailyChallenge.isCompletedToday)
                        _buildCompletedBadge(context, dailyChallenge),
                    ],
                  ),
                ),
              ),
              // Fixed bottom Share button - only show when completed
              if (dailyChallenge.isCompletedToday)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: _buildFixedShareButton(dailyChallenge),
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
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.dailyChallenge,
              textAlign: TextAlign.center,
              style: const TextStyle(
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

  Widget _buildDateCard(BuildContext context, DailyChallengeState challenge) {
    final l10n = AppLocalizations.of(context)!;
    final months = [l10n.january, l10n.february, l10n.march, l10n.april, l10n.may, l10n.june,
                    l10n.july, l10n.august, l10n.september, l10n.october, l10n.november, l10n.december];
    final weekdays = [l10n.monday, l10n.tuesday, l10n.wednesday, l10n.thursday, l10n.friday, l10n.saturday, l10n.sunday];
    
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

  Widget _buildStreakCard(BuildContext context, int streak) {
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
                '$streak ${streak == 1 ? AppLocalizations.of(context)!.day : AppLocalizations.of(context)!.days}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.warningColor,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.dailyStreak,
                style: const TextStyle(
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
    final categoryName = _getCategoryTitle(context, challenge.level.category);
    
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
            _getLevelDescription(context, challenge.level),
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
                  challenge.level.sortOrder == SortOrder.ascending ? AppLocalizations.of(context)!.asc : AppLocalizations.of(context)!.desc,
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
                    '${AppLocalizations.of(context)!.best}: ${_formatTime(challenge.bestTimeMs!)}',
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
                    challenge.isCompletedToday ? AppLocalizations.of(context)!.playAgain : AppLocalizations.of(context)!.startChallenge,
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

  Widget _buildCompletedBadge(BuildContext context, DailyChallengeState challenge) {
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
                    Text(
                      AppLocalizations.of(context)!.completedToday,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.successColor,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.comeBackTomorrow,
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
      ],
    );
  }

  Widget _buildFixedShareButton(DailyChallengeState challenge) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.share_rounded, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Text(
                '${AppLocalizations.of(context)!.shareResult} 🎯',
                style: const TextStyle(
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

  String _getCategoryTitle(BuildContext context, LevelCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case LevelCategory.basic:
        return l10n.basicNumbers;
      case LevelCategory.formatted:
        return l10n.formattedNumbers;
      case LevelCategory.time:
        return l10n.timeFormats;
      case LevelCategory.names:
        return l10n.nameSorting;
      case LevelCategory.mixed:
        return l10n.mixedFormats;
      case LevelCategory.knowledge:
        return l10n.knowledge;
    }
  }

  String _getLevelDescription(BuildContext context, Level level) {
    final l10n = AppLocalizations.of(context)!;
    final count = level.items.length.toString();
    final direction = level.sortOrder == SortOrder.ascending ? l10n.asc : l10n.desc;
    
    String type;
    switch (level.category) {
      case LevelCategory.basic:
      case LevelCategory.formatted:
      case LevelCategory.mixed:
        type = l10n.numbers;
        break;
      case LevelCategory.time:
        type = l10n.times;
        break;
      case LevelCategory.names:
        type = l10n.names;
        break;
      case LevelCategory.knowledge:
        return level.description; // Keep original for knowledge levels
    }
    
    return l10n.sortXItems(count, type, direction);
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
