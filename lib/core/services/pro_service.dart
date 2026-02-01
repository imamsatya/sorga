import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

/// Service to manage Pro status and related features
class ProService {
  static ProService? _instance;
  static ProService get instance => _instance ??= ProService._();
  
  ProService._();
  
  Box<dynamic>? _settingsBox;
  
  /// Initialize with settings box reference
  void init(Box<dynamic> settingsBox) {
    _settingsBox = settingsBox;
  }
  
  /// Check if user has Pro status
  bool get isPro {
    return _settingsBox?.get(AppConstants.isProKey, defaultValue: false) ?? false;
  }
  
  /// Set Pro status (for testing or after purchase)
  Future<void> setProStatus(bool value) async {
    await _settingsBox?.put(AppConstants.isProKey, value);
  }
  
  /// Get maximum attempts allowed based on game mode and Pro status
  int getMaxAttempts({required bool isMemoryMode}) {
    if (isPro) {
      return AppConstants.maxAttemptsPro;
    }
    return isMemoryMode 
        ? AppConstants.maxAttemptsMemory 
        : AppConstants.maxAttemptsRegular;
  }
  
  /// Check if user can continue after failed attempt
  bool canContinue({required int failedAttempts, required bool isMemoryMode}) {
    final maxAttempts = getMaxAttempts(isMemoryMode: isMemoryMode);
    return failedAttempts < maxAttempts;
  }
  
  /// Get remaining attempts
  int getRemainingAttempts({required int failedAttempts, required bool isMemoryMode}) {
    final maxAttempts = getMaxAttempts(isMemoryMode: isMemoryMode);
    return maxAttempts - failedAttempts;
  }
}
