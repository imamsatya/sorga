import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/level.dart';
import '../../l10n/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../providers/multiplayer_provider.dart';

/// Setup screen for local multiplayer mode
class MultiplayerSetupScreen extends ConsumerStatefulWidget {
  const MultiplayerSetupScreen({super.key});

  @override
  ConsumerState<MultiplayerSetupScreen> createState() => _MultiplayerSetupScreenState();
}

class _MultiplayerSetupScreenState extends ConsumerState<MultiplayerSetupScreen> {
  LevelCategory _selectedCategory = LevelCategory.basic;
  int _itemCount = 5;
  bool _isMemoryMode = false;
  int _playerCount = 2;
  final List<TextEditingController> _nameControllers = [];
  
  @override
  void initState() {
    super.initState();
    _updateNameControllers();
  }
  
  @override
  void dispose() {
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }
  
  void _updateNameControllers() {
    while (_nameControllers.length < _playerCount) {
      _nameControllers.add(TextEditingController(
        text: 'Player ${_nameControllers.length + 1}',
      ));
    }
    while (_nameControllers.length > _playerCount) {
      _nameControllers.removeLast().dispose();
    }
  }
  
  void _startGame() {
    final playerNames = _nameControllers.map((c) => c.text.trim()).toList();
    
    if (playerNames.any((name) => name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all player names')),
      );
      return;
    }
    
    ref.read(multiplayerSessionProvider.notifier).startSession(
      itemCount: _itemCount,
      category: _selectedCategory,
      isMemoryMode: _isMemoryMode,
      playerNames: playerNames,
    );
    
    context.go('/multiplayer/transition');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Multiplayer', style: TextStyle(color: AppTheme.textPrimary)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Category'),
              const SizedBox(height: 8),
              _buildCategorySelector(),
              const SizedBox(height: 24),
              _buildSectionTitle('Items: $_itemCount'),
              const SizedBox(height: 8),
              _buildItemCountSlider(),
              const SizedBox(height: 24),
              _buildMemoryModeToggle(),
              const SizedBox(height: 24),
              _buildSectionTitle('Players'),
              const SizedBox(height: 8),
              _buildPlayerCountSelector(),
              const SizedBox(height: 24),
              _buildSectionTitle('Player Names'),
              const SizedBox(height: 8),
              ..._buildPlayerNameInputs(),
              const SizedBox(height: 32),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildCategorySelector() {
    final categories = [
      LevelCategory.basic, LevelCategory.formatted, LevelCategory.time,
      LevelCategory.names, LevelCategory.mixed,
    ];
    final categoryNames = {
      LevelCategory.basic: 'Numbers', LevelCategory.formatted: 'Formatted',
      LevelCategory.time: 'Time', LevelCategory.names: 'Names', LevelCategory.mixed: 'Mixed',
    };
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = category),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.3),
              ),
            ),
            child: Text(
              categoryNames[category] ?? category.name,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildItemCountSlider() {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.primaryColor,
            inactiveTrackColor: AppTheme.surfaceColor,
            thumbColor: AppTheme.primaryColor,
            overlayColor: AppTheme.primaryColor.withOpacity(0.2),
          ),
          child: Slider(
            value: _itemCount.toDouble(),
            min: 3,
            max: 30,
            divisions: 27,
            label: _itemCount.toString(),
            onChanged: (value) => setState(() => _itemCount = value.round()),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('3', style: TextStyle(color: AppTheme.textSecondary)),
            Text('30', style: TextStyle(color: AppTheme.textSecondary)),
          ],
        ),
      ],
    );
  }
  
  Widget _buildMemoryModeToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Text('✨', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Memory Mode', style: TextStyle(color: AppTheme.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Memorize first, then sort', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: _isMemoryMode,
            onChanged: (value) => setState(() => _isMemoryMode = value),
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPlayerCountSelector() {
    return Row(
      children: [2, 3, 4].map((count) {
        final isSelected = _playerCount == count;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() { _playerCount = count; _updateNameControllers(); }),
            child: Container(
              margin: EdgeInsets.only(right: count < 4 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.3)),
              ),
              child: Text(
                '$count Players',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  
  List<Widget> _buildPlayerNameInputs() {
    return List.generate(_playerCount, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: _nameControllers[index],
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            labelText: 'Player ${index + 1}',
            labelStyle: const TextStyle(color: AppTheme.textSecondary),
            prefixIcon: CircleAvatar(
              radius: 14,
              backgroundColor: _getPlayerColor(index),
              child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
            filled: true,
            fillColor: AppTheme.surfaceColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(0.3))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor)),
          ),
        ),
      );
    });
  }
  
  Color _getPlayerColor(int index) {
    const colors = [Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFFFF9800), Color(0xFF9C27B0)];
    return colors[index % colors.length];
  }
  
  Widget _buildStartButton() {
    return ElevatedButton(
      onPressed: _startGame,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow, size: 28),
          SizedBox(width: 8),
          Text('Start Game', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
