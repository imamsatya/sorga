import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/level.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import '../providers/game_providers.dart';
import '../providers/game_state_provider.dart';
import '../providers/daily_challenge_provider.dart';
import '../widgets/game_button.dart';
import '../../l10n/app_localizations.dart';
import 'game_screen.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  final GlobalKey _globalKey = GlobalKey();
  late ConfettiController _confettiController;
  
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    
    // Trigger confetti on success after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameState = ref.read(gameStateProvider);
      if (gameState?.isCorrect == true) {
        _confettiController.play();
      }
    });
  }
  
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _captureAndShare() async {
    try {
      final boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final xFile = XFile.fromData(
        pngBytes,
        mimeType: 'image/png',
        name: 'sorga_achievement.png',
      );

      await Share.shareXFiles(
        [xFile],
        text: 'I just completed this level in Sorga! Can you beat my time?',
      );
    } catch (e) {
      debugPrint('Error sharing: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to share image')),
        );
      }
    }
  }

  /// Share Daily Challenge result as viral text format
  Future<void> _shareDailyChallenge() async {
    final gameState = ref.read(gameStateProvider);
    if (gameState == null) return;

    final dailyState = ref.read(dailyChallengeProvider);
    final streak = ref.read(dailyStreakProvider);
    
    // Format date
    final now = DateTime.now();
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateStr = '${now.day} ${monthNames[now.month - 1]} ${now.year}';
    
    // Format time
    final time = gameState.elapsedTime;
    final minutes = time.inMinutes.toString().padLeft(2, '0');
    final seconds = (time.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds = ((time.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    final timeStr = '$minutes:$seconds.$milliseconds';
    
    // Build share text
    final shareText = '''
🎯 Sorga Daily Challenge
📅 $dateStr

⏱️ $timeStr
🔥 $streak Day${streak == 1 ? '' : 's'} Streak!

Can you beat my time? 💪
#SorgaDaily #PuzzleGame
'''.trim();
    
    try {
      await Share.share(shareText);
    } catch (e) {
      debugPrint('Error sharing daily challenge: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to share')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    
    // Also redirect if game is running (not completed) - this happens during next level transition
    if (gameState == null || !gameState.isCompleted) {
       // Just return empty, navigation is likely happening or state is resetting
       // If no navigation happens, we might want to redirect, but for now just shrink
       return const SizedBox.shrink();
    }
    
    final isSuccess = gameState.isCorrect;
    final levelId = gameState.level.id;
    final hasNextLevel = levelId < AppConstants.totalLevels;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background + Main Content
          Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Scrollable content area - centered vertically
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 80),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceColor,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildResultIcon(isSuccess),
                                      const SizedBox(height: 16),
                                      _buildResultTitle(isSuccess),
                                      const SizedBox(height: 4),
                                      _buildResultSubtitle(isSuccess, gameState, levelId),
                                      if (isSuccess && gameState.level.fact != null) ...[
                                        const SizedBox(height: 16),
                                        _buildFactCard(gameState.level.fact!),
                                        const SizedBox(height: 16),
                                      ] else
                                        const SizedBox(height: 20),
                                      _buildTimeCard(gameState),
                                    ],
                                  ),
                                ),
                              ),
                              if (isSuccess) ...[
                                const SizedBox(height: 20),
                                TextButton.icon(
                                  // Use different share method for daily challenges
                                  onPressed: gameState.level.localId == 0 
                                      ? _shareDailyChallenge 
                                      : _captureAndShare,
                                  icon: const Icon(Icons.share_rounded, color: AppTheme.accentColor),
                                  label: Text(
                                    gameState.level.localId == 0 
                                        ? '${AppLocalizations.of(context)!.shareResult} 🎯' 
                                        : AppLocalizations.of(context)!.shareAchievement,
                                    style: const TextStyle(
                                      color: AppTheme.accentColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Fixed action buttons at bottom
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: _buildActionButtons(context, ref, isSuccess, hasNextLevel, levelId),
                  ),
                ],
              ),
            ),
          ),
          // Confetti Widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                AppTheme.primaryColor,
                AppTheme.secondaryColor,
                AppTheme.accentColor,
                AppTheme.successColor,
                Colors.yellow,
                Colors.orange,
                Colors.pink,
              ],
              numberOfParticles: 30,
              gravity: 0.2,
              emissionFrequency: 0.05,
              maxBlastForce: 20,
              minBlastForce: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultIcon(bool isSuccess) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: isSuccess
              ? [AppTheme.successColor, const Color(0xFF00D9A5)]
              : [AppTheme.errorColor, const Color(0xFFFF6B6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (isSuccess ? AppTheme.successColor : AppTheme.errorColor)
                .withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          isSuccess ? Icons.check_rounded : Icons.close_rounded,
          size: 56,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildResultTitle(bool isSuccess) {
    return Text(
      isSuccess ? AppLocalizations.of(context)!.perfect : AppLocalizations.of(context)!.tryAgain,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: isSuccess ? AppTheme.successColor : AppTheme.errorColor,
        letterSpacing: 4,
      ),
    );
  }

  Widget _buildResultSubtitle(bool isSuccess, GameState gameState, int levelId) {
    if (isSuccess) {
      final levelProgress = ref.watch(levelProgressProvider(levelId));
      final attempts = levelProgress.valueOrNull?.attempts ?? 1;
      final category = gameState.level.category;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getCategoryEmoji(category),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 6),
              Text(
                _getCategoryTitle(context, category),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getCategoryColor(category),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            gameState.level.localId == 0 
                ? '${AppLocalizations.of(context)!.dailyChallenge} ${AppLocalizations.of(context)!.completed}!' 
                : AppLocalizations.of(context)!.levelCompleted(gameState.level.localId.toString()),
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${AppLocalizations.of(context)!.attempt} #$attempts',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      );
    }
    
    // Show attempts remaining
    final attemptsRemaining = 2 - gameState.failedAttempts;
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.orderNotRight,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.textSecondary.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 8),
        if (gameState.canContinue)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lightbulb_outline, color: AppTheme.warningColor, size: 16),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.chancesLeft(attemptsRemaining.toString()),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.warningColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cancel_outlined, color: AppTheme.errorColor, size: 16),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.noMoreChances,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildFactCard(String fact) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.knowledgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.knowledgeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb, color: AppTheme.knowledgeColor, size: 28),
              SizedBox(width: 8),
              Text(
                'DID YOU KNOW?',
                style: TextStyle(
                  color: AppTheme.knowledgeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            fact,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(GameState gameState) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
          // Memory mode badge
          if (gameState.level.isMemory) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🧠', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 4),
                  Text(
                    'SORGAwy',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          
          Text(
            gameState.level.isMemory 
                ? 'TOTAL TIME' 
                : AppLocalizations.of(context)!.yourTime,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer, color: AppTheme.accentColor, size: 28),
              const SizedBox(width: 12),
              Text(
                gameState.level.isMemory
                    ? _formatTotalTime(gameState.memorizeTime + gameState.elapsedTime)
                    : gameState.formattedTime,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          
          // Memory mode: Show breakdown
          if (gameState.level.isMemory) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeBreakdown(
                  '🧠',
                  'Memorize',
                  gameState.formattedMemorizeTime,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppTheme.textMuted.withOpacity(0.3),
                ),
                _buildTimeBreakdown(
                  '🔀',
                  'Sort',
                  gameState.formattedTime,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
  
  String _formatTotalTime(Duration total) {
    final minutes = total.inMinutes.toString().padLeft(2, '0');
    final seconds = (total.inSeconds % 60).toString().padLeft(2, '0');
    final ms = ((total.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$ms';
  }
  
  Widget _buildTimeBreakdown(String emoji, String label, String time) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textMuted,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textSecondary,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    bool isSuccess,
    bool hasNextLevel,
    int currentLevelId,
  ) {
    final gameState = ref.watch(gameStateProvider);
    final canContinue = gameState?.canContinue ?? false;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          if (isSuccess && hasNextLevel) ...[
            // Next Level button
            GestureDetector(
              onTap: () {
                try {
                  final nextLevelId = currentLevelId + 1;
                  // Get next level info for navigation
                  final nextLevel = ref.read(levelRepositoryProvider).getLevel(nextLevelId);
                  // Preserve memory mode when going to next level
                  final memoryParam = (gameState?.level.isMemory ?? false) ? '?memory=true' : '';
                  context.go('/game/${nextLevel.category.name}/${nextLevel.localId}$memoryParam');
                } catch (e) {
                  // Fallback or end of game
                  context.go('/');
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.nextLevel.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ] else if (!isSuccess && canContinue) ...[
            // Continue (Resume) button
            GestureDetector(
              onTap: () {
                final gameState = ref.read(gameStateProvider);
                if (gameState != null) {
                  ref.read(gameStateProvider.notifier).continueGame();
                  // For daily challenges (localId == 0), use Navigator to bypass GoRouter issues
                  if (gameState.level.localId == 0) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          levelId: gameState.level.id,
                          isDailyChallenge: true,
                          dailyLevel: gameState.level,
                        ),
                      ),
                    );
                  } else {
                    // Preserve memory mode
                    final memoryParam = gameState.level.isMemory ? '?memory=true' : '';
                    context.go('/game/${gameState.level.category.name}/${gameState.level.localId}$memoryParam');
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.warningColor, Color(0xFFFFB347)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.warningColor.withValues(alpha: 0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.continueGame,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ] else if (!isSuccess) ...[
            // Failed - Retry Level
            OutlinedButton(
              onPressed: () {
                 final gameState = ref.read(gameStateProvider);
                 if (gameState != null) {
                   // For daily challenges (localId == 0), use Navigator instead of URL routing
                   if (gameState.level.localId == 0) {
                     ref.read(gameStateProvider.notifier).retryWithLevel(gameState.level);
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(
                         builder: (context) => GameScreen(
                           levelId: gameState.level.id,
                           isDailyChallenge: true,
                           dailyLevel: gameState.level,
                         ),
                       ),
                     );
                   } else {
                     ref.read(gameStateProvider.notifier).retry();
                     // Preserve memory mode
                     final memoryParam = gameState.level.isMemory ? '?memory=true' : '';
                     context.go('/game/${gameState.level.category.name}/${gameState.level.localId}$memoryParam');
                   }
                 }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh_rounded, color: AppTheme.textPrimary),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.retryLevel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          
          Row(
            children: [
              if (isSuccess || !canContinue)
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      if (gameState != null) {
                        // For daily challenges (localId == 0), use Navigator to bypass GoRouter issues
                        if (gameState.level.localId == 0) {
                          ref.read(gameStateProvider.notifier).retryWithLevel(gameState.level);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => GameScreen(
                                levelId: gameState.level.id,
                                isDailyChallenge: true,
                                dailyLevel: gameState.level,
                              ),
                            ),
                          );
                        } else {
                          ref.read(gameStateProvider.notifier).retry();
                          // Preserve memory mode
                          final memoryParam = gameState.level.isMemory ? '?memory=true' : '';
                          context.go('/game/${gameState.level.category.name}/${gameState.level.localId}$memoryParam');
                        }
                      }
                    },
                    icon: const Icon(Icons.refresh_rounded, color: AppTheme.textSecondary),
                    label: Text(
                      AppLocalizations.of(context)!.retry, 
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppTheme.surfaceColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              
              if (isSuccess || !canContinue)
                const SizedBox(width: 12),
                
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ref.read(gameStateProvider.notifier).endGame();
                    context.go('/');
                  },
                  icon: const Icon(Icons.home_rounded, color: AppTheme.textSecondary),
                  label: Text(
                    AppLocalizations.of(context)!.home, 
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.surfaceColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
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
}
