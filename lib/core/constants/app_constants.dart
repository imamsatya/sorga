/// Application-wide constants
class AppConstants {
  AppConstants._();

  static const String appName = 'Sorga';
  static const String appVersion = '1.0.0';
  
  // 🔧 Development Mode - set to false for production
  static const bool isDevMode = false;
  
  // Level Constants
  static const int totalLevels = 1000;
  
  // Level Ranges per Category
  static const int basicNumbersStart = 1;
  static const int basicNumbersEnd = 60;
  
  static const int formattedNumbersStart = 61;
  static const int formattedNumbersEnd = 180;
  
  static const int timeFormatsStart = 181;
  static const int timeFormatsEnd = 300;
  
  static const int nameSortingStart = 301;
  static const int nameSortingEnd = 500;
  
  static const int mixedFormatsStart = 501;
  static const int mixedFormatsEnd = 700;
  
  static const int knowledgeStart = 701;
  static const int knowledgeEnd = 1000;
  
  // Timer
  static const int maxTimerSeconds = 3600; // 1 hour max
  
  // Database
  static const String progressBoxName = 'user_progress';
  static const String settingsBoxName = 'settings';
}
