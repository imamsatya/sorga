import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/haptic_service.dart';
import '../../data/datasources/local_database.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/level_item.dart';
import '../providers/game_state_provider.dart';
import '../widgets/tutorial_overlay.dart';


enum DragMode { swap, shift }

class GameScreen extends ConsumerStatefulWidget {
  final int levelId;
  final bool isDailyChallenge;
  final Level? dailyLevel; // For daily challenge, pass the level directly
  
  const GameScreen({
    super.key, 
    required this.levelId,
    this.isDailyChallenge = false,
    this.dailyLevel,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  int? _draggedIndex;
  DragMode _dragMode = DragMode.shift; // Default to shift mode
  bool _showTutorial = false;
  bool _showResultFeedback = false;
  bool _isResultCorrect = false;
  
  // Services
  final AudioService _audioService = AudioService();
  final HapticService _hapticService = HapticService();
  
  // Confetti controller
  late ConfettiController _confettiController;
  
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    _audioService.init();
    
    // Check if user has seen tutorial
    final stats = LocalDatabase.instance.getStats();
    if (!stats.hasSeenTutorial) {
      _showTutorial = true;
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState = ref.read(gameStateProvider);
      // Start new game if:
      // - No existing state
      // - Different level
      // - Game was completed (not continuing)
      final shouldStartNewGame = currentState == null || 
          currentState.level.id != widget.levelId ||
          (currentState.isCompleted && !currentState.isRunning);
      
      if (shouldStartNewGame) {
        if (widget.isDailyChallenge && widget.dailyLevel != null) {
          // Use the provided level for daily challenge
          ref.read(gameStateProvider.notifier).startGameWithLevel(widget.dailyLevel!);
        } else {
          ref.read(gameStateProvider.notifier).startGame(widget.levelId);
        }
      }
    });
  }
  
