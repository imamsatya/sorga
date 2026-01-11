import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
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
      onLongPress: isCompleted
          ? () => _showShareDialog(context, level, progress!, categoryColor)
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
                      if (isCompleted && progress?.bestTimeMs != null) ...[
                        Text(
                          progress!.bestTimeFormatted,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          '${progress.attempts}x',
                          style: TextStyle(
                            fontSize: 7,
                            color: categoryColor.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  void _showShareDialog(BuildContext context, Level level, dynamic progress, Color categoryColor) {
    final GlobalKey shareKey = GlobalKey();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textMuted,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            // Shareable content with RepaintBoundary
            RepaintBoundary(
              key: shareKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppTheme.backgroundGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App branding
                    const Text(
                      'SORGA',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: categoryColor.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_getCategoryEmoji(level.category), style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            level.category.displayName,
                            style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Level ${level.id}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Stats row
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('⏱️', progress.bestTimeFormatted, 'Best Time'),
                          Container(height: 40, width: 1, color: AppTheme.textMuted.withValues(alpha: 0.3)),
                          _buildStatColumn('🔄', '${progress.attempts}x', 'Attempts'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Can you beat my time?',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await _captureAndShare(shareKey, level, progress);
                      if (context.mounted) Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.share, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.textMuted.withValues(alpha: 0.3)),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _captureAndShare(GlobalKey key, Level level, dynamic progress) async {
    try {
      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final xFile = XFile.fromData(
        pngBytes,
        mimeType: 'image/png',
        name: 'sorga_level_${level.id}.png',
      );

      final message = '''🎮 Sorga - Level ${level.id} Completed!

📝 ${level.description}
⏱️ Best Time: ${progress.bestTimeFormatted}
🔄 Attempts: ${progress.attempts}x

Can you beat my time? Download Sorga now!''';

      await Share.shareXFiles(
        [xFile],
        text: message,
      );
    } catch (e) {
      debugPrint('Error sharing: $e');
    }
  }

  Widget _buildStatColumn(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
