import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local_database.dart';

/// Supported locales for the app
const supportedLocales = [
  Locale('en'), // English (Default)
  Locale('es'), // Spanish
  Locale('pt'), // Portuguese
  Locale('de'), // German
  Locale('fr'), // French
  Locale('ja'), // Japanese
  Locale('ko'), // Korean
  Locale('id'), // Indonesian
  Locale('zh'), // Chinese Simplified
  Locale('hi'), // Hindi
  Locale('ar'), // Arabic
];

/// Map of locale codes to display names
const localeDisplayNames = {
  'en': 'English',
  'es': 'Español',
  'pt': 'Português',
  'de': 'Deutsch',
  'fr': 'Français',
  'ja': '日本語',
  'ko': '한국어',
  'id': 'Bahasa Indonesia',
  'zh': '简体中文',
  'hi': 'हिन्दी',
  'ar': 'العربية',
};

/// Locale state notifier for in-app language switching
class LocaleNotifier extends StateNotifier<Locale?> {
  LocaleNotifier() : super(null) {
    _loadSavedLocale();
  }

  /// Load saved locale from Hive
  void _loadSavedLocale() {
    final savedLocaleCode = LocalDatabase.instance.settingsBox.get('locale');
    if (savedLocaleCode != null) {
      state = Locale(savedLocaleCode);
    }
  }

  /// Set locale and persist to storage
  void setLocale(Locale locale) {
    state = locale;
    LocalDatabase.instance.settingsBox.put('locale', locale.languageCode);
  }

  /// Clear locale (use system default)
  void clearLocale() {
    state = null;
    LocalDatabase.instance.settingsBox.delete('locale');
  }
}

/// Provider for the current locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale?>((ref) {
  return LocaleNotifier();
});
