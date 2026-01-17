import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/achievement_service.dart';
import '../../domain/entities/achievement.dart';
import '../../l10n/app_localizations.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  late List<({Achievement achievement, bool unlocked})> _achievements;
  
  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }
  
  void _loadAchievements() {
    _achievements = AchievementService.instance.getAllWithStatus();
  }
  
  @override
  Widget build(BuildContext context) {
    final unlockedCount = AchievementService.instance.unlockedCount;
    final totalCount = AchievementService.instance.totalCount;
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, unlockedCount, totalCount, l10n),
              Expanded(
                child: _buildAchievementGrid(l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context, int unlocked, int total, AppLocalizations l10n) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.achievements,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$unlocked / $total ${l10n.unlocked}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Trophy icon with count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text('🏆', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  '$unlocked',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAchievementGrid(AppLocalizations l10n) {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72, // Slightly taller to fit 2 lines
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final item = _achievements[index];
        return _buildAchievementCard(item.achievement, item.unlocked, l10n);
      },
    );
  }
  
  Widget _buildAchievementCard(Achievement achievement, bool unlocked, AppLocalizations l10n) {
    // For secret achievements that are not unlocked, show mystery card
    final isHidden = achievement.isSecret && !unlocked;
    
    return Container(
      decoration: BoxDecoration(
        color: unlocked 
            ? achievement.color.withOpacity(0.15)
            : AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked 
              ? achievement.color.withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Emoji/Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: unlocked 
                    ? achievement.color.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isHidden ? '❓' : achievement.emoji,
                  style: TextStyle(
                    fontSize: 24,
                    color: unlocked ? null : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Name - allow 2 lines
            Text(
              isHidden ? '???' : achievement.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: unlocked ? Colors.white : AppTheme.textMuted,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Description
            Text(
              isHidden ? l10n.secretAchievement : achievement.description,
              style: TextStyle(
                fontSize: 10,
                color: unlocked 
                    ? AppTheme.textSecondary 
                    : AppTheme.textMuted.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: unlocked 
                    ? AppTheme.successColor.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unlocked ? '✓ ${l10n.unlocked}' : l10n.locked,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: unlocked ? AppTheme.successColor : AppTheme.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
