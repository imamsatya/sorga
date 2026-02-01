import 'dart:io';
import '../lib/levels/level_generator.dart';
import '../lib/domain/entities/level.dart';
import '../lib/core/constants/app_constants.dart';

void main() {
  final generator = LevelGenerator();
  final buffer = StringBuffer();
  
  // CSV Header
  buffer.writeln('Level ID,Category,Sort Order,Title,Description,Item Count,Items (Display),Items (Correct Order),Hint');
  
  // Generate all levels
  final totalLevels = AppConstants.totalLevels;
  print('Generating $totalLevels levels...');
  
  for (int i = 1; i <= totalLevels; i++) {
    try {
      final level = generator.getLevel(i);
      
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
      ].join(','));
      
      if (i % 100 == 0) {
        print('Generated $i levels...');
      }
    } catch (e) {
      print('Error generating level $i: $e');
    }
  }
  
  // Write to CSV file
  final file = File('levels_export.csv');
  file.writeAsStringSync(buffer.toString());
  print('\n✅ Exported to levels_export.csv');
  print('Open in Excel: File > Open > Select levels_export.csv');
}
