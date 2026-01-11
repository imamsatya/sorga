import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

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
  
  final List<TutorialStep> _steps = [
    const TutorialStep(
      emoji: '👆',
      title: 'Drag & Drop',
      description: 'Drag items to rearrange them in the correct order',
    ),
    const TutorialStep(
      emoji: '🔄',
      title: 'Shift & Swap',
      description: 'Use SHIFT mode to move items step by step, or SWAP to exchange positions',
    ),
    const TutorialStep(
      emoji: '✅',
      title: 'Check Answer',
      description: 'When ready, tap CHECK to verify your answer. Good luck!',
    ),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
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
    final step = _steps[_currentStep];
    
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
                    'Skip',
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
                children: List.generate(_steps.length, (index) {
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
                onTap: _nextStep,
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
                    _currentStep == _steps.length - 1 ? 'START PLAYING' : 'NEXT',
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
