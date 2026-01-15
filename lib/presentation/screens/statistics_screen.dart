import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/datasources/local_database.dart';
import '../../domain/entities/level.dart';
import '../providers/game_providers.dart';
import '../../core/constants/app_constants.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameStats = LocalDatabase.instance.getStats();
    final progressBox = LocalDatabase.instance.progressBox;
    final allProgress = progressBox.values.toList();
    final levelGenerator = ref.read(levelGeneratorProvider);
    
    // Calculate stats
    int totalCompleted = 0;
    int totalAttempts = 0;
    final categoryStats = <LevelCategory, CategoryStat>{};
    
    for (final progress in allProgress) {
      if (progress.completed) {
        totalCompleted++;
        
        // Skip daily challenge levels (IDs > 1000 are date-based)
        // They don't exist in the level generator
        if (progress.levelId > 1000) continue;
        
        try {
          final level = levelGenerator.getLevel(progress.levelId);
          
          // Update category stats
          if (!categoryStats.containsKey(level.category)) {
            categoryStats[level.category] = CategoryStat();
          }
          categoryStats[level.category]!.completed++;
          if (progress.bestTimeMs != null) {
            categoryStats[level.category]!.totalTimeMs += progress.bestTimeMs!;
          }
        } catch (e) {
          // Skip levels that don't exist in generator
        }
      }
      totalAttempts += progress.attempts;
    }
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overall Stats Cards
                      _buildOverallStats(
                        completed: totalCompleted,
                        streak: gameStats.currentStreak,
                        longestStreak: gameStats.longestStreak,
                        totalTime: gameStats.totalPlayTimeFormatted,
                        totalAttempts: totalAttempts,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Category Breakdown
                      _buildSectionTitle('Category Progress'),
                      const SizedBox(height: 12),
                      _buildCategoryBreakdown(categoryStats),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverallStats({
    required int completed,
    required int streak,
    required int longestStreak,
    required String totalTime,
    required int totalAttempts,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                emoji: '✅',
                value: '$completed',
                label: 'Completed',
                color: AppTheme.successColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                emoji: '🔥',
                value: '$streak',
                label: 'Current Streak',
                color: AppTheme.warningColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                emoji: '⏱️',
                value: totalTime,
                label: 'Total Time',
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                emoji: '🎮',
                value: '$totalAttempts',
                label: 'Total Plays',
                color: AppTheme.accentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildStatCard(
          emoji: '🏆',
          value: '$longestStreak days',
          label: 'Longest Streak',
          color: const Color(0xFFFFD700),
          fullWidth: true,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String emoji,
    required String value,
    required String label,
    required Color color,
    bool fullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildCategoryBreakdown(Map<LevelCategory, CategoryStat> stats) {
    final categories = [
      (LevelCategory.basic, 'Basic Numbers', AppConstants.basicNumbersEnd - AppConstants.basicNumbersStart + 1, AppTheme.basicColor),
      (LevelCategory.formatted, 'Formatted Numbers', AppConstants.formattedNumbersEnd - AppConstants.formattedNumbersStart + 1, AppTheme.formattedColor),
      (LevelCategory.time, 'Time & Dates', AppConstants.timeFormatsEnd - AppConstants.timeFormatsStart + 1, AppTheme.timeColor),
      (LevelCategory.names, 'Names', AppConstants.nameSortingEnd - AppConstants.nameSortingStart + 1, AppTheme.namesColor),
      (LevelCategory.mixed, 'Mixed', AppConstants.mixedFormatsEnd - AppConstants.mixedFormatsStart + 1, AppTheme.mixedColor),
      (LevelCategory.knowledge, 'Knowledge', AppConstants.knowledgeEnd - AppConstants.knowledgeStart + 1, AppTheme.knowledgeColor),
    ];

    return Column(
      children: categories.map((cat) {
        final stat = stats[cat.$1];
        final completed = stat?.completed ?? 0;
        final total = cat.$3;
        final progress = total > 0 ? completed / total : 0.0;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildCategoryCard(
            name: cat.$2,
            completed: completed,
            total: total,
            progress: progress,
            color: cat.$4,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required int completed,
    required int total,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '$completed / $total',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toInt()}% complete',
            style: TextStyle(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper class for category statistics
class CategoryStat {
  int completed = 0;
  int totalTimeMs = 0;
}
