import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../providers/feedback_settings_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(gameStatsProvider);
    final feedbackSettings = ref.watch(feedbackSettingsProvider);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Settings Row at top
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  children: [
                    // Sound Toggle
                    GestureDetector(
                      onTap: () => ref.read(feedbackSettingsProvider.notifier).toggleSound(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          feedbackSettings.soundEnabled ? Icons.volume_up : Icons.volume_off,
                          color: feedbackSettings.soundEnabled ? AppTheme.accentColor : AppTheme.textMuted,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Haptic Toggle
                    GestureDetector(
                      onTap: () => ref.read(feedbackSettingsProvider.notifier).toggleHaptic(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          feedbackSettings.hapticEnabled ? Icons.vibration : Icons.phone_android,
                          color: feedbackSettings.hapticEnabled ? AppTheme.accentColor : AppTheme.textMuted,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Title Area
                    const Spacer(flex: 2),
                    _buildLogo(),
                    const SizedBox(height: 16),
                    _buildTitle(),
                    const SizedBox(height: 8),
                    _buildSubtitle(),
                    const Spacer(flex: 1),
                    
                    // Stats Card
                    statsAsync.when(
                      data: (stats) => _buildStatsCard(stats),
                      loading: () => const SizedBox(height: 100),
                      error: (_, __) => const SizedBox(height: 100),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    // Play Button
                    _buildPlayButton(context),
                    const SizedBox(height: 16),
                    
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          // Cyan glow (top/left - for up arrow)
          BoxShadow(
            color: AppTheme.accentColor.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 3,
            offset: const Offset(-5, -5),
          ),
          // Orange glow (bottom/right - for down arrow)
          BoxShadow(
            color: AppTheme.warningColor.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 3,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          'assets/icons/app_icon.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  
  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppTheme.accentColor, AppTheme.warningColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: const Text(
        'SORGA',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 8,
        ),
      ),
    );
  }
  
  Widget _buildSubtitle() {
    return Text(
      'Master the Art of Sorting',
      style: TextStyle(
        fontSize: 16,
        color: AppTheme.textSecondary.withOpacity(0.8),
        letterSpacing: 2,
      ),
    );
  }
  
  Widget _buildStatsCard(GameStats stats) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
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
                  'Done',
                  Icons.check_circle_outline,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: AppTheme.textMuted.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  '${stats.completionPercentage.toStringAsFixed(0)}%',
                  'Progress',
                  Icons.trending_up,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: AppTheme.textMuted.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _buildStatItem(
                  stats.formattedPlayTime,
                  'Time',
                  Icons.timer_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: stats.completionPercentage / 100,
              minHeight: 8,
              backgroundColor: AppTheme.backgroundDark,
              valueColor: const AlwaysStoppedAnimation(AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.accentColor, size: 24),
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
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlayButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/levels'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow_rounded, size: 32, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'PLAY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
