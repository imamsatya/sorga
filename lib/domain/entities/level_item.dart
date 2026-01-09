import 'package:equatable/equatable.dart';

/// Represents a single item that can be sorted in a level
class LevelItem extends Equatable {
  /// The value displayed to the user (e.g., "3²", "90 seconds", "Mercury")
  final String displayValue;
  
  /// The actual comparable value for sorting (e.g., 9, 90, 1)
  final double sortValue;
  
  /// Unique identifier for this item
  final String id;

  const LevelItem({
    required this.displayValue,
    required this.sortValue,
    required this.id,
  });

  @override
  List<Object?> get props => [id, displayValue, sortValue];
  
  @override
  String toString() => 'LevelItem(display: $displayValue, sort: $sortValue)';
}
