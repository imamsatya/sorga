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
  
  /// Get localized achievement name
  String _getLocalizedName(AchievementType type, AppLocalizations l10n) {
    return switch (type) {
      AchievementType.firstLevel => l10n.achFirstSteps,
      AchievementType.level10 => l10n.achGettingStarted,
      AchievementType.level50 => l10n.achOnARoll,
      AchievementType.level100 => l10n.achCenturyClub,
      AchievementType.level500 => l10n.achHalfwayThere,
      AchievementType.level600 => l10n.achSortingMaster,
      AchievementType.streak3 => l10n.achConsistent,
      AchievementType.streak7 => l10n.achWeekWarrior,
      AchievementType.streak30 => l10n.achMonthlyMaster,
      AchievementType.streak100 => l10n.achLegendaryStreak,
      AchievementType.speedDemon => l10n.achSpeedDemon,
      AchievementType.lightning => l10n.achLightningFast,
      AchievementType.basicMaster => l10n.achBasicExpert,
      AchievementType.formattedMaster => l10n.achFormatPro,
      AchievementType.timeMaster => l10n.achTimeLord,
      AchievementType.namesMaster => l10n.achAlphabetizer,
      AchievementType.mixedMaster => l10n.achMixMaster,
      AchievementType.knowledgeMaster => l10n.achKnowledgeKing,
      AchievementType.basicComplete => l10n.achBasicPerfectionist,
      AchievementType.formattedComplete => l10n.achFormatPerfectionist,
      AchievementType.timeComplete => l10n.achTimePerfectionist,
      AchievementType.namesComplete => l10n.achNamesPerfectionist,
      AchievementType.mixedComplete => l10n.achMixedPerfectionist,
      AchievementType.knowledgeComplete => l10n.achKnowledgePerfectionist,
      AchievementType.memoryBeginner => l10n.achMemoryNovice,
      AchievementType.memoryExpert => l10n.achMemoryExpert,
      AchievementType.memoryMaster => l10n.achMemoryMaster,
      AchievementType.memoryPerfect5 => l10n.achPerfectRecall,
      AchievementType.memoryPerfect10 => l10n.achMemoryPro,
      AchievementType.memoryPerfect25 => l10n.achMemoryGenius,
      AchievementType.memoryPerfect50 => l10n.achEideticMemory,
      AchievementType.memoryPerfect100 => l10n.achPhotographicMemory,
      AchievementType.memoryBasicComplete => l10n.achMemoryBasicMaster,
      AchievementType.memoryFormattedComplete => l10n.achMemoryFormatMaster,
      AchievementType.memoryTimeComplete => l10n.achMemoryTimeMaster,
      AchievementType.memoryNamesComplete => l10n.achMemoryNamesMaster,
      AchievementType.memoryMixedComplete => l10n.achMemoryMixedMaster,
      AchievementType.dailyFirst => l10n.achDailyStarter,
      AchievementType.dailyWeek => l10n.achWeeklyChallenger,
      AchievementType.dailyMonth => l10n.achMonthlyChallenger,
      AchievementType.daily100 => l10n.achDailyLegend,
      AchievementType.dailyPerfect5 => l10n.achPerfectDay,
      AchievementType.dailyPerfect10 => l10n.achPerfectWeek,
      AchievementType.dailyPerfect25 => l10n.achPerfectStreak,
      AchievementType.dailyPerfect50 => l10n.achFlawlessPlayer,
      AchievementType.dailyPerfect100 => l10n.achDailyPerfectionist,
      AchievementType.multiplayer10 => l10n.achPartyHost,
      AchievementType.multiplayer25 => l10n.achSocialGamer,
      AchievementType.multiplayer50 => l10n.achMultiplayerLegend,
      AchievementType.perfectRun => l10n.achPerfectRun,
      AchievementType.dedicated => l10n.achDedicatedPlayer,
      AchievementType.marathon => l10n.achMarathonRunner,
      AchievementType.totalMaster => l10n.achTotalMaster,
      AchievementType.completionist => l10n.achCompletionist,
      AchievementType.nightOwl => l10n.achNightOwl,
      AchievementType.earlyBird => l10n.achEarlyBird,
      AchievementType.newYear => l10n.achNewYearSorter,
      AchievementType.persistent => l10n.achNeverGiveUp,
      AchievementType.instantWin => l10n.achInstantWin,
      AchievementType.descendingFan => l10n.achDescendingFan,
      AchievementType.swapOnly => l10n.achSwapMaster,
      AchievementType.shiftOnly => l10n.achShiftMaster,
    };
  }
  
  /// Get localized achievement description
  String _getLocalizedDesc(AchievementType type, AppLocalizations l10n) {
    return switch (type) {
      AchievementType.firstLevel => l10n.achFirstStepsDesc,
      AchievementType.level10 => l10n.achGettingStartedDesc,
      AchievementType.level50 => l10n.achOnARollDesc,
      AchievementType.level100 => l10n.achCenturyClubDesc,
      AchievementType.level500 => l10n.achHalfwayThereDesc,
      AchievementType.level600 => l10n.achSortingMasterDesc,
      AchievementType.streak3 => l10n.achConsistentDesc,
      AchievementType.streak7 => l10n.achWeekWarriorDesc,
      AchievementType.streak30 => l10n.achMonthlyMasterDesc,
      AchievementType.streak100 => l10n.achLegendaryStreakDesc,
      AchievementType.speedDemon => l10n.achSpeedDemonDesc,
      AchievementType.lightning => l10n.achLightningFastDesc,
      AchievementType.basicMaster => l10n.achBasicExpertDesc,
      AchievementType.formattedMaster => l10n.achFormatProDesc,
      AchievementType.timeMaster => l10n.achTimeLordDesc,
      AchievementType.namesMaster => l10n.achAlphabetizerDesc,
      AchievementType.mixedMaster => l10n.achMixMasterDesc,
      AchievementType.knowledgeMaster => l10n.achKnowledgeKingDesc,
      AchievementType.basicComplete => l10n.achBasicPerfectionistDesc,
      AchievementType.formattedComplete => l10n.achFormatPerfectionistDesc,
      AchievementType.timeComplete => l10n.achTimePerfectionistDesc,
      AchievementType.namesComplete => l10n.achNamesPerfectionistDesc,
      AchievementType.mixedComplete => l10n.achMixedPerfectionistDesc,
      AchievementType.knowledgeComplete => l10n.achKnowledgePerfectionistDesc,
      AchievementType.memoryBeginner => l10n.achMemoryNoviceDesc,
      AchievementType.memoryExpert => l10n.achMemoryExpertDesc,
      AchievementType.memoryMaster => l10n.achMemoryMasterDesc,
      AchievementType.memoryPerfect5 => l10n.achPerfectRecallDesc,
      AchievementType.memoryPerfect10 => l10n.achMemoryProDesc,
      AchievementType.memoryPerfect25 => l10n.achMemoryGeniusDesc,
      AchievementType.memoryPerfect50 => l10n.achEideticMemoryDesc,
      AchievementType.memoryPerfect100 => l10n.achPhotographicMemoryDesc,
      AchievementType.memoryBasicComplete => l10n.achMemoryBasicMasterDesc,
      AchievementType.memoryFormattedComplete => l10n.achMemoryFormatMasterDesc,
      AchievementType.memoryTimeComplete => l10n.achMemoryTimeMasterDesc,
      AchievementType.memoryNamesComplete => l10n.achMemoryNamesMasterDesc,
      AchievementType.memoryMixedComplete => l10n.achMemoryMixedMasterDesc,
      AchievementType.dailyFirst => l10n.achDailyStarterDesc,
      AchievementType.dailyWeek => l10n.achWeeklyChallengerDesc,
      AchievementType.dailyMonth => l10n.achMonthlyChallengerDesc,
      AchievementType.daily100 => l10n.achDailyLegendDesc,
      AchievementType.dailyPerfect5 => l10n.achPerfectDayDesc,
      AchievementType.dailyPerfect10 => l10n.achPerfectWeekDesc,
      AchievementType.dailyPerfect25 => l10n.achPerfectStreakDesc,
      AchievementType.dailyPerfect50 => l10n.achFlawlessPlayerDesc,
      AchievementType.dailyPerfect100 => l10n.achDailyPerfectionistDesc,
      AchievementType.multiplayer10 => l10n.achPartyHostDesc,
      AchievementType.multiplayer25 => l10n.achSocialGamerDesc,
      AchievementType.multiplayer50 => l10n.achMultiplayerLegendDesc,
      AchievementType.perfectRun => l10n.achPerfectRunDesc,
      AchievementType.dedicated => l10n.achDedicatedPlayerDesc,
      AchievementType.marathon => l10n.achMarathonRunnerDesc,
      AchievementType.totalMaster => l10n.achTotalMasterDesc,
      AchievementType.completionist => l10n.achCompletionistDesc,
      AchievementType.nightOwl => l10n.achNightOwlDesc,
      AchievementType.earlyBird => l10n.achEarlyBirdDesc,
      AchievementType.newYear => l10n.achNewYearSorterDesc,
      AchievementType.persistent => l10n.achNeverGiveUpDesc,
      AchievementType.instantWin => l10n.achInstantWinDesc,
      AchievementType.descendingFan => l10n.achDescendingFanDesc,
      AchievementType.swapOnly => l10n.achSwapMasterDesc,
      AchievementType.shiftOnly => l10n.achShiftMasterDesc,
    };
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive columns: Phone 2, Tablet 3, Large 4
        int crossAxisCount = 2;
        if (constraints.maxWidth > 800) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 500) {
          crossAxisCount = 3;
        }
        
        return GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _achievements.length,
          itemBuilder: (context, index) {
            final item = _achievements[index];
            return _buildAchievementCard(item.achievement, item.unlocked, l10n);
          },
        );
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
              isHidden ? '???' : _getLocalizedName(achievement.type, l10n),
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
            // Description - allow 2 lines, no expand
            Text(
              isHidden ? l10n.secretAchievement : _getLocalizedDesc(achievement.type, l10n),
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
