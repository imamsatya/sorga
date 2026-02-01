import 'package:flutter_test/flutter_test.dart';
import 'package:sorga/levels/level_generator.dart';
import 'package:sorga/domain/entities/level.dart';

void main() {
  group('Level Verification Tests', () {
    late LevelGenerator generator;
    late List<Level> allLevels;

    setUpAll(() {
      generator = LevelGenerator();
      allLevels = generator.getAllLevels();
    });

    test('All 1000 levels exist', () {
      expect(allLevels.length, equals(1000));
    });

    test('All levels have at least 5 items', () {
      for (final level in allLevels) {
        expect(level.items.length, greaterThanOrEqualTo(5),
            reason: 'Level ${level.id} has ${level.items.length} items');
      }
    });

    test('All levels have valid sortOrder', () {
      for (final level in allLevels) {
        expect(
          level.sortOrder,
          anyOf(SortOrder.ascending, SortOrder.descending),
          reason: 'Level ${level.id} has invalid sortOrder',
        );
      }
    });

    test('All items have valid sortValue (not NaN or infinite)', () {
      for (final level in allLevels) {
        for (int i = 0; i < level.items.length; i++) {
          final item = level.items[i];
          expect(item.sortValue.isNaN, isFalse,
              reason: 'Level ${level.id} item $i has NaN sortValue');
          expect(item.sortValue.isInfinite, isFalse,
              reason: 'Level ${level.id} item $i has infinite sortValue');
        }
      }
    });

    test('CorrectOrder is properly sorted for all levels', () {
      int failedLevels = 0;
      List<String> errors = [];

      for (final level in allLevels) {
        final correctOrder = level.correctOrder;
        bool isValid = true;

        for (int i = 0; i < correctOrder.length - 1; i++) {
          final current = correctOrder[i].sortValue;
          final next = correctOrder[i + 1].sortValue;

          if (level.sortOrder == SortOrder.ascending) {
            if (current > next) {
              isValid = false;
              break;
            }
          } else {
            if (current < next) {
              isValid = false;
              break;
            }
          }
        }

        if (!isValid) {
          failedLevels++;
          if (errors.length < 10) {
            errors.add(
                'Level ${level.id}: ${level.sortOrder.name} - Values: ${correctOrder.map((e) => e.sortValue).join(", ")}');
          }
        }
      }

      if (errors.isNotEmpty) {
        print('Failed levels (first 10):');
        for (final err in errors) {
          print('  $err');
        }
      }

      expect(failedLevels, equals(0),
          reason: '$failedLevels levels have incorrectly sorted correctOrder');
    });

    test('All items have non-empty displayValue', () {
      for (final level in allLevels) {
        for (int i = 0; i < level.items.length; i++) {
          expect(level.items[i].displayValue.isNotEmpty, isTrue,
              reason: 'Level ${level.id} item $i has empty displayValue');
        }
      }
    });

    test('All levels have unique item IDs within each level', () {
      for (final level in allLevels) {
        final ids = level.items.map((e) => e.id).toSet();
        expect(ids.length, equals(level.items.length),
            reason: 'Level ${level.id} has duplicate item IDs');
      }
    });

    test('Category distribution is correct', () {
      final categories = <LevelCategory, int>{};
      for (final level in allLevels) {
        categories[level.category] = (categories[level.category] ?? 0) + 1;
      }

      print('Category distribution:');
      for (final entry in categories.entries) {
        print('  ${entry.key.name}: ${entry.value} levels');
      }

      // Basic: 1-60 (60 levels)
      expect(categories[LevelCategory.basic], equals(60));
      // Formatted: 61-250 (190 levels)
      expect(categories[LevelCategory.formatted], equals(190));
      // Time: 251-450 (200 levels)
      expect(categories[LevelCategory.time], equals(200));
      // Names: 451-650 (200 levels)
      expect(categories[LevelCategory.names], equals(200));
      // Mixed: 651-850 (200 levels)
      expect(categories[LevelCategory.mixed], equals(200));
      // Knowledge: 851-1000 (150 levels)
      expect(categories[LevelCategory.knowledge], equals(150));
    });

    test('Print sample levels from each category', () {
      print('\n--- SAMPLE LEVELS ---');
      
      final categoriesToCheck = [
        (LevelCategory.basic, [1, 31]),
        (LevelCategory.formatted, [61, 150]),
        (LevelCategory.time, [251, 350]),
        (LevelCategory.names, [451, 550]),
        (LevelCategory.mixed, [651, 750]),
        (LevelCategory.knowledge, [851, 950]),
      ];

      for (final (category, sampleIds) in categoriesToCheck) {
        print('\n${category.name.toUpperCase()}:');
        for (final id in sampleIds) {
          final level = generator.getLevel(id);
          print('  Level $id: ${level.description}');
          print('    Sort: ${level.sortOrder.name}');
          print('    Items: ${level.items.map((e) => e.displayValue).join(" | ")}');
          print('    Correct: ${level.correctOrder.map((e) => e.displayValue).join(" | ")}');
        }
      }
    });
  });
}
