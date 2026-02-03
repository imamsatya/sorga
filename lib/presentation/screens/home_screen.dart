import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/pro_service.dart';
import '../../l10n/app_localizations.dart';
import '../providers/game_providers.dart';
import '../providers/feedback_settings_provider.dart';
import '../providers/game_stats_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(gameStatsProvider);
    final feedbackSettings = ref.watch(feedbackSettingsProvider);
    final gameStats = ref.watch(gameStatsNotifierProvider);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Streak Badge at top left (always visible)
              Positioned(
                top: 16,
                left: 16,
                child: _buildStreakBadge(gameStats.currentStreak),
              ),
              // Settings Row at top right (simplified)
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Sound Toggle
                    GestureDetector(
                      onTap: () => ref.read(feedbackSettingsProvider.notifier).toggleSound(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          feedbackSettings.soundEnabled ? Icons.volume_up : Icons.volume_off,
                          color: feedbackSettings.soundEnabled ? AppTheme.accentColor : AppTheme.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Haptic Toggle
                    GestureDetector(
                      onTap: () => ref.read(feedbackSettingsProvider.notifier).toggleHaptic(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          feedbackSettings.hapticEnabled ? Icons.vibration : Icons.phone_android,
                          color: feedbackSettings.hapticEnabled ? AppTheme.accentColor : AppTheme.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Pro Badge / Go Pro Button
                    GestureDetector(
                      onTap: () => context.push('/pro'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: ProService.instance.isPro
                              ? const LinearGradient(
                                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                                )
                              : null,
                          color: ProService.instance.isPro ? null : AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: ProService.instance.isPro
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ProService.instance.isPro ? '👑' : '✨',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              ProService.instance.isPro ? 'PRO' : 'Go Pro',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: ProService.instance.isPro ? Colors.white : AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Settings Button
                    GestureDetector(
                      onTap: () => context.push('/settings'),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.settings,
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate scale factor based on screen height
                  // standard height ~800, iPhone SE ~667
                  final double screenHeight = constraints.maxHeight;
                  final double scaleFactor = screenHeight < 700 ? 0.8 : 1.0;
                  
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo/Title Area
                        Spacer(flex: screenHeight < 700 ? 1 : 2),
                        _buildLogo(scaleFactor),
                        SizedBox(height: 16 * scaleFactor),
                        _buildTitle(scaleFactor),
                        SizedBox(height: 8 * scaleFactor),
                        _buildSubtitle(context, scaleFactor),
                        const Spacer(flex: 1),
                        
                        // Stats Card
                        statsAsync.when(
                          data: (stats) => _buildStatsCard(context, stats, scaleFactor),
                          loading: () => const SizedBox(height: 100),
                          error: (_, __) => const SizedBox(height: 100),
                        ),
                        
                        const Spacer(flex: 1),
                        
                        // Play Button
                        _buildPlayButton(context, scaleFactor),
                        SizedBox(height: 12 * scaleFactor),
                        
                        // Daily Challenge Button
                        _buildDailyChallengeButton(context, scaleFactor),
                        SizedBox(height: 12 * scaleFactor),
                        
                        // Multiplayer Button
                        _buildMultiplayerButton(context, scaleFactor),
                        
                        Spacer(flex: screenHeight < 700 ? 1 : 2),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogo(double scale) {
    return Container(
      width: 120 * scale,
      height: 120 * scale,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30 * scale),
        boxShadow: [
          // Cyan glow (top/left - for up arrow)
          BoxShadow(
            color: AppTheme.accentColor.withOpacity(0.4),
            blurRadius: 30 * scale,
            spreadRadius: 3 * scale,
            offset: Offset(-5 * scale, -5 * scale),
          ),
          // Orange glow (bottom/right - for down arrow)
          BoxShadow(
            color: AppTheme.warningColor.withOpacity(0.4),
            blurRadius: 30 * scale,
            spreadRadius: 3 * scale,
            offset: Offset(5 * scale, 5 * scale),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30 * scale),
        child: Image.asset(
          'assets/icons/app_icon.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  
  Widget _buildTitle(double scale) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppTheme.accentColor, AppTheme.warningColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        'SORTIQ',
        style: TextStyle(
          fontSize: 48 * scale,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 8 * scale,
        ),
      ),
    );
  }
  
  Widget _buildSubtitle(BuildContext context, double scale) {
    return Text(
      'How fast is your brain?',
      style: TextStyle(
        fontSize: 16 * scale,
        color: AppTheme.textSecondary.withOpacity(0.8),
        letterSpacing: 2 * scale,
      ),
    );
  }
  
  Widget _buildStatsCard(BuildContext context, GameStats stats, double scale) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40 * scale),
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildStatItem(
                  '${stats.completedLevels}',
                  l10n.done,
                  Icons.check_circle_outline,
                  scale,
                ),
              ),
              Container(
                height: 40 * scale,
                width: 1,
                color: AppTheme.textMuted.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  '${stats.completionPercentage.toStringAsFixed(0)}%',
                  l10n.progress,
                  Icons.trending_up,
                  scale,
                ),
              ),
              Container(
                height: 40 * scale,
                width: 1,
                color: AppTheme.textMuted.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  stats.formattedPlayTime,
                  l10n.time,
                  Icons.timer_outlined,
                  scale,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10 * scale),
            child: LinearProgressIndicator(
              value: stats.completionPercentage / 100,
              minHeight: 8 * scale,
              backgroundColor: AppTheme.backgroundDark,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primaryColor),
            ),
          ),
          SizedBox(height: 12 * scale),
          // Quick access links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => context.push('/statistics'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 8 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.bar_chart,
                        size: 16 * scale,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 6 * scale),
                      Text(
                        l10n.statistics,
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/achievements'),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 8 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.warningColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 16 * scale,
                        color: AppTheme.warningColor,
                      ),
                      SizedBox(width: 6 * scale),
                      Text(
                        l10n.achievements,
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label, IconData icon, double scale) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor, size: 24 * scale),
        SizedBox(height: 4 * scale),
        Text(
          value,
          style: TextStyle(
            fontSize: 18 * scale,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12 * scale,
            color: AppTheme.textSecondary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlayButton(BuildContext context, double scale) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push('/levels'),
        borderRadius: BorderRadius.circular(30 * scale),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 60 * scale, vertical: 20 * scale),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(30 * scale),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.4),
                blurRadius: 20 * scale,
                offset: Offset(0, 10 * scale),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow_rounded, size: 32 * scale, color: Colors.white),
              SizedBox(width: 8 * scale),
              Text(
                AppLocalizations.of(context)!.play.toUpperCase(),
                style: TextStyle(
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4 * scale,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakBadge(int streak) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.warningColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 6),
          Text(
            '$streak',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.warningColor,
            ),
          ),
          const SizedBox(width: 4),
          Builder(
            builder: (context) => Text(
              streak == 1 ? AppLocalizations.of(context)!.day : AppLocalizations.of(context)!.days,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.warningColor.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyChallengeButton(BuildContext context, double scale) {
    return GestureDetector(
      onTap: () => context.push('/daily'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24 * scale,
          vertical: 12 * scale,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: AppTheme.warningColor.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '📅',
              style: TextStyle(fontSize: 22 * scale),
            ),
            SizedBox(width: 10 * scale),
            Text(
              AppLocalizations.of(context)!.dailyChallenge,
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMultiplayerButton(BuildContext context, double scale) {
    return GestureDetector(
      onTap: () => context.push('/multiplayer/setup'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24 * scale,
          vertical: 12 * scale,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16 * scale),
          border: Border.all(
            color: const Color(0xFF9C27B0).withOpacity(0.5), // Purple
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '👥',
              style: TextStyle(fontSize: 22 * scale),
            ),
            SizedBox(width: 10 * scale),
            Text(
              AppLocalizations.of(context)!.multiplayer,
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
