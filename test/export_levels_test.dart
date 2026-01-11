import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sorga/levels/level_generator.dart';
import 'package:sorga/domain/entities/level.dart';

void main() {
  test('Export all levels to CSV', () {
    final generator = LevelGenerator();
    final levels = generator.getAllLevels();
    
    // CSV Header
    final buffer = StringBuffer();
    buffer.writeln('Level ID,Category,Sort Order,Title,Description,Item Count,Items (Display),Items (Correct Order),Hint,Fact');
    
    for (final level in levels) {
      // Get shuffled display items
      final displayItems = level.items.map((e) => e.displayValue).join(' | ');
      
      // Get correct order
      final correctOrder = level.correctOrder.map((e) => e.displayValue).join(' → ');
      
      // Escape quotes and commas for CSV
      String escape(String s) => '"${s.replaceAll('"', '""')}"';
      
      buffer.writeln([
        level.id,
        level.category.displayName,
        level.sortOrder.displayName,
        escape(level.title),
        escape(level.description),
        level.itemCount,
        escape(displayItems),
        escape(correctOrder),
        escape(level.hint ?? ''),
        escape(level.fact ?? ''),
      ].join(','));
    }
    
    final file = File('levels_export.csv');
    file.writeAsStringSync(buffer.toString());
    print('\n✅ Exported ${levels.length} levels to ${file.absolute.path}');
  });
}
