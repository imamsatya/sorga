import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/level.dart';
import '../providers/game_providers.dart';

class LevelSelectScreen extends ConsumerWidget {
  final String categoryName;
  
  const LevelSelectScreen({super.key, required this.categoryName});

  LevelCategory get category {
    return LevelCategory.values.firstWhere(
      (c) => c.name == categoryName,
      orElse: () => LevelCategory.basic,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(levelsByCategoryProvider(category));
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, ref),
              Expanded(
                child: _buildLevelGrid(context, ref, levels),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final levels = ref.watch(levelsByCategoryProvider(category));
    final allProgress = ref.watch(allProgressProvider);
    
    int completed = 0;
    allProgress.whenData((progressList) {
      final levelIds = levels.map((l) => l.id).toSet();
      for (final progress in progressList) {
        if (levelIds.contains(progress.levelId) && progress.completed) {
          completed++;
        }
      }
    });
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => context.go('/levels'),
                icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _getCategoryEmoji(category),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category.displayName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completed / ${levels.length} completed',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48), // Balance
            ],
          ),
        ],
      ),
    );
  }

  String _getCategoryEmoji(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return '🔢';
      case LevelCategory.formatted:
        return '📐';
      case LevelCategory.time:
        return '⏰';
      case LevelCategory.names:
        return '👤';
      case LevelCategory.mixed:
        return '🎲';
      case LevelCategory.knowledge:
        return '🧠';
    }
  }

  Color _getCategoryColor(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return AppTheme.basicColor;
      case LevelCategory.formatted:
        return AppTheme.formattedColor;
      case LevelCategory.time:
        return AppTheme.timeColor;
      case LevelCategory.names:
        return AppTheme.namesColor;
      case LevelCategory.mixed:
        return AppTheme.mixedColor;
      case LevelCategory.knowledge:
        return AppTheme.knowledgeColor;
    }
  }

  Widget _buildLevelGrid(BuildContext context, WidgetRef ref, List<Level> levels) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        return _buildLevelCard(context, ref, levels[index]);
      },
    );
  }

  Widget _buildLevelCard(BuildContext context, WidgetRef ref, Level level) {
    final isUnlockedAsync = ref.watch(isLevelUnlockedProvider(level.id));
    final isUnlocked = AppConstants.isDevMode || (isUnlockedAsync.valueOrNull ?? false);
    final progressAsync = ref.watch(levelProgressProvider(level.id));
    final progress = progressAsync.valueOrNull;
    final isCompleted = progress?.completed ?? false;
    
    final categoryColor = _getCategoryColor(category);

    return GestureDetector(
      onTap: isUnlocked
          ? () => context.go('/game/${level.id}')
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: isUnlocked
              ? LinearGradient(
                  colors: [
                    categoryColor.withValues(alpha: isCompleted ? 0.4 : 0.2),
                    categoryColor.withValues(alpha: isCompleted ? 0.2 : 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isUnlocked ? null : AppTheme.surfaceColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCompleted
                ? categoryColor
                : (isUnlocked
                    ? categoryColor.withValues(alpha: 0.5)
                    : AppTheme.textMuted.withValues(alpha: 0.2)),
            width: isCompleted ? 2 : 1,
          ),
          boxShadow: isCompleted
              ? [
                  BoxShadow(
                    color: categoryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUnlocked)
                      const Icon(
                        Icons.lock,
                        color: AppTheme.textMuted,
                        size: 20,
                      )
                    else ...[
                      Text(
                        '${level.id}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isUnlocked ? Colors.white : AppTheme.textMuted,
                        ),
                      ),
                      if (isCompleted && progress?.bestTimeMs != null)
                        Text(
                          progress!.bestTimeFormatted,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            if (isCompleted)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
