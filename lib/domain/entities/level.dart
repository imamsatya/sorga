import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'level_item.dart';
import '../../l10n/app_localizations.dart';

/// Categories of sorting levels
enum LevelCategory {
  basic,
  formatted,
  time,
  names,
  mixed,
  knowledge,
}

/// Sort order for the level
enum SortOrder {
  ascending,
  descending,
}

/// Extension to get display names for categories
extension LevelCategoryExtension on LevelCategory {
  String get displayName {
    switch (this) {
      case LevelCategory.basic:
        return 'Basic Numbers';
      case LevelCategory.formatted:
        return 'Formatted Numbers';
      case LevelCategory.time:
        return 'Time Formats';
      case LevelCategory.names:
        return 'Name Sorting';
      case LevelCategory.mixed:
        return 'Mixed Formats';
      case LevelCategory.knowledge:
        return 'Knowledge';
    }
  }
  
  IconData get icon {
    switch (this) {
      case LevelCategory.basic:
        return Icons.format_list_numbered;
      case LevelCategory.formatted:
        return Icons.functions;
      case LevelCategory.time:
        return Icons.access_time;
      case LevelCategory.names:
        return Icons.sort_by_alpha;
      case LevelCategory.mixed:
        return Icons.shuffle;
      case LevelCategory.knowledge:
        return Icons.psychology;
    }
  }
}

/// Extension for sort order
extension SortOrderExtension on SortOrder {
  String get displayName {
    switch (this) {
      case SortOrder.ascending:
        return 'Ascending ↑';
      case SortOrder.descending:
        return 'Descending ↓';
    }
  }
  
  String get shortName {
    switch (this) {
      case SortOrder.ascending:
        return 'ASC';
      case SortOrder.descending:
        return 'DESC';
    }
  }
}

/// Represents a game level
class Level extends Equatable {
  /// Unique level ID (Global 1-835)
  final int id;
  
  /// Local ID within category (e.g. 1-107)
  final int localId;
  
  /// Category of the level
  final LevelCategory category;
  
  /// Sort order for this level
  final SortOrder sortOrder;
  
  /// Display title for the level
  final String title;
  
  /// Description/instructions for the level
  final String description;
  
  /// Items to be sorted
  final List<LevelItem> items;
  
  /// Hint text (optional, for knowledge levels)
  final String? hint;
  
  /// Interesting fact (optional, for knowledge levels)
  final String? fact;
  
  /// Whether this is a memory mode level (SORGAwy)
  final bool isMemory;

  const Level({
    required this.id,
    required this.localId,
    required this.category,
    required this.sortOrder,
    required this.title,
    required this.description,
    required this.items,
    this.hint,
    this.fact,
    this.isMemory = false,
  });

  /// Get the correctly sorted items
  List<LevelItem> get correctOrder {
    final sorted = List<LevelItem>.from(items);
    sorted.sort((a, b) {
      if (sortOrder == SortOrder.ascending) {
        return a.sortValue.compareTo(b.sortValue);
      } else {
        return b.sortValue.compareTo(a.sortValue);
      }
    });
    return sorted;
  }

  /// Number of items in this level
  int get itemCount => items.length;

  /// Unique composite ID string (e.g., 'basic_1', 'time_5')
  String get compositeId => '${category.name}_$localId';
  
  /// Helper to parse "category_localId" string
  static (LevelCategory, int)? parseCompositeId(String compositeId) {
    try {
      final parts = compositeId.split('_');
      if (parts.length != 2) return null;
      
      final category = LevelCategory.values.firstWhere(
        (c) => c.name == parts[0],
        orElse: () => LevelCategory.basic,
      );
      
      final localId = int.tryParse(parts[1]);
      if (localId == null) return null;
      
      return (category, localId);
    } catch (e) {
      return null;
    }
  }

  /// Get localized description using AppLocalizations
  /// This generates descriptions like "Sort 3 numbers ASC" in the user's language
  String getLocalizedDescription(BuildContext context) {
    // Try to parse the existing description to extract components
    // Pattern: "Sort X <type> ASC/DESC"
    final desc = description.toLowerCase();
    
    // Check if it's a simple sort pattern we can localize
    final countMatch = RegExp(r'sort (\d+)').firstMatch(desc);
    if (countMatch != null) {
      final count = countMatch.group(1) ?? '';
      
      // Determine type
      String type;
      if (desc.contains('number') || desc.contains('values')) {
        type = _getLocalizedType(context, 'numbers');
      } else if (desc.contains('name')) {
        type = _getLocalizedType(context, 'names');
      } else if (desc.contains('time') || desc.contains('duration')) {
        type = _getLocalizedType(context, 'times');
      } else {
        type = _getLocalizedType(context, 'numbers');
      }
      
      // Determine direction
      String direction;
      if (desc.contains('desc')) {
        direction = _getLocalizedDirection(context, false);
      } else {
        direction = _getLocalizedDirection(context, true);
      }
      
      return _buildLocalizedSortDescription(context, count, type, direction);
    }
    
    // For complex/knowledge descriptions, fall back to original
    return description;
  }
  
  String _getLocalizedType(BuildContext context, String type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case 'numbers': return l10n.numbers;
      case 'names': return l10n.names;
      case 'times': return l10n.times;
      default: return type;
    }
  }
  
  String _getLocalizedDirection(BuildContext context, bool ascending) {
    final l10n = AppLocalizations.of(context)!;
    return ascending ? l10n.ascending : l10n.descending;
  }
  
  String _buildLocalizedSortDescription(BuildContext context, String count, String type, String direction) {
    final l10n = AppLocalizations.of(context)!;
    return l10n.sortDescription(count, type, direction);
  }

  @override
  List<Object?> get props => [id, localId, category, sortOrder, title, items, isMemory];
  
  @override
  String toString() => 'Level($id: $title)';
}
