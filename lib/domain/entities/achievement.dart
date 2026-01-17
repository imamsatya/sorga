import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// All possible achievement types
enum AchievementType {
  // === LEVEL MILESTONES ===
  firstLevel,      // Complete first level
  level10,         // Complete 10 levels
  level50,         // Complete 50 levels
  level100,        // Complete 100 levels
  level500,        // Complete 500 levels
  level600,        // Complete all 600 levels
  
  // === STREAK MILESTONES ===
  streak3,         // 3 day streak
  streak7,         // 7 day streak
  streak30,        // 30 day streak
  streak100,       // 100 day streak (NEW)
  
  // === SPEED ACHIEVEMENTS ===
  speedDemon,      // Complete a level in under 5 seconds
  lightning,       // Complete a level in under 3 seconds
  
  // === CATEGORY MASTERY (individual levels) ===
  basicMaster,     // Complete 100 basic levels
  formattedMaster, // Complete 100 formatted levels
  timeMaster,      // Complete 100 time levels
  namesMaster,     // Complete 100 names levels
  mixedMaster,     // Complete 100 mixed levels
  knowledgeMaster, // Complete 100 knowledge levels
  
  // === CATEGORY COMPLETION (100% of category) ===
  basicComplete,      // Complete all basic levels (100/100)
  formattedComplete,  // Complete all formatted levels
  timeComplete,       // Complete all time levels
  namesComplete,      // Complete all names levels
  mixedComplete,      // Complete all mixed levels
  knowledgeComplete,  // Complete all knowledge levels
  
  // === MEMORY MODE - PROGRESS ===
  memoryBeginner,  // Complete 10 levels in Memory mode
  memoryExpert,    // Complete 50 levels in Memory mode
  memoryMaster,    // Complete 100 levels in Memory mode
  
  // === MEMORY MODE - PERFECT (no mistakes) ===
  memoryPerfect5,   // 5 perfect Memory completions
  memoryPerfect10,  // 10 perfect
  memoryPerfect25,  // 25 perfect
  memoryPerfect50,  // 50 perfect
  memoryPerfect100, // 100 perfect
  
  // === MEMORY MODE - CATEGORY COMPLETION ===
  memoryBasicComplete,     // Complete all basic in Memory
  memoryFormattedComplete, // Complete all formatted in Memory
  memoryTimeComplete,      // Complete all time in Memory
  memoryNamesComplete,     // Complete all names in Memory
  memoryMixedComplete,     // Complete all mixed in Memory
  
  // === DAILY CHALLENGE - PROGRESS ===
  dailyFirst,   // Complete first daily challenge
  dailyWeek,    // Complete 7 daily challenges
  dailyMonth,   // Complete 30 daily challenges
  daily100,     // Complete 100 daily challenges
  
  // === DAILY CHALLENGE - PERFECT (no mistakes) ===
  dailyPerfect5,   // 5 perfect daily challenges
  dailyPerfect10,  // 10 perfect
  dailyPerfect25,  // 25 perfect
  dailyPerfect50,  // 50 perfect
  dailyPerfect100, // 100 perfect
  
  // === MULTIPLAYER ===
  multiplayer10,   // Host 10 multiplayer games
  multiplayer25,   // Host 25 multiplayer games
  multiplayer50,   // Host 50 multiplayer games
  
  // === SPECIAL ===
  perfectRun,      // Complete 10 levels in a row without mistakes
  dedicated,       // Play for 1 hour total
  marathon,        // Play for 5 hours total
  totalMaster,     // Complete 1100 total (600 regular + 500 Memory)
  completionist,   // Unlock all other achievements
  
