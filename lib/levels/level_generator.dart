import 'dart:math';
import '../domain/entities/level.dart';
import '../domain/entities/level_item.dart';
import '../core/constants/app_constants.dart';

/// Generator for all 1000 levels of Sorga
class LevelGenerator {
  /// Cache of generated levels
  final Map<int, Level> _levelCache = {};
  
  /// Cache of sort order patterns per category
  final Map<LevelCategory, List<SortOrder>> _sortOrderCache = {};
  
  /// Random generator with seed for reproducibility
  Random _getSeededRandom(int levelId) => Random(levelId * 12345);
  
  /// Get sort order for a level within its category (ensures max 3 consecutive same type)
  SortOrder _getSortOrder(LevelCategory category, int relativeId) {
    if (!_sortOrderCache.containsKey(category)) {
      _sortOrderCache[category] = _buildSortOrderPattern(category);
    }
    final patterns = _sortOrderCache[category]!;
    return patterns[relativeId % patterns.length];
  }
  
  /// Build unpredictable sort order pattern with max 3 consecutive same type
  List<SortOrder> _buildSortOrderPattern(LevelCategory category) {
    final (start, end) = _getCategoryRange(category);
    final count = end - start + 1;
    final random = Random(category.index * 999); // Seeded per category
    final pattern = <SortOrder>[];
    
    int consecutiveCount = 0;
    SortOrder? lastOrder;
    
    for (int i = 0; i < count; i++) {
      SortOrder order;
      
      if (consecutiveCount >= 3) {
        // Force switch after 3 consecutive
        order = lastOrder == SortOrder.ascending 
            ? SortOrder.descending 
            : SortOrder.ascending;
      } else {
        // 60% chance to switch, 40% chance to stay same
        final shouldSwitch = random.nextDouble() < 0.6;
        if (lastOrder == null) {
          order = random.nextBool() ? SortOrder.ascending : SortOrder.descending;
        } else {
          order = shouldSwitch 
              ? (lastOrder == SortOrder.ascending ? SortOrder.descending : SortOrder.ascending)
              : lastOrder;
        }
      }
      
      if (order == lastOrder) {
        consecutiveCount++;
      } else {
        consecutiveCount = 1;
      }
      
      lastOrder = order;
      pattern.add(order);
    }
    
    return pattern;
  }

  /// Get item count based on level progression (relativeId is 0-indexed)
  int _getItemCountForLevel(int relativeId) {
    // Level 1-7 (0-6): Items 3-9 (1 level each)
    if (relativeId < 7) {
      return 3 + relativeId;
    }
    
    // Level 8-37 (7-36): Items 10-19 (3 levels each)
    // 30 levels total
    if (relativeId < 37) {
      final step = (relativeId - 7) ~/ 3;
      return 10 + step;
    }
    
    // Level 38-77 (37-76): Items 20-29 (4 levels each)
    // 40 levels total
    if (relativeId < 77) {
      final step = (relativeId - 37) ~/ 4;
      return 20 + step;
    }
    
    // Level 78-107 (77-106): Items 30-35 (5 levels each)
    // 30 levels total
    final step = (relativeId - 77) ~/ 5;
    final count = 30 + step;
    return count.clamp(30, 35);
  }

  /// Get a level by ID
  Level getLevel(int levelId) {
    if (levelId < 1 || levelId > AppConstants.totalLevels) {
      throw ArgumentError('Level ID must be between 1 and ${AppConstants.totalLevels}');
    }
    
    return _levelCache.putIfAbsent(levelId, () => _generateLevel(levelId));
  }

  /// Generate all levels
  List<Level> getAllLevels() {
    return List.generate(
      AppConstants.totalLevels,
      (index) => getLevel(index + 1),
    );
  }

  /// Get levels by category
  List<Level> getLevelsByCategory(LevelCategory category) {
    final (start, end) = _getCategoryRange(category);
    return List.generate(
      end - start + 1,
      (index) => getLevel(start + index),
    );
  }

