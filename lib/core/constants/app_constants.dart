/// Application-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'SORTIQ';
  static const String appVersion = '1.0.0';
  
  // 🔧 Development Mode - set to false for production
  static const bool isDevMode = false;
  
  // 📢 Ads Toggle - set to false to disable all ads (AdMob suspended)
  // Set to true when AdMob account is active again
  static const bool adsEnabled = true;  
  // Level Constants
  static const int totalLevels = 600; // 500 regular + 100 knowledge
  
  // Memory Mode - unlock requirement (complete this many regular levels)
  static const int memoryUnlockLevel = 30;
  
  // Level Ranges per Category (100 levels each for non-knowledge)
  static const int basicNumbersStart = 1;
  static const int basicNumbersEnd = 100;
  
  static const int formattedNumbersStart = 101;
  static const int formattedNumbersEnd = 200;
  
  static const int timeFormatsStart = 201;
  static const int timeFormatsEnd = 300;
  
  static const int nameSortingStart = 301;
  static const int nameSortingEnd = 400;
  
  static const int mixedFormatsStart = 401;
  static const int mixedFormatsEnd = 500;
  
  static const int knowledgeStart = 501;
  static const int knowledgeEnd = 600; // 100 levels (50 unique questions × 2 directions)
  
  // Timer
  static const int maxTimerSeconds = 3600; // 1 hour max
  
  // Mistake Limits (attempts before game over)
  // Regular mode: 2 attempts (1 mistake allowed)
  // Memory mode: 3 attempts (2 mistakes allowed)
  // Pro users: truly unlimited (handled in ProService)
  static const int maxAttemptsRegular = 2;
  static const int maxAttemptsMemory = 3;
  
  // Database
  static const String progressBoxName = 'user_progress';
  static const String settingsBoxName = 'settings';
  
  // Settings Keys
  static const String isProKey = 'is_pro';
  
  // In-App Purchase
  static const String iapProductId = 'sortiq_pro';
  
  // Memory Mode Timer
  // Formula: baseTime + (itemCount × timePerItem × complexityMultiplier)
  static const double memoryBaseTime = 3.0; // seconds
  static const double memoryTimePerItem = 1.5; // seconds per item
  
  // Category complexity multipliers for memory timer
  static const Map<String, double> categoryComplexity = {
    'basic': 1.0,      // Simple digits (1, 2, 3)
    'formatted': 1.5,  // Commas, decimals (1,234.56)
    'time': 1.8,       // Time formats (08:30 AM)
    'names': 1.3,      // Alphabetical names
    'mixed': 2.0,      // Multiple formats mixed
    'knowledge': 1.4,  // Visual/factual items
  };
}