  void _completeTutorial() {
    LocalDatabase.instance.markTutorialSeen();
    setState(() => _showTutorial = false);
  }
  
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    
    if (gameState == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
      );
    }
    
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppTheme.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(gameState),
                  _buildLevelInfo(gameState.level),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _buildSortableGrid(gameState),
                  ),
                  _buildModeToggle(),
                  const SizedBox(height: 8),
                  _buildBottomButtons(gameState),
                ],
              ),
            ),
          ),
          
          // Countdown Overlay - only show when tutorial is not active
          if (!gameState.isRunning && !gameState.isCompleted && !_showTutorial)
            _CountdownOverlay(
              onFinished: () {
                ref.read(gameStateProvider.notifier).startPlaying();
              },
            ),
            
          // Confetti Widget - positioned at top center
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
          
          // Tutorial Overlay (for first-time users)
          if (_showTutorial)
            TutorialOverlay(
              onComplete: _completeTutorial,
            ),
          
          // Result Feedback Overlay
          if (_showResultFeedback)
            Container(
              color: Colors.black54,
              child: Center(
                child: AnimatedScale(
                  scale: _showResultFeedback ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _isResultCorrect 
                              ? AppTheme.successColor 
                              : AppTheme.errorColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isResultCorrect ? Icons.check : Icons.close,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _isResultCorrect ? 'PERFECT!' : 'TRY AGAIN',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: _isResultCorrect 
                              ? AppTheme.successColor 
                              : AppTheme.errorColor,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildModeButton(DragMode.shift, 'Shift', Icons.swap_horiz),
          const SizedBox(width: 4),
          _buildModeButton(DragMode.swap, 'Swap', Icons.swap_calls),
        ],
      ),
    );
  }

  Widget _buildModeButton(DragMode mode, String label, IconData icon) {
    final isSelected = _dragMode == mode;
    return GestureDetector(
      onTap: () {
        _hapticService.selectionClick();
        setState(() => _dragMode = mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              size: 18, 
              color: isSelected ? Colors.white : AppTheme.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textMuted,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              ref.read(gameStateProvider.notifier).endGame();
              context.go('/levels/${gameState.level.category.name}');
            },
            icon: const Icon(Icons.close, color: AppTheme.textPrimary, size: 28),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: AppTheme.accentColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  gameState.formattedTime,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
            color: widget.isDailyChallenge 
                ? AppTheme.warningColor 
                : AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.isDailyChallenge 
                  ? '📅 Daily' 
                  : 'Level ${gameState.level.localId}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelInfo(Level level) {
    final categoryColor = _getCategoryColor(level.category);
    final isAscending = level.sortOrder == SortOrder.ascending;
    
    // Determine instruction text
    String instruction;
    if (level.category == LevelCategory.knowledge) {
      instruction = level.description; // Keep full description for knowledge
    } else if (level.category == LevelCategory.names) {
      instruction = 'Sort Names';
    } else {
      instruction = 'Sort Items';
    }
    
    // Determine sort label
    String sortLabel;
    if (level.category == LevelCategory.names || level.category == LevelCategory.knowledge) {
      sortLabel = isAscending ? 'A → Z' : 'Z → A';
    } else {
      sortLabel = isAscending ? 'Low → High' : 'High → Low';
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: categoryColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(level.category.icon, color: categoryColor, size: 24),
          ),
          const SizedBox(width: 12),
          
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  instruction,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (level.hint != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      level.hint!,
                      style: TextStyle(
                        color: AppTheme.textSecondary.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Sort Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isAscending 
                  ? AppTheme.successColor.withValues(alpha: 0.2)
                  : AppTheme.warningColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isAscending 
                    ? AppTheme.successColor.withValues(alpha: 0.5)
                    : AppTheme.warningColor.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                  color: isAscending ? AppTheme.successColor : AppTheme.warningColor,
                ),
                const SizedBox(width: 4),
                Text(
                  sortLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isAscending ? AppTheme.successColor : AppTheme.warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget _buildSortableGrid(GameState gameState) {
    final items = gameState.currentOrder;
    final categoryColor = _getCategoryColor(gameState.level.category);
    final totalItems = items.length;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // User requested max 5 items per row to make them larger
          const int crossAxisCount = 5;
          const double spacing = 8.0;
          
          // Calculate width based on available space and column count
          final double totalSpacing = (crossAxisCount - 1) * spacing;
          final double availableWidth = constraints.maxWidth;
          final double cardWidth = (availableWidth - totalSpacing) / crossAxisCount;
          
          // Dynamic height and font size
          final double cardHeight = cardWidth * 1.2; // 1.2 aspect ratio
          final double fontSize = cardWidth * 0.22; // Proportional font size
          
          return SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  alignment: WrapAlignment.center,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    return _buildDraggableCard(
                      item, 
                      index, 
                      categoryColor, 
                      cardWidth, 
                      cardHeight, 
                      fontSize,
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper moved inside or calculation is dynamic now
  // _getCardDimensions is deprecated by dynamic LayoutBuilder logic

  Widget _buildDraggableCard(
    LevelItem item, 
    int index, 
    Color categoryColor,
    double cardWidth,
    double cardHeight,
    double fontSize,
  ) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Draggable<int>(
        data: index,
        feedback: Material(
          color: Colors.transparent,
          child: Opacity(
            opacity: 0.9,
            child: _buildCard(item, index, categoryColor, cardWidth, cardHeight, fontSize, true),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: _buildCard(item, index, categoryColor, cardWidth, cardHeight, fontSize, false),
        ),
        onDragStarted: () {
          setState(() => _draggedIndex = index);
          _hapticService.lightTap();
          _audioService.playPop();
        },
        onDragEnd: (_) {
          setState(() => _draggedIndex = null);
        },
        child: DragTarget<int>(
          hitTestBehavior: HitTestBehavior.opaque,
          onWillAcceptWithDetails: (details) => details.data != index,
          onAcceptWithDetails: (details) {
            final fromIndex = details.data;
            _hapticService.mediumTap();
            _audioService.playPop();
            if (_dragMode == DragMode.swap) {
              ref.read(gameStateProvider.notifier).reorderItems(fromIndex, index);
            } else {
              ref.read(gameStateProvider.notifier).insertItem(fromIndex, index);
            }
          },
          builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;
            
            // Visual feedback based on mode
            BoxDecoration? decoration;
            Widget? overlay;
            
            if (isHovering) {
              if (_dragMode == DragMode.swap) {
                // Swap: Highlight entire card
                decoration = BoxDecoration(
                  border: Border.all(
                    color: AppTheme.accentColor, 
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.accentColor.withValues(alpha: 0.2),
                );
                overlay = const Center(
                  child: Icon(
                    Icons.swap_calls,
                    color: AppTheme.accentColor,
                    size: 32,
                  ),
                );
              } else {
                // Shift: Show insertion line (Cursor)
                decoration = BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: AppTheme.warningColor,
                      width: 4,
                    ),
                  ),
                );
              }
            }
            
            return Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  transform: isHovering && _dragMode == DragMode.swap
                      ? (Matrix4.identity()..scale(1.05))
                      : Matrix4.identity(),
                  foregroundDecoration: decoration,
                  child: _buildCard(
                    item, 
                    index, 
                    categoryColor, // Keep original color
                    cardWidth, 
                    cardHeight, 
                    fontSize, 
                    false,
                  ),
                ),
                if (overlay != null)
                  Positioned.fill(child: overlay),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(
    LevelItem item, 
    int index, 
    Color categoryColor, 
    double width, 
    double height, 
    double fontSize,
    bool isDragging,
  ) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.surfaceColor,
            AppTheme.surfaceColor.withValues(alpha: 0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDragging ? AppTheme.primaryColor : categoryColor.withValues(alpha: 0.5),
          width: isDragging ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDragging 
                ? AppTheme.primaryColor.withValues(alpha: 0.4)
                : Colors.black.withValues(alpha: 0.2),
            blurRadius: isDragging ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: categoryColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              item.displayValue,
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _hapticService.selectionClick();
                ref.read(gameStateProvider.notifier).retry();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.textMuted.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: AppTheme.textSecondary),
                    SizedBox(width: 8),
                    Text('Reset', style: TextStyle(color: AppTheme.textSecondary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                _hapticService.selectionClick();
                await ref.read(gameStateProvider.notifier).checkAnswer();
                final state = ref.read(gameStateProvider);
                final isCorrect = state?.isCorrect == true;
                
                if (isCorrect) {
                  _confettiController.play();
                  _audioService.playSuccess();
                  _hapticService.successVibrate();
                } else {
                  _audioService.playError();
                  _hapticService.errorVibrate();
                }
                
                // Show feedback overlay
                if (mounted) {
                  setState(() {
                    _showResultFeedback = true;
                    _isResultCorrect = isCorrect;
                  });
                  
                  // Wait for feedback to display, then navigate
                  await Future.delayed(const Duration(milliseconds: 800));
                  if (mounted) context.go('/result');
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Check', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownOverlay extends StatefulWidget {
  final VoidCallback onFinished;
  
  const _CountdownOverlay({required this.onFinished});

  @override
  State<_CountdownOverlay> createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<_CountdownOverlay> {
  int _count = 3;
  
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }
  
  void _startCountdown() async {
    for (int i = 3; i > 0; i--) {
      if (!mounted) return;
      setState(() => _count = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    if (mounted) {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundDark, // Opaque to hide questions
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Get Ready!',
              style: TextStyle(
                fontSize: 24,
                color: AppTheme.textPrimary.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