  /// Get category range
  (int, int) _getCategoryRange(LevelCategory category) {
    switch (category) {
      case LevelCategory.basic:
        return (AppConstants.basicNumbersStart, AppConstants.basicNumbersEnd);
      case LevelCategory.formatted:
        return (AppConstants.formattedNumbersStart, AppConstants.formattedNumbersEnd);
      case LevelCategory.time:
        return (AppConstants.timeFormatsStart, AppConstants.timeFormatsEnd);
      case LevelCategory.names:
        return (AppConstants.nameSortingStart, AppConstants.nameSortingEnd);
      case LevelCategory.mixed:
        return (AppConstants.mixedFormatsStart, AppConstants.mixedFormatsEnd);
      case LevelCategory.knowledge:
        return (AppConstants.knowledgeStart, AppConstants.knowledgeEnd);
    }
  }

  /// Get global level ID from category and local ID (1-based)
  int getGlobalId(LevelCategory category, int localId) {
    final (start, _) = _getCategoryRange(category);
    return start + localId - 1;
  }

  /// Determine category for a level ID
  LevelCategory _getCategoryForLevel(int levelId) {
    if (levelId <= AppConstants.basicNumbersEnd) return LevelCategory.basic;
    if (levelId <= AppConstants.formattedNumbersEnd) return LevelCategory.formatted;
    if (levelId <= AppConstants.timeFormatsEnd) return LevelCategory.time;
    if (levelId <= AppConstants.nameSortingEnd) return LevelCategory.names;
    if (levelId <= AppConstants.mixedFormatsEnd) return LevelCategory.mixed;
    return LevelCategory.knowledge;
  }

  /// Generate a specific level
  Level _generateLevel(int levelId) {
    final category = _getCategoryForLevel(levelId);
    
    switch (category) {
      case LevelCategory.basic:
        return _generateBasicLevel(levelId);
      case LevelCategory.formatted:
        return _generateFormattedLevel(levelId);
      case LevelCategory.time:
        return _generateTimeLevel(levelId);
      case LevelCategory.names:
        return _generateNamesLevel(levelId);
      case LevelCategory.mixed:
        return _generateMixedLevel(levelId);
      case LevelCategory.knowledge:
        return _generateKnowledgeLevel(levelId);
    }
  }

  // ==================== BASIC NUMBER LEVELS (1-60) ====================
  
