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
  /// Get item count based on level progression (relativeId is 0-indexed, max 99)
  /// User Refactor: Max 30 items distributed over 100 levels.
  int _getItemCountForLevel(int relativeId) {
    // Phase 1: Easy (Levels 1-20 / ID 0-19) -> 3 to 8 items
    if (relativeId < 20) {
      // 3 + (0..19 / 19 * 5) -> 3..8
      final extra = (relativeId / 19 * 5).round();
      return 3 + extra;
    }
    
    // Phase 2: Moderate (Levels 21-60 / ID 20-59) -> 9 to 20 items
    if (relativeId < 60) {
      // 9 + (0..39 / 39 * 11) -> 9..20
      final extra = ((relativeId - 20) / 39 * 11).round();
      return 9 + extra;
    }
    
    // Phase 3: Hard (Levels 61-100 / ID 60-99) -> 21 to 30 items
    // 21 + (0..39 / 39 * 9) -> 21..30
    final extra = ((relativeId - 60) / 39 * 9).round();
    return (21 + extra).clamp(21, 30);
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

  // ==================== MEMORY MODE (SORGAwy) ====================
  
  /// Seed offset for memory levels to generate different questions
  static const int _memorySeedOffset = 10000;
  
  /// Cache for memory levels (separate from regular levels)
  final Map<int, Level> _memoryLevelCache = {};
  
  /// Get a memory mode level by ID (same structure, different values)
  Level getMemoryLevel(int levelId) {
    if (levelId < 1 || levelId > AppConstants.totalLevels) {
      throw ArgumentError('Level ID must be between 1 and ${AppConstants.totalLevels}');
    }
    
    return _memoryLevelCache.putIfAbsent(levelId, () => _generateMemoryLevel(levelId));
  }
  
  /// Get memory levels by category
  List<Level> getMemoryLevelsByCategory(LevelCategory category) {
    // Skip knowledge category for memory mode
    if (category == LevelCategory.knowledge) {
      return [];
    }
    
    final (start, end) = _getCategoryRange(category);
    return List.generate(
      end - start + 1,
      (index) => getMemoryLevel(start + index),
    );
  }
  
  /// Generate a memory level (same structure as regular, different seed)
  Level _generateMemoryLevel(int levelId) {
    // Get regular level as base for structure
    final regularLevel = getLevel(levelId);
    
    // Skip knowledge levels for memory mode
    if (regularLevel.category == LevelCategory.knowledge) {
      return regularLevel;
    }
    
    // Generate new items with different seed
    final random = Random((levelId + _memorySeedOffset) * 12345);
    final itemCount = regularLevel.items.length;
    
    // Generate new items based on category
    final newItems = _generateMemoryItems(random, regularLevel.category, itemCount, levelId);
    
    return Level(
      id: levelId,
      localId: regularLevel.localId,
      category: regularLevel.category,
      sortOrder: regularLevel.sortOrder,
      title: regularLevel.title,
      description: regularLevel.description,
      items: newItems,
      hint: regularLevel.hint,
      fact: regularLevel.fact,
      isMemory: true,
    );
  }
  
  /// Generate items for memory level (different values, same count)
  List<LevelItem> _generateMemoryItems(Random random, LevelCategory category, int count, int levelId) {
    switch (category) {
      case LevelCategory.basic:
        return _generateBasicItems(random, count);
      case LevelCategory.formatted:
        final formatType = (levelId % 5);
        return _generateFormattedItems(random, count, formatType, levelId + _memorySeedOffset);
      case LevelCategory.time:
        return _generateTimeItems(random, count);
      case LevelCategory.names:
        return _generateNameItems(random, count);
      case LevelCategory.mixed:
        return _generateMixedItems(random, count);
      case LevelCategory.knowledge:
        return []; // Should not reach here
    }
  }
  
  /// Generate basic number items for memory
  List<LevelItem> _generateBasicItems(Random random, int count) {
    final values = <int>{};
    while (values.length < count) {
      values.add(random.nextInt(999) + 1);
    }
    return values.map((v) => LevelItem(
      id: values.toList().indexOf(v).toString(),
      displayValue: v.toString(),
      sortValue: v.toDouble(),
    )).toList();
  }
  
  /// Generate name items for memory
  List<LevelItem> _generateNameItems(Random random, int count) {
    const names = ['Alice', 'Bob', 'Charlie', 'Diana', 'Eva', 'Frank', 'Grace', 'Henry',
      'Ivy', 'Jack', 'Kate', 'Leo', 'Mia', 'Noah', 'Olivia', 'Peter', 'Quinn', 'Rose',
      'Sam', 'Tina', 'Uma', 'Victor', 'Wendy', 'Xavier', 'Yara', 'Zack'];
    final shuffled = List<String>.from(names)..shuffle(random);
    return shuffled.take(count).map((name) => LevelItem(
      id: shuffled.indexOf(name).toString(),
      displayValue: name,
      sortValue: name.codeUnits.first.toDouble() * 100 + name.codeUnits[1].toDouble(),
    )).toList();
  }
  
  /// Generate mixed format items for memory
  List<LevelItem> _generateMixedItems(Random random, int count) {
    final items = <LevelItem>[];
    for (var i = 0; i < count; i++) {
      items.add(_generateMixedItem(random, i, random.nextInt(5)));
    }
    return items;
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

  // ==================== KNOWLEDGE LEVELS (501-600) ====================
  
  Level _generateKnowledgeLevel(int levelId) {
    final relativeId = levelId - AppConstants.knowledgeStart;
    
    // Each question appears exactly twice: once ASC (odd), once DESC (even)
    // Question 0 = levels 0,1 (local 1,2) // Question 1 = levels 2,3 (local 3,4)...
    final knowledgeIndex = relativeId ~/ 2;  // Integer division: 0,1→0, 2,3→1, 4,5→2...
    final data = _knowledgeData[knowledgeIndex % _knowledgeData.length];
    
    final random = _getSeededRandom(levelId);
    
    // First occurrence (odd relative level) = ASC, second (even) = DESC
    final isFirstOccurrence = relativeId % 2 == 0;
    final sortOrder = isFirstOccurrence ? SortOrder.ascending : SortOrder.descending;
    
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
  
  // 16. Tallest buildings
  _KnowledgeSet(
    description: 'Sort buildings by height',
    hint: 'Burj Khalifa is the tallest',
    fact: 'Burj Khalifa in Dubai stands at 828 meters, more than twice the height of the Empire State Building!',
    items: [
      _KnowledgeItem('Burj Khalifa', 828),
      _KnowledgeItem('Merdeka 118', 679),
      _KnowledgeItem('Shanghai Tower', 632),
      _KnowledgeItem('Abraj Al-Bait', 601),
      _KnowledgeItem('One World Trade', 541),
    ],
  ),
  
  // 17. Countries by area
  _KnowledgeSet(
    description: 'Sort countries by land area',
    fact: 'Russia is so large that it spans 11 time zones! It covers more than 17 million square kilometers.',
    items: [
      _KnowledgeItem('Russia', 17098),
      _KnowledgeItem('Canada', 9985),
      _KnowledgeItem('USA', 9834),
      _KnowledgeItem('China', 9597),
      _KnowledgeItem('Brazil', 8516),
      _KnowledgeItem('Australia', 7692),
    ],
  ),
  
  // 18. Deepest ocean trenches
  _KnowledgeSet(
    description: 'Sort ocean trenches by depth',
    fact: 'The Mariana Trench is so deep that if Mount Everest were placed inside, its peak would still be over 2 km underwater!',
    items: [
      _KnowledgeItem('Mariana Trench', 10994),
      _KnowledgeItem('Tonga Trench', 10882),
      _KnowledgeItem('Philippine Trench', 10540),
      _KnowledgeItem('Kuril-Kamchatka', 10542),
      _KnowledgeItem('Japan Trench', 9000),
    ],
  ),
  
  // 19. Hottest places on Earth
  _KnowledgeSet(
    description: 'Sort places by temperature record (°C)',
    fact: 'Death Valley recorded 56.7°C in 1913 - hot enough to cook an egg on the ground!',
    items: [
      _KnowledgeItem('Death Valley', 57),
      _KnowledgeItem('Kebili, Tunisia', 55),
      _KnowledgeItem('Tirat Zvi, Israel', 54),
      _KnowledgeItem('Ahwaz, Iran', 54),
      _KnowledgeItem('Kuwait City', 53),
    ],
  ),
  
  // 20. Largest animals
  _KnowledgeSet(
    description: 'Sort animals by weight (tons)',
    fact: 'A Blue Whale\'s heart is the size of a small car and weighs about 400 pounds!',
    items: [
      _KnowledgeItem('Blue Whale', 173),
      _KnowledgeItem('Fin Whale', 74),
      _KnowledgeItem('Sperm Whale', 45),
      _KnowledgeItem('African Elephant', 6),
      _KnowledgeItem('White Rhino', 2),
    ],
  ),
  
  // 21. Longest living animals
  _KnowledgeSet(
    description: 'Sort animals by lifespan (years)',
    fact: 'The Greenland Shark can live over 400 years - some alive today were born before Shakespeare!',
    items: [
      _KnowledgeItem('Greenland Shark', 400),
      _KnowledgeItem('Giant Tortoise', 175),
      _KnowledgeItem('Bowhead Whale', 200),
      _KnowledgeItem('Elephant', 70),
      _KnowledgeItem('Human', 80),
      _KnowledgeItem('Dog', 13),
    ],
  ),
  
  // 22. Periodic table - atomic numbers
  _KnowledgeSet(
    description: 'Sort elements by atomic number',
    hint: 'H, He, Li, Be, B, C...',
    fact: 'Hydrogen makes up 75% of all normal matter in the universe by mass!',
    items: [
      _KnowledgeItem('Hydrogen (H)', 1),
      _KnowledgeItem('Helium (He)', 2),
      _KnowledgeItem('Carbon (C)', 6),
      _KnowledgeItem('Oxygen (O)', 8),
      _KnowledgeItem('Iron (Fe)', 26),
      _KnowledgeItem('Gold (Au)', 79),
    ],
  ),
  
  // 23. Planets by size
  _KnowledgeSet(
    description: 'Sort planets by diameter',
    fact: 'Jupiter is so large that over 1,300 Earths could fit inside it!',
    items: [
      _KnowledgeItem('Jupiter', 139820),
      _KnowledgeItem('Saturn', 116460),
      _KnowledgeItem('Uranus', 50724),
      _KnowledgeItem('Neptune', 49244),
      _KnowledgeItem('Earth', 12742),
      _KnowledgeItem('Mars', 6779),
      _KnowledgeItem('Mercury', 4879),
    ],
  ),
  
  // 24. Computer storage units
  _KnowledgeSet(
    description: 'Sort storage units by size',
    hint: 'KB < MB < GB < TB',
    fact: 'A Yottabyte equals about 1 trillion terabytes - that\'s enough to store the entire internet many times over!',
    items: [
      _KnowledgeItem('Bit', 1),
      _KnowledgeItem('Byte', 8),
      _KnowledgeItem('Kilobyte', 1024),
      _KnowledgeItem('Megabyte', 1048576),
      _KnowledgeItem('Gigabyte', 1073741824),
    ],
  ),
  
  // 25. World Wars timeline
  _KnowledgeSet(
    description: 'Sort events by year',
    fact: 'World War II is the deadliest conflict in human history, with an estimated 70-85 million fatalities.',
    items: [
      _KnowledgeItem('WW1 Starts', 1914),
      _KnowledgeItem('WW1 Ends', 1918),
      _KnowledgeItem('WW2 Starts', 1939),
      _KnowledgeItem('D-Day', 1944),
      _KnowledgeItem('WW2 Ends', 1945),
    ],
  ),
  
  // 26. Largest deserts
  _KnowledgeSet(
    description: 'Sort deserts by area',
    fact: 'Antarctica is technically the largest desert because a desert is defined by precipitation, not temperature!',
    items: [
      _KnowledgeItem('Antarctic', 14000000),
      _KnowledgeItem('Arctic', 13985000),
      _KnowledgeItem('Sahara', 9200000),
      _KnowledgeItem('Arabian', 2330000),
      _KnowledgeItem('Gobi', 1295000),
    ],
  ),
  
  // 27. Fastest land vehicles
  _KnowledgeSet(
    description: 'Sort vehicles by top speed (km/h)',
    fact: 'The Thrust SSC broke the sound barrier on land, reaching 1,228 km/h in 1997!',
    items: [
      _KnowledgeItem('Thrust SSC', 1228),
      _KnowledgeItem('Bugatti Chiron', 490),
      _KnowledgeItem('Ferrari SF90', 340),
      _KnowledgeItem('Tesla Model S', 322),
      _KnowledgeItem('Toyota Camry', 200),
    ],
  ),
  
  // 28. Languages by speakers
  _KnowledgeSet(
    description: 'Sort languages by native speakers (millions)',
    fact: 'Mandarin Chinese has the most native speakers, but English is the most widely spoken including second-language speakers.',
    items: [
      _KnowledgeItem('Mandarin', 920),
      _KnowledgeItem('Spanish', 475),
      _KnowledgeItem('English', 373),
      _KnowledgeItem('Hindi', 344),
      _KnowledgeItem('Arabic', 274),
      _KnowledgeItem('Portuguese', 232),
    ],
  ),
  
  // 29. Olympic Games years
  _KnowledgeSet(
    description: 'Sort Olympic cities by year',
    fact: 'The 1896 Athens Olympics was the first modern Olympic Games, with only 14 nations participating.',
    items: [
      _KnowledgeItem('Athens', 1896),
      _KnowledgeItem('Paris', 1900),
      _KnowledgeItem('Berlin', 1936),
      _KnowledgeItem('Tokyo', 1964),
      _KnowledgeItem('Beijing', 2008),
      _KnowledgeItem('Rio', 2016),
    ],
  ),
  
  // 30. Space exploration milestones
  _KnowledgeSet(
    description: 'Sort space events by year',
    fact: 'Sputnik 1 was only the size of a beach ball but it changed the world forever, starting the Space Age.',
    items: [
      _KnowledgeItem('Sputnik 1', 1957),
      _KnowledgeItem('Yuri Gagarin', 1961),
      _KnowledgeItem('Moon Landing', 1969),
      _KnowledgeItem('Space Shuttle', 1981),
      _KnowledgeItem('ISS Completion', 2011),
    ],
  ),
  
  // 31. Calories in foods
  _KnowledgeSet(
    description: 'Sort foods by calories (per 100g)',
    fact: 'Dark chocolate has more calories per gram than many fast foods, but it contains beneficial antioxidants!',
    items: [
      _KnowledgeItem('Butter', 717),
      _KnowledgeItem('Chocolate', 546),
      _KnowledgeItem('Cheese', 402),
      _KnowledgeItem('Bread', 265),
      _KnowledgeItem('Apple', 52),
      _KnowledgeItem('Cucumber', 15),
    ],
  ),
  
  // 32. Hardest materials
  _KnowledgeSet(
    description: 'Sort materials by hardness (Mohs scale)',
    hint: 'Diamond is the hardest natural material',
    fact: 'Diamond can only be scratched by another diamond! That\'s why diamond-tipped tools are used for cutting.',
    items: [
      _KnowledgeItem('Diamond', 10),
      _KnowledgeItem('Sapphire', 9),
      _KnowledgeItem('Quartz', 7),
      _KnowledgeItem('Steel', 5),
      _KnowledgeItem('Copper', 3),
      _KnowledgeItem('Talc', 1),
    ],
  ),
  
  // 33. Social media by users
  _KnowledgeSet(
    description: 'Sort social media by users (billions)',
    fact: 'Facebook has more active users than the entire population of China and India combined!',
    items: [
      _KnowledgeItem('Facebook', 2900),
      _KnowledgeItem('YouTube', 2500),
      _KnowledgeItem('WhatsApp', 2000),
      _KnowledgeItem('Instagram', 1500),
      _KnowledgeItem('TikTok', 1000),
      _KnowledgeItem('Twitter', 450),
    ],
  ),
  
  // 34. Famous paintings timeline
  _KnowledgeSet(
    description: 'Sort paintings by year created',
    fact: 'The Mona Lisa is one of the most visited artworks in the world, attracting about 6 million visitors annually.',
    items: [
      _KnowledgeItem('Mona Lisa', 1506),
      _KnowledgeItem('Starry Night', 1889),
      _KnowledgeItem('The Scream', 1893),
      _KnowledgeItem('Guernica', 1937),
      _KnowledgeItem('Campbell Soup', 1962),
    ],
  ),
  
  // 35. Age of inventions
  _KnowledgeSet(
    description: 'Sort inventions by year',
    fact: 'The printing press is considered one of the most important inventions in history, enabling mass communication.',
    items: [
      _KnowledgeItem('Printing Press', 1440),
      _KnowledgeItem('Steam Engine', 1712),
      _KnowledgeItem('Telephone', 1876),
      _KnowledgeItem('Airplane', 1903),
      _KnowledgeItem('Internet', 1983),
    ],
  ),
  
  // 36. Human body organs by weight
  _KnowledgeSet(
    description: 'Sort organs by weight (grams)',
    fact: 'The skin is actually the largest organ, weighing about 4-5 kg in adults!',
    items: [
      _KnowledgeItem('Skin', 4500),
      _KnowledgeItem('Liver', 1500),
      _KnowledgeItem('Brain', 1400),
      _KnowledgeItem('Lungs', 1100),
      _KnowledgeItem('Heart', 310),
      _KnowledgeItem('Kidney', 150),
    ],
  ),
  
  // 37. Distances from Earth
  _KnowledgeSet(
    description: 'Sort celestial objects by distance from Earth',
    fact: 'Light from the Sun takes 8 minutes to reach Earth, while light from Alpha Centauri takes over 4 years!',
    items: [
      _KnowledgeItem('Moon', 384400),
      _KnowledgeItem('Mars', 225000000),
      _KnowledgeItem('Jupiter', 628730000),
      _KnowledgeItem('Saturn', 1275000000),
      _KnowledgeItem('Neptune', 4350000000),
    ],
  ),
  
  // 38. Volcanoes by height
  _KnowledgeSet(
    description: 'Sort volcanoes by height (meters)',
    fact: 'Ojos del Salado on the Chile-Argentina border is the highest volcano on Earth and is still considered potentially active.',
    items: [
      _KnowledgeItem('Ojos del Salado', 6893),
      _KnowledgeItem('Llullaillaco', 6739),
      _KnowledgeItem('Cotopaxi', 5897),
      _KnowledgeItem('Mt. Kilimanjaro', 5895),
      _KnowledgeItem('Mt. Fuji', 3776),
    ],
  ),
  
  // 39. Coffee caffeine content
  _KnowledgeSet(
    description: 'Sort drinks by caffeine (mg per cup)',
    fact: 'Espresso has less caffeine per cup than drip coffee because it uses less water, despite being more concentrated!',
    items: [
      _KnowledgeItem('Drip Coffee', 95),
      _KnowledgeItem('Energy Drink', 80),
      _KnowledgeItem('Espresso', 63),
      _KnowledgeItem('Black Tea', 47),
      _KnowledgeItem('Green Tea', 28),
      _KnowledgeItem('Decaf Coffee', 2),
    ],
  ),
  
  // 40. Dinosaur sizes
  _KnowledgeSet(
    description: 'Sort dinosaurs by length (meters)',
    fact: 'Argentinosaurus was so heavy (70+ tons) that its footsteps could be felt from far away!',
    items: [
      _KnowledgeItem('Argentinosaurus', 35),
      _KnowledgeItem('Diplodocus', 27),
      _KnowledgeItem('T-Rex', 12),
      _KnowledgeItem('Triceratops', 9),
      _KnowledgeItem('Velociraptor', 2),
    ],
  ),
  
  // 41. Currencies by value (vs USD)
  _KnowledgeSet(
    description: 'Sort currencies by value (1 USD =)',
    fact: 'The Kuwaiti Dinar is the strongest currency in the world, with 1 KWD being worth over 3 USD!',
    items: [
      _KnowledgeItem('Kuwaiti Dinar', 0.3),
      _KnowledgeItem('British Pound', 0.8),
      _KnowledgeItem('Euro', 0.9),
      _KnowledgeItem('US Dollar', 1),
      _KnowledgeItem('Japanese Yen', 150),
    ],
  ),
  
  // 42. Famous composers timeline
  _KnowledgeSet(
    description: 'Sort composers by birth year',
    fact: 'Mozart was a child prodigy who started composing at age 5 and wrote over 600 works in his short 35-year life.',
    items: [
      _KnowledgeItem('Bach', 1685),
      _KnowledgeItem('Mozart', 1756),
      _KnowledgeItem('Beethoven', 1770),
      _KnowledgeItem('Chopin', 1810),
      _KnowledgeItem('Debussy', 1862),
    ],
  ),
  
  // 43. Internet speeds
  _KnowledgeSet(
    description: 'Sort connection types by speed',
    fact: '5G can theoretically reach 10 Gbps - fast enough to download a 4K movie in seconds!',
    items: [
      _KnowledgeItem('Dial-up', 56),
      _KnowledgeItem('DSL', 25000),
      _KnowledgeItem('Cable', 100000),
      _KnowledgeItem('Fiber', 1000000),
      _KnowledgeItem('5G', 10000000),
    ],
  ),
  
  // 44. Waterfalls by height
  _KnowledgeSet(
    description: 'Sort waterfalls by height (meters)',
    fact: 'Angel Falls is so tall that water evaporates into mist before reaching the bottom during dry season!',
    items: [
      _KnowledgeItem('Angel Falls', 979),
      _KnowledgeItem('Tugela Falls', 948),
      _KnowledgeItem('Tres Hermanas', 914),
      _KnowledgeItem('Niagara Falls', 51),
      _KnowledgeItem('Victoria Falls', 108),
    ],
  ),
  
  // 45. Brightest stars
  _KnowledgeSet(
    description: 'Sort stars by brightness (magnitude)',
    hint: 'Lower magnitude = brighter',
    fact: 'Sirius is called the "Dog Star" because it\'s in Canis Major, and its heliacal rising marked the flooding of the Nile in ancient Egypt.',
    items: [
      _KnowledgeItem('Sirius', -1.46),
      _KnowledgeItem('Canopus', -0.74),
      _KnowledgeItem('Arcturus', -0.05),
      _KnowledgeItem('Vega', 0.03),
      _KnowledgeItem('Polaris', 1.98),
    ],
  ),
  
  // 46. Human bones count
  _KnowledgeSet(
    description: 'Sort body parts by number of bones',
    fact: 'Over half of all bones in your body (106 out of 206) are in your hands and feet!',
    items: [
      _KnowledgeItem('Hands', 54),
      _KnowledgeItem('Feet', 52),
      _KnowledgeItem('Spine', 33),
      _KnowledgeItem('Skull', 22),
      _KnowledgeItem('Ribs', 24),
    ],
  ),
  
  // 47. Ancient civilizations
  _KnowledgeSet(
    description: 'Sort civilizations by founding year (BCE)',
    fact: 'Ancient Sumer (Mesopotamia) is considered the cradle of civilization, inventing writing, the wheel, and mathematics.',
    items: [
      _KnowledgeItem('Sumer', 4500),
      _KnowledgeItem('Egypt', 3100),
      _KnowledgeItem('Indus Valley', 2500),
      _KnowledgeItem('Greece', 800),
      _KnowledgeItem('Rome', 753),
    ],
  ),
  
  // 48. Boiling points
  _KnowledgeSet(
    description: 'Sort substances by boiling point (°C)',
    fact: 'Helium has the lowest boiling point of any element at -269°C, just 4 degrees above absolute zero!',
    items: [
      _KnowledgeItem('Helium', -269),
      _KnowledgeItem('Nitrogen', -196),
      _KnowledgeItem('Alcohol', 78),
      _KnowledgeItem('Water', 100),
      _KnowledgeItem('Mercury', 357),
      _KnowledgeItem('Iron', 2862),
    ],
  ),
  
  // 49. Book pages
  _KnowledgeSet(
    description: 'Sort famous books by page count',
    fact: 'War and Peace has about 580,000 words - reading it at 200 words per minute would take nearly 49 hours!',
    items: [
      _KnowledgeItem('War and Peace', 1225),
      _KnowledgeItem('Les Misérables', 1232),
      _KnowledgeItem('Harry Potter 5', 766),
      _KnowledgeItem('To Kill a Mockingbird', 281),
      _KnowledgeItem('The Great Gatsby', 180),
    ],
  ),
  
  // 50. Video game sales
  _KnowledgeSet(
    description: 'Sort games by units sold (millions)',
    fact: 'Minecraft has sold over 300 million copies, making it the best-selling video game of all time!',
    items: [
      _KnowledgeItem('Minecraft', 300),
      _KnowledgeItem('GTA V', 195),
      _KnowledgeItem('Tetris', 100),
      _KnowledgeItem('Mario Kart 8', 62),
      _KnowledgeItem('Pokemon Red/Blue', 31),
    ],
  ),
];
