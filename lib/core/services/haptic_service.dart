import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Service for haptic feedback with toggle option
class HapticService {
  static final HapticService _instance = HapticService._internal();
  factory HapticService() => _instance;
  HapticService._internal();

  bool _hapticEnabled = true;

  bool get hapticEnabled => _hapticEnabled;
  
  set hapticEnabled(bool value) {
    _hapticEnabled = value;
  }

  /// Light tap feedback - for item selection/drag start
  Future<void> lightTap() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return; // Web doesn't support haptics
    
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Haptic light tap error: $e');
    }
  }

  /// Medium tap feedback - for item drop/swap
  Future<void> mediumTap() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return;
    
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Haptic medium tap error: $e');
    }
  }

  /// Heavy tap feedback - for success/error
  Future<void> heavyTap() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return;
    
    try {
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Haptic heavy tap error: $e');
    }
  }

  /// Selection click - for button press
  Future<void> selectionClick() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return;
    
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      debugPrint('Haptic selection click error: $e');
    }
  }

  /// Vibrate pattern for success
  Future<void> successVibrate() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return;
    
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.mediumImpact();
    } catch (e) {
      debugPrint('Haptic success vibrate error: $e');
    }
  }

  /// Vibrate pattern for error
  Future<void> errorVibrate() async {
    if (!_hapticEnabled) return;
    if (kIsWeb) return;
    
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(const Duration(milliseconds: 50));
      await HapticFeedback.heavyImpact();
    } catch (e) {
      debugPrint('Haptic error vibrate error: $e');
    }
  }
}
