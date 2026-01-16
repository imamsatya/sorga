import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// All possible achievement types
enum AchievementType {
  // Level milestones
  firstLevel,      // Complete first level
  level10,         // Complete 10 levels
  level50,         // Complete 50 levels
  level100,        // Complete 100 levels
  level500,        // Complete 500 levels
  level1000,       // Complete all 1000 levels
  
  // Streak milestones
  streak3,         // 3 day streak
  streak7,         // 7 day streak
  streak30,        // 30 day streak
  
  // Speed achievements
  speedDemon,      // Complete a level in under 5 seconds
  lightning,       // Complete a level in under 3 seconds
  
  // Category mastery
  basicMaster,     // Complete all basic levels (1-60)
  formattedMaster, // Complete all formatted levels (61-250)
  timeMaster,      // Complete all time levels (251-450)
  namesMaster,     // Complete all names levels (451-650)
  mixedMaster,     // Complete all mixed levels (651-850)
  knowledgeMaster, // Complete all knowledge levels (851-1000)
  
  // Special
  perfectRun,      // Complete 10 levels in a row without mistakes
  dedicated,       // Play for 1 hour total
  marathon,        // Play for 5 hours total
}

/// Achievement definition with metadata
class Achievement extends Equatable {
  final AchievementType type;
  final String name;
  final String description;
  final String emoji;
  final Color color;
  final bool isSecret;
  
  const Achievement({
    required this.type,
    required this.name,
    required this.description,
    required this.emoji,
    required this.color,
    this.isSecret = false,
  });
  
  /// Get all achievements with their definitions
  static List<Achievement> get all => [
    // Level Milestones
    const Achievement(
      type: AchievementType.firstLevel,
      name: 'First Steps',
      description: 'Complete your first level',
      emoji: '🎯',
      color: Color(0xFF74B9FF),
    ),
    const Achievement(
      type: AchievementType.level10,
      name: 'Getting Started',
      description: 'Complete 10 levels',
      emoji: '🌟',
      color: Color(0xFF55E6C1),
    ),
    const Achievement(
      type: AchievementType.level50,
      name: 'On a Roll',
      description: 'Complete 50 levels',
      emoji: '🔥',
      color: Color(0xFFFFBE76),
    ),
    const Achievement(
      type: AchievementType.level100,
      name: 'Century Club',
      description: 'Complete 100 levels',
      emoji: '💯',
      color: Color(0xFFFF7675),
    ),
    const Achievement(
      type: AchievementType.level500,
      name: 'Halfway There',
      description: 'Complete 500 levels',
      emoji: '🏆',
      color: Color(0xFFA29BFE),
    ),
    const Achievement(
      type: AchievementType.level1000,
      name: 'Sorting Master',
      description: 'Complete all 1000 levels',
      emoji: '👑',
      color: Color(0xFFFD79A8),
    ),
    
    // Streak Milestones
    const Achievement(
      type: AchievementType.streak3,
      name: 'Consistent',
      description: 'Play 3 days in a row',
      emoji: '📅',
      color: Color(0xFF00CEC9),
    ),
    const Achievement(
      type: AchievementType.streak7,
      name: 'Week Warrior',
      description: 'Play 7 days in a row',
      emoji: '💪',
      color: Color(0xFF6C5CE7),
    ),
    const Achievement(
      type: AchievementType.streak30,
      name: 'Monthly Master',
      description: 'Play 30 days in a row',
      emoji: '🗓️',
      color: Color(0xFFE17055),
    ),
    
    // Speed Achievements
    const Achievement(
      type: AchievementType.speedDemon,
      name: 'Speed Demon',
      description: 'Complete a level in under 5 seconds',
      emoji: '⚡',
      color: Color(0xFFFDAA5D),
    ),
    const Achievement(
      type: AchievementType.lightning,
      name: 'Lightning Fast',
      description: 'Complete a level in under 3 seconds',
      emoji: '🚀',
      color: Color(0xFFE84393),
      isSecret: true,
    ),
    
    // Category Mastery
    const Achievement(
      type: AchievementType.basicMaster,
      name: 'Basic Expert',
      description: 'Complete all basic number levels',
      emoji: '🔢',
      color: Color(0xFF74B9FF),
    ),
    const Achievement(
      type: AchievementType.formattedMaster,
      name: 'Format Pro',
      description: 'Complete all formatted number levels',
      emoji: '📊',
      color: Color(0xFFFFBE76),
    ),
    const Achievement(
      type: AchievementType.timeMaster,
      name: 'Time Lord',
      description: 'Complete all time-based levels',
      emoji: '⏰',
      color: Color(0xFF55E6C1),
    ),
    const Achievement(
      type: AchievementType.namesMaster,
      name: 'Alphabetizer',
      description: 'Complete all name sorting levels',
      emoji: '📝',
      color: Color(0xFFFF7675),
    ),
    const Achievement(
      type: AchievementType.mixedMaster,
      name: 'Mix Master',
      description: 'Complete all mixed format levels',
      emoji: '🎨',
      color: Color(0xFFA29BFE),
    ),
    const Achievement(
      type: AchievementType.knowledgeMaster,
      name: 'Knowledge King',
      description: 'Complete all knowledge levels',
      emoji: '✨',
      color: Color(0xFFFD79A8),
    ),
    
    // Special
    const Achievement(
      type: AchievementType.perfectRun,
      name: 'Perfect Streak',
      description: 'Complete 10 levels in a row without mistakes',
      emoji: '✨',
      color: Color(0xFF00B894),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.dedicated,
      name: 'Dedicated Player',
      description: 'Play for 1 hour total',
      emoji: '⌛',
      color: Color(0xFF0984E3),
    ),
    const Achievement(
      type: AchievementType.marathon,
      name: 'Marathon Runner',
      description: 'Play for 5 hours total',
      emoji: '🏃',
      color: Color(0xFFD63031),
      isSecret: true,
    ),
  ];
  
  /// Get achievement by type
  static Achievement getByType(AchievementType type) {
    return all.firstWhere((a) => a.type == type);
  }
  
  @override
  List<Object?> get props => [type];
}
