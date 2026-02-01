import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/achievement.dart';

/// Shows an animated achievement unlock popup
class AchievementPopup extends StatefulWidget {
  final Achievement achievement;
  final VoidCallback onDismiss;

  const AchievementPopup({
    super.key,
    required this.achievement,
    required this.onDismiss,
  });

  @override
  State<AchievementPopup> createState() => _AchievementPopupState();
  
  /// Show the achievement popup as an overlay
  static void show(BuildContext context, Achievement achievement) {
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => AchievementPopup(
        achievement: achievement,
        onDismiss: () => overlayEntry.remove(),
      ),
    );
    
    Overlay.of(context).insert(overlayEntry);
  }
  
  /// Show multiple achievements sequentially
  static void showMultiple(BuildContext context, List<Achievement> achievements) {
    if (achievements.isEmpty) return;
    
    int index = 0;
    
    void showNext() {
      if (index >= achievements.length) return;
      
      late OverlayEntry overlayEntry;
      
      overlayEntry = OverlayEntry(
        builder: (context) => AchievementPopup(
          achievement: achievements[index],
          onDismiss: () {
            overlayEntry.remove();
            index++;
            Future.delayed(const Duration(milliseconds: 300), showNext);
          },
        ),
      );
      
      Overlay.of(context).insert(overlayEntry);
    }
    
    showNext();
  }
}

class _AchievementPopupState extends State<AchievementPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Tap to dismiss background
          Positioned.fill(
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Achievement card
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildAchievementCard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.achievement.color.withOpacity(0.9),
            widget.achievement.color.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: widget.achievement.color.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Emoji
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                widget.achievement.emoji,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🎉 Achievement Unlocked!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.achievement.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.achievement.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
