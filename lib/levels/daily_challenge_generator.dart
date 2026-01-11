import 'dart:math';
import '../domain/entities/level.dart';
import '../domain/entities/level_item.dart';

/// Generator for Daily Challenge levels using date-based seeding
/// This ensures all users worldwide get the same puzzle on the same day
class DailyChallengeGenerator {
  
  /// Generate today's challenge
  Level generateTodaysChallenge() {
    final now = DateTime.now();
    return generateChallengeForDate(now);
  }

  /// Generate challenge for a specific date
  Level generateChallengeForDate(DateTime date) {
    final seed = _getDateSeed(date);
    return _generateChallengeFromSeed(seed, date);
  }

  /// Seed format: YYYYMMDD as integer
  int _getDateSeed(DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }

  Level _generateChallengeFromSeed(int seed, DateTime date) {
    final random = Random(seed);
    
    // Randomly pick category (excluding knowledge - too specific)
    final categories = [
      LevelCategory.basic,
      LevelCategory.formatted,
      LevelCategory.time,
      LevelCategory.names,
      LevelCategory.mixed,
    ];
    final category = categories[random.nextInt(categories.length)];
    
    // Random difficulty (15-25 items for challenge - medium difficulty)
    final itemCount = 15 + random.nextInt(11);
    
    // Random sort order
    final sortOrder = random.nextBool() 
        ? SortOrder.ascending 
        : SortOrder.descending;
    
    // Generate items based on category
    final items = _generateItems(random, category, itemCount);
    
    // Format date for title
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateStr = '${months[date.month - 1]} ${date.day}, ${date.year}';
    
    return Level(
      id: seed,
      localId: 0,
      category: category,
      sortOrder: sortOrder,
      title: dateStr,
      description: 'Sort $itemCount ${_getCategoryName(category)} ${sortOrder.shortName}',
      items: items,
    );
  }

