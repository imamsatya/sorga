import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sorga/levels/level_generator.dart';

void main() {
  test('Export all levels to CSV', () {
    final generator = LevelGenerator();
    final levels = generator.getAllLevels();
    
    final buffer = StringBuffer();
    buffer.writeln('Level ID,Category,Sort Order,Description,Items (Display),Items (Sort Value),Hint,Fact');
    
    for (final level in levels) {
      final displays = level.items.map((i) => i.displayValue).join(' | ');
      final sortVals = level.items.map((i) => i.sortValue.toString()).join(' | ');
      final hint = (level.hint ?? '').replaceAll('"', "'").replaceAll('\n', ' ');
      final fact = (level.fact ?? '').replaceAll('"', "'").replaceAll('\n', ' ');
      buffer.writeln('${level.id},${level.category.name},${level.sortOrder.name},"${level.description}","$displays","$sortVals","$hint","$fact"');
    }
    
    File('levels_export.csv').writeAsStringSync(buffer.toString());
    print('✅ Exported ${levels.length} levels to levels_export.csv');
  });
}
