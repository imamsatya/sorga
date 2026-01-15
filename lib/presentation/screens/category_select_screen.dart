import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              const SizedBox(height: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary, size: 28),
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.chooseCategory,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, WidgetRef ref) {
    final categories = LevelCategory.values;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80),
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
              categoryInfo.title,
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
              '${levels.length} levels',
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
        return '🧠';
    }
  }

  _CategoryInfo _getCategoryInfo(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return _CategoryInfo(
          title: 'Basic Numbers',
          color: AppTheme.basicColor,
        );
      case LevelCategory.formatted:
        return _CategoryInfo(
          title: 'Formatted',
          color: AppTheme.formattedColor,
        );
      case LevelCategory.time:
        return _CategoryInfo(
          title: 'Time Formats',
          color: AppTheme.timeColor,
        );
      case LevelCategory.names:
        return _CategoryInfo(
          title: 'Name Sorting',
          color: AppTheme.namesColor,
        );
      case LevelCategory.mixed:
        return _CategoryInfo(
          title: 'Mixed Formats',
          color: AppTheme.mixedColor,
        );
      case LevelCategory.knowledge:
        return _CategoryInfo(
          title: 'Knowledge',
          color: AppTheme.knowledgeColor,
        );
    }
  }
}

class _CategoryInfo {
  final String title;
  final Color color;
  
  _CategoryInfo({
    required this.title,
    required this.color,
  });
}
