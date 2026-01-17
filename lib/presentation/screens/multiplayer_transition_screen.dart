import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../providers/multiplayer_provider.dart';

class MultiplayerTransitionScreen extends ConsumerStatefulWidget {
  const MultiplayerTransitionScreen({super.key});

  @override
  ConsumerState<MultiplayerTransitionScreen> createState() => _MultiplayerTransitionScreenState();
}

class _MultiplayerTransitionScreenState extends ConsumerState<MultiplayerTransitionScreen>
    with SingleTickerProviderStateMixin {
  int _countdown = 3;
  bool _showCountdown = false;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() { _showCountdown = true; _countdown = 3; });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        context.go('/multiplayer/game');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(multiplayerSessionProvider);
    if (session == null) {
      return const Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        body: Center(child: Text('No session', style: TextStyle(color: Colors.white))),
      );
    }

    final currentPlayer = session.currentPlayer;
    final playerIndex = session.currentPlayerIndex;
    final playerColor = _getPlayerColor(playerIndex);

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      color: playerColor,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: playerColor.withOpacity(0.4), blurRadius: 20, spreadRadius: 5)],
                    ),
                    child: Center(
                      child: Text('${playerIndex + 1}', style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(currentPlayer.name, style: TextStyle(color: playerColor, fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(AppLocalizations.of(context)!.yourTurn, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  session.isMemoryMode 
                      ? '✨ ${AppLocalizations.of(context)!.memoryMode} • ${session.itemCount} ${AppLocalizations.of(context)!.items}' 
                      : '${session.itemCount} ${AppLocalizations.of(context)!.items}',
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 48),
                if (_showCountdown)
                  TweenAnimationBuilder<double>(
                    key: ValueKey(_countdown),
                    tween: Tween(begin: 1.5, end: 1.0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Text(
                          _countdown > 0 ? '$_countdown' : AppLocalizations.of(context)!.go,
                          style: TextStyle(color: _countdown > 0 ? AppTheme.primaryColor : AppTheme.successColor, fontSize: 80, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  )
                else
                  GestureDetector(
                    onTap: _startCountdown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.touch_app, color: Colors.white, size: 28),
                          const SizedBox(width: 12),
                          Text(AppLocalizations.of(context)!.tapToStart, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 48),
                Text('${AppLocalizations.of(context)!.players} ${playerIndex + 1} / ${session.players.length}', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getPlayerColor(int index) {
    const colors = [Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFFFF9800), Color(0xFF9C27B0)];
    return colors[index % colors.length];
  }
}
