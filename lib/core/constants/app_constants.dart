/// Application-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Sorga';
  static const String appVersion = '1.0.0';
  
  // 🔧 Development Mode - set to false for production
  static const bool isDevMode = false;
  
  // Level Constants
  static const int totalLevels = 800;
  
  // Memory Mode - unlock requirement (complete this many regular levels)
  static const int memoryUnlockLevel = 35;
  
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
  static const int knowledgeEnd = 800; // 300 levels (15 sets * 20)
  
  // Timer
  static const int maxTimerSeconds = 3600; // 1 hour max
  
  // Database
  static const String progressBoxName = 'user_progress';
  static const String settingsBoxName = 'settings';
}
