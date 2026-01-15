import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// Tutorial overlay for first-time users
class TutorialOverlay extends StatefulWidget {
  final VoidCallback onComplete;
  
  const TutorialOverlay({
    super.key,
    required this.onComplete,
  });

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  int _currentStep = 0;
  
  List<TutorialStep> _getSteps(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      TutorialStep(
        emoji: '👆',
        title: l10n.dragAndDrop,
        description: l10n.dragItemsDescription,
      ),
      TutorialStep(
        emoji: '🔄',
        title: l10n.shiftAndSwap,
        description: l10n.shiftAndSwapDescription,
      ),
      TutorialStep(
        emoji: '✅',
        title: l10n.checkAnswer,
        description: l10n.checkAnswerDescription,
      ),
    ];
  }

  void _nextStep(int stepsLength) {
    if (_currentStep < stepsLength - 1) {
      setState(() => _currentStep++);
    } else {
      widget.onComplete();
    }
  }

  void _skip() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps(context);
    final step = steps[_currentStep];
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      color: AppTheme.backgroundDark, // Fully opaque to hide game content
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    l10n.skip,
                    style: TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Emoji
              TweenAnimationBuilder<double>(
                key: ValueKey(_currentStep),
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.5 + (value * 0.5),
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        step.emoji,
                        style: const TextStyle(fontSize: 80),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Title
              TweenAnimationBuilder<double>(
                key: ValueKey('title_$_currentStep'),
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Text(
                        step.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Description
              TweenAnimationBuilder<double>(
                key: ValueKey('desc_$_currentStep'),
                duration: const Duration(milliseconds: 600),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Text(
                        step.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              
              const Spacer(flex: 2),
              
              // Progress dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(steps.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentStep == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentStep == index 
                          ? AppTheme.primaryColor 
                          : AppTheme.textMuted.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 32),
              
              // Next button
              GestureDetector(
                onTap: () => _nextStep(steps.length),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Text(
                    _currentStep == steps.length - 1 ? l10n.startPlaying : l10n.next,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Single tutorial step data
class TutorialStep {
  final String emoji;
  final String title;
  final String description;
  
  const TutorialStep({
    required this.emoji,
    required this.title,
    required this.description,
  });
}
