import 'dart:io';
import 'lib/levels/level_generator.dart';

void main() {
  final generator = LevelGenerator();
  final levels = generator.generateAllLevels();
  
  final buffer = StringBuffer();
  buffer.writeln('Level ID,Category,Sort Order,Description,Items (Display),Items (Sort Value),Hint,Fact');
  
  for (final level in levels) {
    final displays = level.items.map((i) => i.displayValue).join(' | ');
    final sortVals = level.items.map((i) => i.sortValue.toString()).join(' | ');
    final hint = level.hint?.replaceAll('"', "'") ?? '';
    final fact = level.fact?.replaceAll('"', "'") ?? '';
    buffer.writeln('${level.id},${level.category.name},${level.sortOrder.name},"${level.description}","$displays","$sortVals","$hint","$fact"');
  }
  
  File('levels_export.csv').writeAsStringSync(buffer.toString());
  print('Exported ${levels.length} levels to levels_export.csv');
}