  // === SECRET ACHIEVEMENTS ===
  nightOwl,        // Complete a level between 00:00-05:00
  earlyBird,       // Complete a level between 05:00-07:00
  newYear,         // Play on January 1st
  persistent,      // Use retry button 50 times
  instantWin,      // Complete level in under 2 seconds
  descendingFan,   // Complete 20 descending levels in a row
  swapOnly,        // Complete 10 levels using only swap
  shiftOnly,       // Complete 10 levels using only shift
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
    // === LEVEL MILESTONES ===
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
      type: AchievementType.level600,
      name: 'Sorting Master',
      description: 'Complete all 600 levels',
      emoji: '👑',
      color: Color(0xFFFD79A8),
    ),
    
    // === STREAK MILESTONES ===
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
    const Achievement(
      type: AchievementType.streak100,
      name: 'Legendary Streak',
      description: 'Play 100 days in a row',
      emoji: '🔥',
      color: Color(0xFFFFD700),
    ),
    
    // === SPEED ACHIEVEMENTS ===
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
    ),
    
    // === CATEGORY MASTERY ===
    const Achievement(
      type: AchievementType.basicMaster,
      name: 'Basic Expert',
      description: 'Complete 100 basic number levels',
      emoji: '🔢',
      color: Color(0xFF74B9FF),
    ),
    const Achievement(
      type: AchievementType.formattedMaster,
      name: 'Format Pro',
      description: 'Complete 100 formatted number levels',
      emoji: '📊',
      color: Color(0xFFFFBE76),
    ),
    const Achievement(
      type: AchievementType.timeMaster,
      name: 'Time Lord',
      description: 'Complete 100 time-based levels',
      emoji: '⏰',
      color: Color(0xFF55E6C1),
    ),
    const Achievement(
      type: AchievementType.namesMaster,
      name: 'Alphabetizer',
      description: 'Complete 100 name sorting levels',
      emoji: '📝',
      color: Color(0xFFFF7675),
    ),
    const Achievement(
      type: AchievementType.mixedMaster,
      name: 'Mix Master',
      description: 'Complete 100 mixed format levels',
      emoji: '🎨',
      color: Color(0xFFA29BFE),
    ),
    const Achievement(
      type: AchievementType.knowledgeMaster,
      name: 'Knowledge King',
      description: 'Complete 100 knowledge levels',
      emoji: '🧠',
      color: Color(0xFFFD79A8),
    ),
    
    // === CATEGORY COMPLETION (100%) ===
    const Achievement(
      type: AchievementType.basicComplete,
      name: 'Basic Perfectionist',
      description: 'Complete 100% of basic levels',
      emoji: '✅',
      color: Color(0xFF74B9FF),
    ),
    const Achievement(
      type: AchievementType.formattedComplete,
      name: 'Format Perfectionist',
      description: 'Complete 100% of formatted levels',
      emoji: '✅',
      color: Color(0xFFFFBE76),
    ),
    const Achievement(
      type: AchievementType.timeComplete,
      name: 'Time Perfectionist',
      description: 'Complete 100% of time levels',
      emoji: '✅',
      color: Color(0xFF55E6C1),
    ),
    const Achievement(
      type: AchievementType.namesComplete,
      name: 'Names Perfectionist',
      description: 'Complete 100% of name levels',
      emoji: '✅',
      color: Color(0xFFFF7675),
    ),
    const Achievement(
      type: AchievementType.mixedComplete,
      name: 'Mixed Perfectionist',
      description: 'Complete 100% of mixed levels',
      emoji: '✅',
      color: Color(0xFFA29BFE),
    ),
    const Achievement(
      type: AchievementType.knowledgeComplete,
      name: 'Knowledge Perfectionist',
      description: 'Complete 100% of knowledge levels',
      emoji: '✅',
      color: Color(0xFFFD79A8),
    ),
    
    // === MEMORY MODE - PROGRESS ===
    const Achievement(
      type: AchievementType.memoryBeginner,
      name: 'Memory Novice',
      description: 'Complete 10 levels in Memory mode',
      emoji: '🧠',
      color: Color(0xFF9B59B6),
    ),
    const Achievement(
      type: AchievementType.memoryExpert,
      name: 'Memory Expert',
      description: 'Complete 50 levels in Memory mode',
      emoji: '🧠',
      color: Color(0xFF8E44AD),
    ),
    const Achievement(
      type: AchievementType.memoryMaster,
      name: 'Memory Master',
      description: 'Complete 100 levels in Memory mode',
      emoji: '🧠',
      color: Color(0xFF6C3483),
    ),
    
    // === MEMORY MODE - PERFECT ===
    const Achievement(
      type: AchievementType.memoryPerfect5,
      name: 'Perfect Recall',
      description: 'Complete 5 Memory levels without mistakes',
      emoji: '✨',
      color: Color(0xFFAF7AC5),
    ),
    const Achievement(
      type: AchievementType.memoryPerfect10,
      name: 'Memory Pro',
      description: 'Complete 10 Memory levels without mistakes',
      emoji: '✨',
      color: Color(0xFF9B59B6),
    ),
    const Achievement(
      type: AchievementType.memoryPerfect25,
      name: 'Memory Genius',
      description: 'Complete 25 Memory levels without mistakes',
      emoji: '✨',
      color: Color(0xFF8E44AD),
    ),
    const Achievement(
      type: AchievementType.memoryPerfect50,
      name: 'Eidetic Memory',
      description: 'Complete 50 Memory levels without mistakes',
      emoji: '✨',
      color: Color(0xFF7D3C98),
    ),
    const Achievement(
      type: AchievementType.memoryPerfect100,
      name: 'Photographic Memory',
      description: 'Complete 100 Memory levels without mistakes',
      emoji: '📸',
      color: Color(0xFF6C3483),
    ),
    
    // === MEMORY MODE - CATEGORY COMPLETION ===
    const Achievement(
      type: AchievementType.memoryBasicComplete,
      name: 'Memory Basic Master',
      description: 'Complete all basic levels in Memory mode',
      emoji: '🏅',
      color: Color(0xFF74B9FF),
    ),
    const Achievement(
      type: AchievementType.memoryFormattedComplete,
      name: 'Memory Format Master',
      description: 'Complete all formatted levels in Memory mode',
      emoji: '🏅',
      color: Color(0xFFFFBE76),
    ),
    const Achievement(
      type: AchievementType.memoryTimeComplete,
      name: 'Memory Time Master',
      description: 'Complete all time levels in Memory mode',
      emoji: '🏅',
      color: Color(0xFF55E6C1),
    ),
    const Achievement(
      type: AchievementType.memoryNamesComplete,
      name: 'Memory Names Master',
      description: 'Complete all name levels in Memory mode',
      emoji: '🏅',
      color: Color(0xFFFF7675),
    ),
    const Achievement(
      type: AchievementType.memoryMixedComplete,
      name: 'Memory Mixed Master',
      description: 'Complete all mixed levels in Memory mode',
      emoji: '🏅',
      color: Color(0xFFA29BFE),
    ),
    
    // === DAILY CHALLENGE - PROGRESS ===
    const Achievement(
      type: AchievementType.dailyFirst,
      name: 'Daily Starter',
      description: 'Complete your first daily challenge',
      emoji: '📆',
      color: Color(0xFF00CEC9),
    ),
    const Achievement(
      type: AchievementType.dailyWeek,
      name: 'Weekly Challenger',
      description: 'Complete 7 daily challenges',
      emoji: '📆',
      color: Color(0xFF00B894),
    ),
    const Achievement(
      type: AchievementType.dailyMonth,
      name: 'Monthly Challenger',
      description: 'Complete 30 daily challenges',
      emoji: '📆',
      color: Color(0xFF009688),
    ),
    const Achievement(
      type: AchievementType.daily100,
      name: 'Daily Legend',
      description: 'Complete 100 daily challenges',
      emoji: '📆',
      color: Color(0xFF00796B),
    ),
    
    // === DAILY CHALLENGE - PERFECT ===
    const Achievement(
      type: AchievementType.dailyPerfect5,
      name: 'Perfect Day',
      description: 'Complete 5 daily challenges without mistakes',
      emoji: '⭐',
      color: Color(0xFFFFD700),
    ),
    const Achievement(
      type: AchievementType.dailyPerfect10,
      name: 'Perfect Week',
      description: 'Complete 10 daily challenges without mistakes',
      emoji: '⭐',
      color: Color(0xFFFFC107),
    ),
    const Achievement(
      type: AchievementType.dailyPerfect25,
      name: 'Perfect Streak',
      description: 'Complete 25 daily challenges without mistakes',
      emoji: '⭐',
      color: Color(0xFFFF9800),
    ),
    const Achievement(
      type: AchievementType.dailyPerfect50,
      name: 'Flawless Player',
      description: 'Complete 50 daily challenges without mistakes',
      emoji: '⭐',
      color: Color(0xFFFF5722),
    ),
    const Achievement(
      type: AchievementType.dailyPerfect100,
      name: 'Daily Perfectionist',
      description: 'Complete 100 daily challenges without mistakes',
      emoji: '💎',
      color: Color(0xFFE91E63),
    ),
    
    // === MULTIPLAYER ===
    const Achievement(
      type: AchievementType.multiplayer10,
      name: 'Party Host',
      description: 'Host 10 multiplayer games',
      emoji: '👥',
      color: Color(0xFF3498DB),
    ),
    const Achievement(
      type: AchievementType.multiplayer25,
      name: 'Social Gamer',
      description: 'Host 25 multiplayer games',
      emoji: '🎉',
      color: Color(0xFF2980B9),
    ),
    const Achievement(
      type: AchievementType.multiplayer50,
      name: 'Multiplayer Legend',
      description: 'Host 50 multiplayer games',
      emoji: '🏆',
      color: Color(0xFF1ABC9C),
    ),
    
    // === SPECIAL ===
    const Achievement(
      type: AchievementType.perfectRun,
      name: 'Perfect Run',
      description: 'Complete 10 levels in a row without mistakes',
      emoji: '✨',
      color: Color(0xFF00B894),
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
    ),
    const Achievement(
      type: AchievementType.totalMaster,
      name: 'Total Master',
      description: 'Complete 1100 levels (regular + Memory)',
      emoji: '👑',
      color: Color(0xFFFFD700),
    ),
    const Achievement(
      type: AchievementType.completionist,
      name: 'Completionist',
      description: 'Unlock all other achievements',
      emoji: '🌟',
      color: Color(0xFFE91E63),
      isSecret: true,
    ),
    
    // === SECRET ACHIEVEMENTS ===
    const Achievement(
      type: AchievementType.nightOwl,
      name: 'Night Owl',
      description: 'Complete a level between midnight and 5 AM',
      emoji: '🦉',
      color: Color(0xFF2C3E50),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.earlyBird,
      name: 'Early Bird',
      description: 'Complete a level between 5 AM and 7 AM',
      emoji: '🐦',
      color: Color(0xFFE67E22),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.newYear,
      name: 'New Year Sorter',
      description: 'Play on January 1st',
      emoji: '🎉',
      color: Color(0xFFE74C3C),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.persistent,
      name: 'Never Give Up',
      description: 'Use the retry button 50 times',
      emoji: '💪',
      color: Color(0xFF16A085),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.instantWin,
      name: 'Instant Win',
      description: 'Complete a level in under 2 seconds',
      emoji: '⚡',
      color: Color(0xFFF39C12),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.descendingFan,
      name: 'Descending Fan',
      description: 'Complete 20 descending levels in a row',
      emoji: '📉',
      color: Color(0xFF9B59B6),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.swapOnly,
      name: 'Swap Master',
      description: 'Complete 10 levels using only swap',
      emoji: '🔄',
      color: Color(0xFF1ABC9C),
      isSecret: true,
    ),
    const Achievement(
      type: AchievementType.shiftOnly,
      name: 'Shift Master',
      description: 'Complete 10 levels using only shift',
      emoji: '↔️',
      color: Color(0xFF3498DB),
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
