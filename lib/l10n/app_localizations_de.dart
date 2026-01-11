// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Startseite';

  @override
  String get play => 'Spielen';

  @override
  String get achievements => 'Erfolge';

  @override
  String get statistics => 'Statistiken';

  @override
  String get chooseCategory => 'Kategorie wählen';

  @override
  String levelCompleted(Object id) {
    return 'Level $id abgeschlossen!';
  }

  @override
  String get sortItems => 'Elemente sortieren';

  @override
  String get sortNames => 'Namen sortieren';

  @override
  String get lowToHigh => 'Klein → Groß';

  @override
  String get highToLow => 'Groß → Klein';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Nächstes Level';

  @override
  String get retry => 'Wiederholen';

  @override
  String get dailyChallenge => 'Tägliche Herausforderung';

  @override
  String get streak => 'Serie';

  @override
  String get perfect => 'PERFEKT!';

  @override
  String get tryAgain => 'NOCHMAL VERSUCHEN';

  @override
  String get completed => 'abgeschlossen';

  @override
  String get basicNumbers => 'Grundzahlen';

  @override
  String get formattedNumbers => 'Formatiert';

  @override
  String get timeFormats => 'Zeitformate';

  @override
  String get nameSorting => 'Namen sortieren';

  @override
  String get mixedFormats => 'Gemischte Formate';

  @override
  String get knowledge => 'Wissen';

  @override
  String get levels => 'Level';

  @override
  String get share => 'Teilen';

  @override
  String get close => 'Schließen';

  @override
  String get yourTime => 'DEINE ZEIT';

  @override
  String get continueGame => 'WEITER';

  @override
  String get retryLevel => 'LEVEL WIEDERHOLEN';
}
