import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/haptic_service.dart';

/// Settings state for audio and haptic feedback
class FeedbackSettings {
  final bool soundEnabled;
  final bool hapticEnabled;
  
  const FeedbackSettings({
    this.soundEnabled = true,
    this.hapticEnabled = true,
  });
  
  FeedbackSettings copyWith({
    bool? soundEnabled,
    bool? hapticEnabled,
  }) {
    return FeedbackSettings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      hapticEnabled: hapticEnabled ?? this.hapticEnabled,
    );
  }
}

/// Provider for feedback settings
class FeedbackSettingsNotifier extends StateNotifier<FeedbackSettings> {
  final AudioService _audioService = AudioService();
  final HapticService _hapticService = HapticService();
  
  FeedbackSettingsNotifier() : super(const FeedbackSettings());
  
  void toggleSound() {
    state = state.copyWith(soundEnabled: !state.soundEnabled);
    _audioService.soundEnabled = state.soundEnabled;
  }
  
  void toggleHaptic() {
    state = state.copyWith(hapticEnabled: !state.hapticEnabled);
    _hapticService.hapticEnabled = state.hapticEnabled;
  }
  
  void setSoundEnabled(bool value) {
    state = state.copyWith(soundEnabled: value);
    _audioService.soundEnabled = value;
  }
  
  void setHapticEnabled(bool value) {
    state = state.copyWith(hapticEnabled: value);
    _hapticService.hapticEnabled = value;
  }
}

final feedbackSettingsProvider = StateNotifierProvider<FeedbackSettingsNotifier, FeedbackSettings>(
  (ref) => FeedbackSettingsNotifier(),
);