  Level _generateBasicLevel(int levelId) {
    final random = _getSeededRandom(levelId);
    final relativeId = levelId - AppConstants.basicNumbersStart;
    
    // Unpredictable ASC/DESC pattern (max 3 consecutive same type)
    final sortOrder = _getSortOrder(LevelCategory.basic, relativeId);
    
    // Calculate item count based on progression
    final itemCount = _getItemCountForLevel(relativeId);
    
    // Generate random numbers
    final maxValue = 100 + (levelId * 5); // Increase range as levels progress
    final numbers = List.generate(
      itemCount,
      (_) => random.nextInt(maxValue) + 1,
    );
    
    final items = numbers.asMap().entries.map((entry) {
      return LevelItem(
        id: 'item_${entry.key}',
        displayValue: entry.value.toString(),
        sortValue: entry.value.toDouble(),
      );
    }).toList();
    
    // Shuffle items
    items.shuffle(random);
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.basic,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: 'Sort $itemCount numbers ${sortOrder.shortName}',
      items: items,
    );
  }

  // ==================== FORMATTED NUMBER LEVELS (61-180) ====================
  
  Level _generateFormattedLevel(int levelId) {
    final random = _getSeededRandom(levelId);
    final relativeId = levelId - AppConstants.formattedNumbersStart;
    
    // Unpredictable ASC/DESC pattern
    final sortOrder = _getSortOrder(LevelCategory.formatted, relativeId);
    
    // Calculate item count based on progression
    final itemCount = _getItemCountForLevel(relativeId);
    
    // Determine format type based on level range
    final formatType = (relativeId ~/ 40) % 3; // 0: fractions, 1: powers, 2: percentages
    
    final items = _generateFormattedItems(random, itemCount, formatType, levelId);
    items.shuffle(random);
    
    final formatName = ['fractions', 'powers', 'percentages'][formatType];
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.formatted,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: 'Sort $itemCount $formatName ${sortOrder.shortName}',
      items: items,
    );
  }

  List<LevelItem> _generateFormattedItems(Random random, int count, int formatType, int levelId) {
    final items = <LevelItem>[];
    final usedValues = <double>{};
    int attempts = 0;
    
    for (int i = 0; i < count; i++) {
      LevelItem item;
      int itemAttempts = 0;
      do {
        item = _generateSingleFormattedItem(random, formatType, i);
        itemAttempts++;
        // Safety break if we simply can't find a unique value after 50 tries
        if (itemAttempts > 50) break;
      } while (usedValues.contains(item.sortValue));
      
      // If we failed to find unique, just take the last generated one (duplicate)
      // Or in a real scenario, we might want to change strategy, but this prevents hang.
      usedValues.add(item.sortValue);
      items.add(item);
    }
    
    return items;
  }

  LevelItem _generateSingleFormattedItem(Random random, int formatType, int index) {
    switch (formatType) {
      case 0: // Fractions - Expanded range
        // Numerator 1-30, Denominator 1-15
        final numerator = random.nextInt(30) + 1;
        final denominator = random.nextInt(15) + 1;
        return LevelItem(
          id: 'item_$index',
          displayValue: '$numerator/$denominator',
          sortValue: numerator / denominator,
        );
      
      case 1: // Powers - Expanded range
        // Base 2-15
        final base = random.nextInt(14) + 2;
        // Power 1-4 (to keep numbers reasonable but increase combinations)
        final power = random.nextInt(4) + 1;
        final value = pow(base, power).toDouble();
        final superscript = _toSuperscript(power);
        return LevelItem(
          id: 'item_$index',
          displayValue: '$base$superscript',
          sortValue: value,
        );
      
      case 2: // Percentages
        final percent = random.nextInt(200) + 1;
        return LevelItem(
          id: 'item_$index',
          displayValue: '$percent%',
          sortValue: percent / 100.0,
        );
      
      default:
        return LevelItem(
          id: 'item_$index',
          displayValue: '${random.nextInt(100)}',
          sortValue: random.nextDouble() * 100,
        );
    }
  }

  String _toSuperscript(int number) {
    const superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];
    return number.toString().split('').map((d) => superscripts[int.parse(d)]).join();
  }

  // ==================== TIME FORMAT LEVELS (181-300) ====================
  
  Level _generateTimeLevel(int levelId) {
    final random = _getSeededRandom(levelId);
    final relativeId = levelId - AppConstants.timeFormatsStart;
    
    final sortOrder = _getSortOrder(LevelCategory.time, relativeId);
    
    final itemCount = _getItemCountForLevel(relativeId);
    final items = _generateTimeItems(random, itemCount);
    items.shuffle(random);
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.time,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: 'Sort $itemCount time durations ${sortOrder.shortName}',
      items: items,
    );
  }

  List<LevelItem> _generateTimeItems(Random random, int count) {
    final items = <LevelItem>[];
    final usedSeconds = <int>{};
    
    for (int i = 0; i < count; i++) {
      int seconds;
      String display;
      
      do {
        final unitType = random.nextInt(4); // 0: sec, 1: min, 2: hour, 3: day
        
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
          case 3:
            final days = random.nextDouble() * 7;
            seconds = (days * 86400).round();
            display = '${days.toStringAsFixed(2)} days';
            break;
          default:
            seconds = random.nextInt(1000);
            display = '$seconds sec';
        }
      } while (usedSeconds.contains(seconds));
      
      usedSeconds.add(seconds);
      items.add(LevelItem(
        id: 'item_$i',
        displayValue: display,
        sortValue: seconds.toDouble(),
      ));
    }
    
    return items;
  }

  // ==================== NAME SORTING LEVELS (301-500) ====================
  
  static const _commonNames = [
    'Alice', 'Bob', 'Charlie', 'Diana', 'Edward', 'Fiona', 'George', 'Hannah',
    'Isaac', 'Julia', 'Kevin', 'Laura', 'Michael', 'Nancy', 'Oliver', 'Patricia',
    'Quentin', 'Rachel', 'Samuel', 'Tina', 'Ulysses', 'Victoria', 'William', 'Xena',
    'Yusuf', 'Zara', 'Aaron', 'Bella', 'Caleb', 'Daisy', 'Ethan', 'Faith',
    'Gabriel', 'Holly', 'Ivan', 'Jade', 'Kyle', 'Luna', 'Mason', 'Nina',
    'Oscar', 'Piper', 'Quinn', 'Rose', 'Sean', 'Tara', 'Uma', 'Vincent',
    'Wendy', 'Xavier', 'Yvonne', 'Zach', 'Amelia', 'Benjamin', 'Charlotte', 'Daniel',
    'Emma', 'Felix', 'Grace', 'Henry', 'Isabella', 'Jack', 'Katherine', 'Liam',
    'Mia', 'Noah', 'Olivia', 'Parker', 'Queen', 'Riley', 'Sophia', 'Thomas',
    'Ursula', 'Victor', 'Willow', 'Xander', 'Yasmine', 'Zane',
    'Arthur', 'Betty', 'Chris', 'Donna', 'Eric', 'Fran', 'Gary', 'Helen',
    'Ian', 'Jane', 'Karl', 'Lisa', 'Mark', 'Nora', 'Otis', 'Paula',
    'Quincy', 'Ruth', 'Steve', 'Tessa', 'Ugo', 'Vera', 'Walt', 'Xenia',
    'Yuri', 'Zoe', 'Adam', 'Beth', 'Carl', 'Dara', 'Evan', 'Faye',
  ];

  Level _generateNamesLevel(int levelId) {
    final random = _getSeededRandom(levelId);
    final relativeId = levelId - AppConstants.nameSortingStart;
    
    final sortOrder = _getSortOrder(LevelCategory.names, relativeId);
    
    // Calculate item count based on progression
    final itemCount = _getItemCountForLevel(relativeId);
    final clampedCount = itemCount; // No clamp needed, logic handles it
    
    // Pick random unique names
    final shuffledNames = List<String>.from(_commonNames)..shuffle(random);
    final selectedNames = shuffledNames.take(clampedCount).toList();
    
    // Create a logical sorted list to assign correct ranks
    final sortedReference = List<String>.from(selectedNames)..sort();
    
    final items = selectedNames.asMap().entries.map((entry) {
      final name = entry.value;
      // Use the index in the sorted list as the sort value
      // This guarantees correct alphabetical ordering
      final sortRank = sortedReference.indexOf(name).toDouble();
      
      return LevelItem(
        id: 'item_${entry.key}',
        displayValue: name,
        sortValue: sortRank,
      );
    }).toList();
    
    items.shuffle(random);
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.names,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: 'Sort $clampedCount names alphabetically ${sortOrder.shortName}',
      items: items,
    );
  }

  // ==================== MIXED FORMAT LEVELS (501-700) ====================
  
  Level _generateMixedLevel(int levelId) {
    final random = _getSeededRandom(levelId);
    final relativeId = levelId - AppConstants.mixedFormatsStart;
    
    final sortOrder = _getSortOrder(LevelCategory.mixed, relativeId);
    
    final itemCount = _getItemCountForLevel(relativeId);
    final clampedCount = itemCount; // No clamp needed, logic handles it
    
    // Mix different formats
    final items = <LevelItem>[];
    for (int i = 0; i < clampedCount; i++) {
      final formatType = random.nextInt(4);
      items.add(_generateMixedItem(random, i, formatType));
    }
    
    items.shuffle(random);
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.mixed,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: 'Sort $clampedCount mixed values ${sortOrder.shortName}',
      items: items,
    );
  }

  LevelItem _generateMixedItem(Random random, int index, int formatType) {
    switch (formatType) {
      case 0: // Plain number
        final value = random.nextInt(100) + 1;
        return LevelItem(
          id: 'item_$index',
          displayValue: value.toString(),
          sortValue: value.toDouble(),
        );
      case 1: // Fraction
        final num = random.nextInt(20) + 1;
        final den = random.nextInt(10) + 1;
        return LevelItem(
          id: 'item_$index',
          displayValue: '$num/$den',
          sortValue: num / den,
        );
      case 2: // Percentage
        final percent = random.nextInt(200) + 1;
        return LevelItem(
          id: 'item_$index',
          displayValue: '$percent%',
          sortValue: percent / 100.0,
        );
      case 3: // Decimal
        final value = (random.nextDouble() * 100).roundToDouble() / 10;
        return LevelItem(
          id: 'item_$index',
          displayValue: value.toStringAsFixed(1),
          sortValue: value,
        );
      default:
        return LevelItem(
          id: 'item_$index',
          displayValue: '0',
          sortValue: 0,
        );
    }
  }

  // ==================== KNOWLEDGE LEVELS (701-1000) ====================
  
  Level _generateKnowledgeLevel(int levelId) {
    final relativeId = levelId - AppConstants.knowledgeStart;
    final knowledgeIndex = relativeId % _knowledgeData.length;
    final data = _knowledgeData[knowledgeIndex];
    
    final random = _getSeededRandom(levelId);
    
    // Alternate ascending/descending
    final sortOrder = _getSortOrder(LevelCategory.knowledge, relativeId);
    
    final items = data.items.asMap().entries.map((entry) {
      return LevelItem(
        id: 'item_${entry.key}',
        displayValue: entry.value.name,
        sortValue: entry.value.value,
      );
    }).toList();
    
    items.shuffle(random);
    
    return Level(
      id: levelId,
      localId: relativeId + 1,
      category: LevelCategory.knowledge,
      sortOrder: sortOrder,
      title: 'Level ${relativeId + 1}',
      description: '${data.description} ${sortOrder.shortName}',
      items: items,
      hint: data.hint,
      fact: data.fact,
    );
  }
}