  String _getCategoryName(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return 'numbers';
      case LevelCategory.formatted:
        return 'values';
      case LevelCategory.time:
        return 'durations';
      case LevelCategory.names:
        return 'names';
      case LevelCategory.mixed:
        return 'items';
      case LevelCategory.knowledge:
        return 'items';
    }
  }

  List<LevelItem> _generateItems(Random random, LevelCategory category, int count) {
    switch (category) {
      case LevelCategory.basic:
        return _generateBasicItems(random, count);
      case LevelCategory.formatted:
        return _generateFormattedItems(random, count);
      case LevelCategory.time:
        return _generateTimeItems(random, count);
      case LevelCategory.names:
        return _generateNameItems(random, count);
      case LevelCategory.mixed:
        return _generateMixedItems(random, count);
      default:
        return _generateBasicItems(random, count);
    }
  }

  List<LevelItem> _generateBasicItems(Random random, int count) {
    final usedValues = <int>{};
    final items = <LevelItem>[];
    
    for (int i = 0; i < count; i++) {
      int value;
      do {
        value = random.nextInt(500) + 1;
      } while (usedValues.contains(value));
      usedValues.add(value);
      
      items.add(LevelItem(
        id: 'item_$i',
        displayValue: value.toString(),
        sortValue: value.toDouble(),
      ));
    }
    return items..shuffle(random);
  }

  List<LevelItem> _generateFormattedItems(Random random, int count) {
    final items = <LevelItem>[];
    final usedValues = <double>{};
    
    for (int i = 0; i < count; i++) {
      double sortValue;
      String display;
      
      do {
        final formatType = random.nextInt(3);
        switch (formatType) {
          case 0: // Fractions
            final num = random.nextInt(20) + 1;
            final den = random.nextInt(10) + 1;
            sortValue = num / den;
            display = '$num/$den';
            break;
          case 1: // Percentages
            final percent = random.nextInt(200) + 1;
            sortValue = percent / 100.0;
            display = '$percent%';
            break;
          default: // Decimals
            sortValue = (random.nextDouble() * 100).roundToDouble() / 10;
            display = sortValue.toStringAsFixed(1);
        }
      } while (usedValues.contains(sortValue));
      usedValues.add(sortValue);
      
      items.add(LevelItem(
        id: 'item_$i',
        displayValue: display,
        sortValue: sortValue,
      ));
    }
    return items..shuffle(random);
  }

  List<LevelItem> _generateTimeItems(Random random, int count) {
    final items = <LevelItem>[];
    final usedSeconds = <int>{};
    
    for (int i = 0; i < count; i++) {
      int seconds;
      String display;
      
      do {
        final unitType = random.nextInt(4);
        switch (unitType) {
          case 0:
            seconds = random.nextInt(120) + 1;
            display = '$seconds sec';
            break;
          case 1:
            final minutes = random.nextDouble() * 60;
            seconds = (minutes * 60).round();
            display = '${minutes.toStringAsFixed(1)} min';
            break;
          case 2:
            final hours = random.nextDouble() * 24;
            seconds = (hours * 3600).round();
            display = '${hours.toStringAsFixed(2)} hr';
            break;
          default:
            final days = random.nextDouble() * 7;
            seconds = (days * 86400).round();
            display = '${days.toStringAsFixed(2)} days';
        }
      } while (usedSeconds.contains(seconds));
      usedSeconds.add(seconds);
      
      items.add(LevelItem(
        id: 'item_$i',
        displayValue: display,
        sortValue: seconds.toDouble(),
      ));
    }
    return items..shuffle(random);
  }

  static const _commonNames = [
    'Alice', 'Bob', 'Charlie', 'Diana', 'Edward', 'Fiona', 'George', 'Hannah',
    'Isaac', 'Julia', 'Kevin', 'Laura', 'Michael', 'Nancy', 'Oliver', 'Patricia',
    'Quentin', 'Rachel', 'Samuel', 'Tina', 'Ulysses', 'Victoria', 'William', 'Xena',
    'Yusuf', 'Zara', 'Aaron', 'Bella', 'Caleb', 'Daisy', 'Ethan', 'Faith',
  ];

  List<LevelItem> _generateNameItems(Random random, int count) {
    final shuffledNames = List<String>.from(_commonNames)..shuffle(random);
    final selectedNames = shuffledNames.take(count).toList();
    final sortedReference = List<String>.from(selectedNames)..sort();
    
    final items = selectedNames.asMap().entries.map((entry) {
      final name = entry.value;
      final sortRank = sortedReference.indexOf(name).toDouble();
      return LevelItem(
        id: 'item_${entry.key}',
        displayValue: name,
        sortValue: sortRank,
      );
    }).toList();
    
    return items..shuffle(random);
  }

  List<LevelItem> _generateMixedItems(Random random, int count) {
    final items = <LevelItem>[];
    
    for (int i = 0; i < count; i++) {
      final formatType = random.nextInt(4);
      switch (formatType) {
        case 0:
          final value = random.nextInt(100) + 1;
          items.add(LevelItem(
            id: 'item_$i',
            displayValue: value.toString(),
            sortValue: value.toDouble(),
          ));
          break;
        case 1:
          final num = random.nextInt(20) + 1;
          final den = random.nextInt(10) + 1;
          items.add(LevelItem(
            id: 'item_$i',
            displayValue: '$num/$den',
            sortValue: num / den,
          ));
          break;
        case 2:
          final percent = random.nextInt(200) + 1;
          items.add(LevelItem(
            id: 'item_$i',
            displayValue: '$percent%',
            sortValue: percent / 100.0,
          ));
          break;
        default:
          final value = (random.nextDouble() * 100).roundToDouble() / 10;
          items.add(LevelItem(
            id: 'item_$i',
            displayValue: value.toStringAsFixed(1),
            sortValue: value,
          ));
      }
    }
    return items..shuffle(random);
  }
}
