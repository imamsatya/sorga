/// Application-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Sorga';
  static const String appVersion = '1.0.0';
  
  // 🔧 Development Mode - set to false for production
  static const bool isDevMode = true;
  
  // Level Constants
  static const int totalLevels = 835;
  
  // Level Ranges per Category (107 levels each for non-knowledge)
  static const int basicNumbersStart = 1;
  static const int basicNumbersEnd = 107;
  
  static const int formattedNumbersStart = 108;
  static const int formattedNumbersEnd = 214;
  
  static const int timeFormatsStart = 215;
  static const int timeFormatsEnd = 321;
  
  static const int nameSortingStart = 322;
  static const int nameSortingEnd = 428;
  
  static const int mixedFormatsStart = 429;
  static const int mixedFormatsEnd = 535;
  
  static const int knowledgeStart = 536;
  static const int knowledgeEnd = 835; // 300 levels (15 sets * 20)
  
  // Timer
  static const int maxTimerSeconds = 3600; // 1 hour max
  
  // Database
  static const String progressBoxName = 'user_progress';
  static const String settingsBoxName = 'settings';
}