// ==================== KNOWLEDGE DATA ====================

class _KnowledgeItem {
  final String name;
  final double value;
  
  const _KnowledgeItem(this.name, this.value);
}

class _KnowledgeSet {
  final String description;
  final String? hint;
  final String? fact; // Educational fact showed after completion
  final List<_KnowledgeItem> items;
  
  const _KnowledgeSet({
    required this.description,
    required this.items,
    this.hint,
    this.fact,
  });
}

const _knowledgeData = [
  // Planets by distance from sun
  _KnowledgeSet(
    description: 'Sort planets by distance from Sun',
    hint: 'Mercury is closest, Neptune is farthest',
    fact: 'The distance from Earth to the Sun is called an Astronomical Unit (AU), approximately 150 million kilometers. Light takes 8 minutes to reach Earth!',
    items: [
      _KnowledgeItem('Mercury', 1),
      _KnowledgeItem('Venus', 2),
      _KnowledgeItem('Earth', 3),
      _KnowledgeItem('Mars', 4),
      _KnowledgeItem('Jupiter', 5),
      _KnowledgeItem('Saturn', 6),
      _KnowledgeItem('Uranus', 7),
      _KnowledgeItem('Neptune', 8),
    ],
  ),
  
  // Continents by size
  _KnowledgeSet(
    description: 'Sort continents by size',
    hint: 'Asia is largest, Australia is smallest',
    fact: 'Asia covers about 30% of Earth\'s total land area and hosts 60% of the world\'s current human population.',
    items: [
      _KnowledgeItem('Asia', 7),
      _KnowledgeItem('Africa', 6),
      _KnowledgeItem('North America', 5),
      _KnowledgeItem('South America', 4),
      _KnowledgeItem('Antarctica', 3),
      _KnowledgeItem('Europe', 2),
      _KnowledgeItem('Australia', 1),
    ],
  ),
  
  // Oceans by size
  _KnowledgeSet(
    description: 'Sort oceans by size',
    fact: 'The Pacific Ocean is larger than all Earth\'s land area combined! It covers more than 30% of Earth\'s surface.',
    items: [
      _KnowledgeItem('Pacific', 5),
      _KnowledgeItem('Atlantic', 4),
      _KnowledgeItem('Indian', 3),
      _KnowledgeItem('Southern', 2),
      _KnowledgeItem('Arctic', 1),
    ],
  ),
  
  // Months by days
  _KnowledgeSet(
    description: 'Sort months by number of days',
    fact: 'February typically has 28 days, but in leap years (divisible by 4, except for century years not divisible by 400) it has 29.',
    items: [
      _KnowledgeItem('February', 28),
      _KnowledgeItem('April', 30),
      _KnowledgeItem('June', 30),
      _KnowledgeItem('September', 30),
      _KnowledgeItem('November', 30),
      _KnowledgeItem('January', 31),
      _KnowledgeItem('March', 31),
      _KnowledgeItem('May', 31),
    ],
  ),
  
  // Tallest mountains
  _KnowledgeSet(
    description: 'Sort mountains by height',
    hint: 'Mt. Everest is the tallest',
    fact: 'Mt. Everest grows about 4mm every year due to tectonic plate movement! It stands at 8,849 meters above sea level.',
    items: [
      _KnowledgeItem('Mt. Everest', 8849),
      _KnowledgeItem('K2', 8611),
      _KnowledgeItem('Kangchenjunga', 8586),
      _KnowledgeItem('Lhotse', 8516),
      _KnowledgeItem('Makalu', 8485),
    ],
  ),
  
  // Longest rivers
  _KnowledgeSet(
    description: 'Sort rivers by length',
    fact: 'The Nile is widely accepted as the longest river (6,650 km), but some studies argue the Amazon might be longer depending on where the source is measured.',
    items: [
      _KnowledgeItem('Nile', 6650),
      _KnowledgeItem('Amazon', 6400),
      _KnowledgeItem('Yangtze', 6300),
      _KnowledgeItem('Mississippi', 6275),
      _KnowledgeItem('Yenisei', 5539),
    ],
  ),
  
  // Rainbow colors (order)
  _KnowledgeSet(
    description: 'Sort rainbow colors in order',
    hint: 'Red, Orange, Yellow, Green, Blue, Indigo, Violet',
    fact: 'Isaac Newton originally identified only five colors, adding orange and indigo later to match the number of notes in a musical scale (7).',
    items: [
      _KnowledgeItem('Red', 1),
      _KnowledgeItem('Orange', 2),
      _KnowledgeItem('Yellow', 3),
      _KnowledgeItem('Green', 4),
      _KnowledgeItem('Blue', 5),
      _KnowledgeItem('Indigo', 6),
      _KnowledgeItem('Violet', 7),
    ],
  ),
  
  // Days of week
  _KnowledgeSet(
    description: 'Sort days of the week',
    fact: 'The days of the week are named after celestial bodies and mythological figures. Monday is Moon day, Sunday is Sun day!',
    items: [
      _KnowledgeItem('Monday', 1),
      _KnowledgeItem('Tuesday', 2),
      _KnowledgeItem('Wednesday', 3),
      _KnowledgeItem('Thursday', 4),
      _KnowledgeItem('Friday', 5),
      _KnowledgeItem('Saturday', 6),
      _KnowledgeItem('Sunday', 7),
    ],
  ),
  
  // Most populous countries
  _KnowledgeSet(
    description: 'Sort countries by population',
    hint: 'China and India are the most populous',
    fact: 'China and India are the only two countries with over a billion people. Together they account for about 35% of the world\'s population.',
    items: [
      _KnowledgeItem('China', 1400),
      _KnowledgeItem('India', 1380),
      _KnowledgeItem('USA', 331),
      _KnowledgeItem('Indonesia', 273),
      _KnowledgeItem('Pakistan', 220),
      _KnowledgeItem('Brazil', 212),
    ],
  ),
  
  // Historical events chronologically
  _KnowledgeSet(
    description: 'Sort historical events by year',
    fact: 'The Moon Landing in 1969 was watched by an estimated 600 million people worldwide, one of the most viewed events in history.',
    items: [
      _KnowledgeItem('Fall of Rome', 476),
      _KnowledgeItem('Columbus discovers America', 1492),
      _KnowledgeItem('French Revolution', 1789),
      _KnowledgeItem('World War I', 1914),
      _KnowledgeItem('Moon Landing', 1969),
    ],
  ),
  
  // Alphabet position
  _KnowledgeSet(
    description: 'Sort letters alphabetically',
    fact: 'The letter "E" is the most common letter in the English language, appearing in about 11% of all words.',
    items: [
      _KnowledgeItem('A', 1),
      _KnowledgeItem('E', 5),
      _KnowledgeItem('I', 9),
      _KnowledgeItem('O', 15),
      _KnowledgeItem('U', 21),
      _KnowledgeItem('Z', 26),
    ],
  ),
  
  // Age categories
  _KnowledgeSet(
    description: 'Sort life stages by typical age',
    fact: 'Human development is often categorized into stages. "Adolescence" roughly corresponds to the teenage years (13-19).',
    items: [
      _KnowledgeItem('Infant', 1),
      _KnowledgeItem('Toddler', 3),
      _KnowledgeItem('Child', 8),
      _KnowledgeItem('Teenager', 15),
      _KnowledgeItem('Adult', 30),
      _KnowledgeItem('Senior', 65),
    ],
  ),
  
  // Solar system moons count
  _KnowledgeSet(
    description: 'Sort planets by number of moons',
    hint: 'Saturn has the most moons',
    fact: 'Saturn leads with 146 known moons, while Jupiter follows closely! Mercury and Venus are the only planets with zero moons.',
    items: [
      _KnowledgeItem('Mercury', 0),
      _KnowledgeItem('Venus', 0),
      _KnowledgeItem('Earth', 1),
      _KnowledgeItem('Mars', 2),
      _KnowledgeItem('Neptune', 16),
      _KnowledgeItem('Uranus', 27),
      _KnowledgeItem('Jupiter', 95),
      _KnowledgeItem('Saturn', 146),
    ],
  ),
  
  // Speed of animals
  _KnowledgeSet(
    description: 'Sort animals by speed (km/h)',
    fact: 'Cheetahs can accelerate from 0 to 100 km/h in just 3 seconds! However, they can only maintain top speed for short sprints.',
    items: [
      _KnowledgeItem('Cheetah', 120),
      _KnowledgeItem('Lion', 80),
      _KnowledgeItem('Horse', 70),
      _KnowledgeItem('Elephant', 40),
      _KnowledgeItem('Human', 28),
      _KnowledgeItem('Turtle', 1),
    ],
  ),
  
  // Musical note order
  _KnowledgeSet(
    description: 'Sort musical notes in order',
    hint: 'Do, Re, Mi, Fa, Sol, La, Si',
    fact: 'The "Sol-Fa" system (Do-Re-Mi) was invented by Guido of Arezzo in the 11th century to teach singing.',
    items: [
      _KnowledgeItem('Do (C)', 1),
      _KnowledgeItem('Re (D)', 2),
      _KnowledgeItem('Mi (E)', 3),
      _KnowledgeItem('Fa (F)', 4),
      _KnowledgeItem('Sol (G)', 5),
      _KnowledgeItem('La (A)', 6),
      _KnowledgeItem('Si (B)', 7),
    ],
  ),
];
