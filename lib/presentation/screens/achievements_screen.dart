import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/achievement_service.dart';
import '../../domain/entities/achievement.dart';

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
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, unlockedCount, totalCount),
              Expanded(
                child: _buildAchievementGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context, int unlocked, int total) {
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
                const Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$unlocked / $total unlocked',
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
  
  Widget _buildAchievementGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75, // Taller cards to prevent overflow
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final item = _achievements[index];
        return _buildAchievementCard(item.achievement, item.unlocked);
      },
    );
  }
  
  Widget _buildAchievementCard(Achievement achievement, bool unlocked) {
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
            // Name
            Text(
              isHidden ? '???' : achievement.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: unlocked ? Colors.white : AppTheme.textMuted,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Description
            Text(
              isHidden ? 'Secret achievement' : achievement.description,
              style: TextStyle(
                fontSize: 11,
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
                unlocked ? '✓ Unlocked' : 'Locked',
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
