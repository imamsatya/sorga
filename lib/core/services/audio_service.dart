import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Service for playing game sound effects
class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _popPlayer = AudioPlayer();
  final AudioPlayer _successPlayer = AudioPlayer();
  final AudioPlayer _errorPlayer = AudioPlayer();

  bool _initialized = false;
  bool _soundEnabled = true;

  bool get soundEnabled => _soundEnabled;
  
  set soundEnabled(bool value) {
    _soundEnabled = value;
  }

  /// Initialize audio players with sound files
  Future<void> init() async {
    if (_initialized) return;
    
    try {
      // Pre-load sounds - using web-compatible sources
      // Note: For production, add actual sound files to assets/audio/
      await _popPlayer.setReleaseMode(ReleaseMode.stop);
      await _successPlayer.setReleaseMode(ReleaseMode.stop);
      await _errorPlayer.setReleaseMode(ReleaseMode.stop);
      
      // Set volumes
      await _popPlayer.setVolume(0.3);
      await _successPlayer.setVolume(0.5);
      await _errorPlayer.setVolume(0.4);
      
      _initialized = true;
    } catch (e) {
      debugPrint('AudioService init error: $e');
    }
  }

  /// Play pop sound when dragging/dropping items
  Future<void> playPop() async {
    if (!_soundEnabled) return;
    try {
      // Using a simple sine wave generated via data URL for web compatibility
      // In production, replace with: AssetSource('audio/pop.mp3')
      await _popPlayer.stop();
      await _popPlayer.play(
        AssetSource('audio/pop.wav'),
        mode: PlayerMode.lowLatency,
      );
    } catch (e) {
      debugPrint('Pop sound error: $e');
    }
  }

  /// Play success/tring sound when level is completed correctly
  Future<void> playSuccess() async {
    if (!_soundEnabled) return;
    try {
      await _successPlayer.stop();
      await _successPlayer.play(
        AssetSource('audio/success.wav'),
        mode: PlayerMode.lowLatency,
      );
    } catch (e) {
      debugPrint('Success sound error: $e');
    }
  }

  /// Play error sound when answer is wrong
  Future<void> playError() async {
    if (!_soundEnabled) return;
    try {
      await _errorPlayer.stop();
      await _errorPlayer.play(
        AssetSource('audio/error.mp3'),
        mode: PlayerMode.lowLatency,
      );
    } catch (e) {
      debugPrint('Error sound error: $e');
    }
  }

  /// Dispose all players
  void dispose() {
    _popPlayer.dispose();
    _successPlayer.dispose();
    _errorPlayer.dispose();
  }
}
