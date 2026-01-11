import 'package:flutter_test/flutter_test.dart';
import 'package:sorga/levels/level_generator.dart';
import 'package:sorga/core/constants/app_constants.dart';
import 'package:sorga/domain/entities/level.dart';

void main() {
  test('Verify Global ID conversion logic', () {
    final generator = LevelGenerator();
    
    // Basic Category (Starts at 1)
    expect(generator.getGlobalId(LevelCategory.basic, 1), 1);
    expect(generator.getGlobalId(LevelCategory.basic, 107), 107);
    
    // Formatted Category (Starts at 108)
    expect(generator.getGlobalId(LevelCategory.formatted, 1), 108);
    expect(generator.getGlobalId(LevelCategory.formatted, 10), 117);
    expect(generator.getGlobalId(LevelCategory.formatted, 107), 214);
    
    // Time Category (Starts at 215)
    expect(generator.getGlobalId(LevelCategory.time, 1), 215);
    
    // Names Category (Starts at 322)
    expect(generator.getGlobalId(LevelCategory.names, 1), 322);
    
    // Mixed Category (Starts at 429)
    expect(generator.getGlobalId(LevelCategory.mixed, 1), 429);
    
    // Knowledge Category (Starts at 536)
    expect(generator.getGlobalId(LevelCategory.knowledge, 1), 536);
  });
  
  test('Verify Level localId assignment', () {
    final generator = LevelGenerator();
    
    // Basic Level 1 -> Global 1 -> localId 1
    final basic1 = generator.getLevel(1);
    expect(basic1.localId, 1);
    expect(basic1.title, 'Level 1');
    expect(basic1.category, LevelCategory.basic);
    
    // Basic Level 50 -> Global 50 -> localId 50
    final basic50 = generator.getLevel(50);
    expect(basic50.localId, 50);
    expect(basic50.title, 'Level 50');

    // Formatted Level 1 -> Global 108 -> localId 1
    final formatted1 = generator.getLevel(108);
    expect(formatted1.localId, 1);
    expect(formatted1.title, 'Level 1');
    expect(formatted1.category, LevelCategory.formatted);
    
    // Mixed Level 10 -> Global 438 -> localId 10
    // Mixed start 429. 429 + 10 - 1 = 438.
    final mixed10 = generator.getLevel(438);
    expect(mixed10.localId, 10);
    expect(mixed10.title, 'Level 10');
    expect(mixed10.category, LevelCategory.mixed);
  });
}
