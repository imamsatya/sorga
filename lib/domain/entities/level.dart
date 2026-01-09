import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'level_item.dart';

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
  /// Unique level ID (1-1000)
  final int id;
  
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

  const Level({
    required this.id,
    required this.category,
    required this.sortOrder,
    required this.title,
    required this.description,
    required this.items,
    this.hint,
    this.fact,
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

  @override
  List<Object?> get props => [id, category, sortOrder, title, items];
  
  @override
  String toString() => 'Level($id: $title)';
}
