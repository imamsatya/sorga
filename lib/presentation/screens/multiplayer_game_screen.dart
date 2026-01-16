import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/level_item.dart';
import '../../core/theme/app_theme.dart';
import '../providers/multiplayer_provider.dart';

class MultiplayerGameScreen extends ConsumerStatefulWidget {
  const MultiplayerGameScreen({super.key});

  @override
  ConsumerState<MultiplayerGameScreen> createState() => _MultiplayerGameScreenState();
}

class _MultiplayerGameScreenState extends ConsumerState<MultiplayerGameScreen> {
  late List<LevelItem> _items;
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = '00:00.00';
  bool _isMemorizing = false;
  int _memorizeTimeMs = 0;
  Stopwatch? _memorizeStopwatch;
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _initializeGame();
  }

  void _initializeGame() {
    final session = ref.read(multiplayerSessionProvider);
    if (session == null) return;
    final notifier = ref.read(multiplayerSessionProvider.notifier);
    _items = notifier.getShuffledItemsForPlayer(session.currentPlayer.id);
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) => _updateTimer());
    if (session.isMemoryMode) {
      _isMemorizing = true;
      _memorizeStopwatch = Stopwatch()..start();
    }
  }

  void _updateTimer() {
    if (!mounted) return;
    final elapsed = _stopwatch.elapsed;
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds % 60;
    final centiseconds = (elapsed.inMilliseconds % 1000) ~/ 10;
    setState(() {
      _elapsedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  void _onMemorizeComplete() {
    setState(() {
      _isMemorizing = false;
      _memorizeTimeMs = _memorizeStopwatch?.elapsedMilliseconds ?? 0;
      _memorizeStopwatch?.stop();
    });
  }

  void _swapItems(int fromIndex, int toIndex) {
    if (_isMemorizing) return;
    setState(() {
      final item = _items.removeAt(fromIndex);
      _items.insert(toIndex, item);
    });
  }

  void _checkAnswer() {
    final session = ref.read(multiplayerSessionProvider);
    if (session == null) return;
    _attempts++;
    final isCorrect = _isCorrectOrder(session.level.sortOrder);
    if (isCorrect) {
      _stopwatch.stop();
      _timer.cancel();
      final totalTimeMs = _stopwatch.elapsedMilliseconds;
      final sortTimeMs = session.isMemoryMode ? totalTimeMs - _memorizeTimeMs : null;
      ref.read(multiplayerSessionProvider.notifier).submitResult(
        playerId: session.currentPlayer.id,
        timeMs: totalTimeMs,
        memorizeTimeMs: session.isMemoryMode ? _memorizeTimeMs : null,
        sortTimeMs: sortTimeMs,
        attempts: _attempts,
      );
      _navigateNext(session);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not quite right. Try again!'), duration: Duration(seconds: 1)),
      );
    }
  }

  bool _isCorrectOrder(SortOrder sortOrder) {
    for (int i = 0; i < _items.length - 1; i++) {
      if (sortOrder == SortOrder.ascending) {
        if (_items[i].sortValue > _items[i + 1].sortValue) return false;
      } else {
        if (_items[i].sortValue < _items[i + 1].sortValue) return false;
      }
    }
    return true;
  }

  void _navigateNext(session) {
    final isLastPlayer = session.currentPlayerIndex == session.players.length - 1;
    if (isLastPlayer) {
      context.go('/multiplayer/results');
    } else {
      ref.read(multiplayerSessionProvider.notifier).nextPlayer();
      context.go('/multiplayer/transition');
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(multiplayerSessionProvider);
    if (session == null) {
      return const Scaffold(backgroundColor: AppTheme.backgroundDark, body: Center(child: Text('No session', style: TextStyle(color: Colors.white))));
    }
    final currentPlayer = session.currentPlayer;
    final playerIndex = session.currentPlayerIndex;
    final playerColor = _getPlayerColor(playerIndex);
    final level = session.level;

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(currentPlayer.name, playerColor, level.sortOrder),
            Expanded(child: _isMemorizing ? _buildMemorizeView(level.sortOrder) : _buildSortingArea()),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String playerName, Color playerColor, SortOrder sortOrder) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.surfaceColor, border: Border(bottom: BorderSide(color: playerColor, width: 3))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: playerColor, borderRadius: BorderRadius.circular(16)),
            child: Text(playerName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: AppTheme.backgroundDark, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Icon(_isMemorizing ? Icons.visibility : Icons.timer, color: _isMemorizing ? Colors.amber : AppTheme.primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(_elapsedTime, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
            child: Text(sortOrder == SortOrder.ascending ? '↑ A→Z' : '↓ Z→A', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildMemorizeView(SortOrder sortOrder) {
    final sortedItems = List<LevelItem>.from(_items);
    sortedItems.sort((a, b) => sortOrder == SortOrder.ascending ? a.sortValue.compareTo(b.sortValue) : b.sortValue.compareTo(a.sortValue));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('✨ Memorize the Order!', style: TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Remember the correct sequence', style: TextStyle(color: AppTheme.textSecondary)),
        const SizedBox(height: 24),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _items.length <= 6 ? 3 : 4, childAspectRatio: 1.2, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemCount: sortedItems.length,
            itemBuilder: (context, index) => _buildCard(sortedItems[index], index, showNumber: true),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _onMemorizeComplete,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            child: const Text("I've Memorized!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildSortingArea() {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex--;
        _swapItems(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        return Padding(key: ValueKey(_items[index].id), padding: const EdgeInsets.only(bottom: 8), child: _buildDraggableCard(_items[index], index));
      },
    );
  }

  Widget _buildDraggableCard(LevelItem item, int index) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))),
      child: Row(
        children: [
          Container(
            width: 40,
            decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
            child: const Icon(Icons.drag_handle, color: AppTheme.textSecondary),
          ),
          Expanded(child: Center(child: Text(item.displayValue, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildCard(LevelItem item, int index, {bool showNumber = false}) {
    return Container(
      decoration: BoxDecoration(color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))),
      child: Stack(
        children: [
          Center(child: Text(item.displayValue, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14, fontWeight: FontWeight.bold))),
          if (showNumber)
            Positioned(
              top: 4, left: 4,
              child: Container(
                width: 20, height: 20,
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                final session = ref.read(multiplayerSessionProvider);
                if (session == null) return;
                setState(() { _items = ref.read(multiplayerSessionProvider.notifier).getShuffledItemsForPlayer(session.currentPlayer.id); });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: OutlinedButton.styleFrom(foregroundColor: AppTheme.textSecondary, side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3)), padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _isMemorizing ? null : _checkAnswer,
              icon: const Icon(Icons.check),
              label: const Text('Check'),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPlayerColor(int index) {
    const colors = [Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFFFF9800), Color(0xFF9C27B0)];
    return colors[index % colors.length];
  }
}
