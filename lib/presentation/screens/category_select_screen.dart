import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/level.dart';
import '../../l10n/app_localizations.dart';
import '../providers/game_providers.dart';

class CategorySelectScreen extends ConsumerWidget {
  const CategorySelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 8),
              Expanded(
                child: _buildCategoryGrid(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary, size: 24),
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.chooseCategory,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, WidgetRef ref) {
    final categories = LevelCategory.values;
    
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Regular categories grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(context, ref, category);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Separator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.purple.withOpacity(0.3))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '✨',
                    style: TextStyle(fontSize: 16, color: Colors.purple[300]),
                  ),
                ),
                Expanded(child: Divider(color: Colors.purple.withOpacity(0.3))),
              ],
            ),
          ),
          
          // SORGAwy Section
          _buildSORGAwySection(context, ref),
          
          const SizedBox(height: 80), // Bottom padding
        ],
      ),
    );
  }
  
  Widget _buildSORGAwySection(BuildContext context, WidgetRef ref) {
    // Memory categories (exclude knowledge)
    const memoryCategories = [
      (LevelCategory.basic, '🔢'),
      (LevelCategory.formatted, '📐'),
      (LevelCategory.time, '⏱️'),
      (LevelCategory.names, '👥'),
      (LevelCategory.mixed, '🎲'),
    ];
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.purple.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header with branding
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('✨', style: TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SORGAwy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[300],
                    ),
                  ),
                  Text(
                    'SORGA with Memory',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Memory category cards grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: memoryCategories.length,
            itemBuilder: (context, index) {
              final cat = memoryCategories[index];
              return _buildMemoryCategoryCard(context, ref, cat.$1, cat.$2);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildMemoryCategoryCard(
    BuildContext context, 
    WidgetRef ref,
    LevelCategory category,
    String emoji,
  ) {
    // Check if unlocked (Level 30 completed in regular category)
    final allProgress = ref.watch(allProgressProvider);
    final levels = ref.watch(levelsByCategoryProvider(category));
    
    int completed = 0;
    allProgress.whenData((progressList) {
      final levelIds = levels.map((l) => l.id).toSet();
      for (final progress in progressList) {
        if (levelIds.contains(progress.levelId) && progress.completed) {
          completed++;
        }
      }
    });
    
    // DevMode: unlock all memory levels; Production: unlock when level 30 completed
    final bool isUnlocked = AppConstants.isDevMode || completed >= 30;
    final categoryInfo = _getCategoryInfo(category);
    
    return GestureDetector(
      onTap: () {
        if (isUnlocked) {
          // TODO: Navigate to memory level select
          context.go('/levels/${category.name}?memory=true');
        } else {
          // Show unlock tooltip
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Complete Level 30 in ${_getCategoryTitle(context, category)} to unlock',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.purple[700],
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isUnlocked ? LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.3),
              Colors.purple.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          color: isUnlocked ? null : AppTheme.surfaceColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked 
                ? Colors.purple.withOpacity(0.5)
                : AppTheme.textMuted.withOpacity(0.2),
            width: isUnlocked ? 2 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon (Emoji with sparkle overlay)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: (isUnlocked ? categoryInfo.color : Colors.grey).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(
                            fontSize: 22,
                            color: isUnlocked ? null : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Text('✨', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Title
                Text(
                  _getCategoryTitle(context, category),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? AppTheme.textPrimary : AppTheme.textMuted,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                // Level count
                Text(
                  '100 ${AppLocalizations.of(context)!.levels}',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppTheme.textSecondary.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                // Progress bar + counter (TODO: track memory level progress separately)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: 0.0, // TODO: Calculate from memory level progress
                          minHeight: 4,
                          backgroundColor: AppTheme.backgroundDark.withOpacity(0.5),
                          valueColor: AlwaysStoppedAnimation(categoryInfo.color),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '0/100', // TODO: Get from memory level progress
                        style: TextStyle(
                          fontSize: 9,
                          color: categoryInfo.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Lock overlay
            if (!isUnlocked)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.lock,
                    size: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, WidgetRef ref, LevelCategory category) {
    final categoryInfo = _getCategoryInfo(category);
    final levels = ref.watch(levelsByCategoryProvider(category));
    final allProgress = ref.watch(allProgressProvider);
    
    // Calculate completion for this category
    int completed = 0;
    allProgress.whenData((progressList) {
      final levelIds = levels.map((l) => l.id).toSet();
      for (final progress in progressList) {
        if (levelIds.contains(progress.levelId) && progress.completed) {
          completed++;
        }
      }
    });
    
    final progress = levels.isNotEmpty ? completed / levels.length : 0.0;
    
    return GestureDetector(
      onTap: () => context.go('/levels/${category.name}'),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              categoryInfo.color.withValues(alpha: 0.3),
              categoryInfo.color.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: categoryInfo.color.withValues(alpha: 0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: categoryInfo.color.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon (Emoji)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: categoryInfo.color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getCategoryEmoji(category),
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Title
            Text(
              _getCategoryTitle(context, category),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            // Level count
            Text(
              '${levels.length} ${AppLocalizations.of(context)!.levels}',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 8),
            // Progress bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: AppTheme.backgroundDark.withValues(alpha: 0.5),
                      valueColor: AlwaysStoppedAnimation(categoryInfo.color),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$completed/${levels.length}',
                    style: TextStyle(
                      fontSize: 10,
                      color: categoryInfo.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        return '✨';
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

  _CategoryInfo _getCategoryInfo(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return _CategoryInfo(
          color: AppTheme.basicColor,
        );
      case LevelCategory.formatted:
        return _CategoryInfo(
          color: AppTheme.formattedColor,
        );
      case LevelCategory.time:
        return _CategoryInfo(
          color: AppTheme.timeColor,
        );
      case LevelCategory.names:
        return _CategoryInfo(
          color: AppTheme.namesColor,
        );
      case LevelCategory.mixed:
        return _CategoryInfo(
          color: AppTheme.mixedColor,
        );
      case LevelCategory.knowledge:
        return _CategoryInfo(
          color: AppTheme.knowledgeColor,
        );
    }
  }
}

class _CategoryInfo {
  final Color color;
  
  _CategoryInfo({
    required this.color,
  });
}
