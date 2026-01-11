import 'package:flutter_test/flutter_test.dart';
import 'package:sorga/levels/level_generator.dart';
import 'package:sorga/core/constants/app_constants.dart';
import 'package:sorga/domain/entities/level.dart';

void main() {
  test('Verify item count progression rules', () {
    final generator = LevelGenerator();
    
    // Categories to check (Non-Knowledge)
    final categories = [
      LevelCategory.basic,
      LevelCategory.formatted,
      LevelCategory.time,
      LevelCategory.names,
      LevelCategory.mixed,
    ];

    for (final category in categories) {
      final levels = generator.getLevelsByCategory(category);
      print('\nChecking Category: ${category.name}, Total Levels: ${levels.length}');
      
      // Expected progression map: {itemCount: expectedLevelsCount}
      final itemCountMap = <int, int>{};
      
      for (final level in levels) {
        final count = level.itemCount;
        itemCountMap[count] = (itemCountMap[count] ?? 0) + 1;
      }
      
      // Verify Rules:
      
      // 1. Items 3-9: 1 level per item count
      for (int i = 3; i <= 9; i++) {
        expect(itemCountMap[i], 1, reason: 'Item count $i should appear exactly once in ${category.name}');
      }
      
      // 2. Items 10-19: 3 levels per item count
      for (int i = 10; i <= 19; i++) {
        expect(itemCountMap[i], 3, reason: 'Item count $i should appear 3 times in ${category.name}');
      }
      
      // 3. Items 20-29: 4 levels per item count
      for (int i = 20; i <= 29; i++) {
        expect(itemCountMap[i], 4, reason: 'Item count $i should appear 4 times in ${category.name}');
      }
      
      // 4. Items 30-35: 5 levels per item count
      for (int i = 30; i <= 35; i++) {
        expect(itemCountMap[i], 5, reason: 'Item count $i should appear 5 times in ${category.name}');
      }
      
      print('✅ ${category.name} passed all item count rules.');
    }
  });
}
