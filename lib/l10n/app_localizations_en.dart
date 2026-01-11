// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Home';

  @override
  String get play => 'Play';

  @override
  String get achievements => 'Achievements';

  @override
  String get statistics => 'Statistics';

  @override
  String get chooseCategory => 'Choose Category';

  @override
  String levelCompleted(Object id) {
    return 'Level $id Completed!';
  }

  @override
  String get sortItems => 'Sort Items';

  @override
  String get sortNames => 'Sort Names';

  @override
  String get lowToHigh => 'Low → High';

  @override
  String get highToLow => 'High → Low';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Next Level';

  @override
  String get retry => 'Retry';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get streak => 'Streak';

  @override
  String get perfect => 'PERFECT!';

  @override
  String get tryAgain => 'TRY AGAIN';

  @override
  String get completed => 'completed';

  @override
  String get basicNumbers => 'Basic Numbers';

  @override
  String get formattedNumbers => 'Formatted';

  @override
  String get timeFormats => 'Time Formats';

  @override
  String get nameSorting => 'Name Sorting';

  @override
  String get mixedFormats => 'Mixed Formats';

  @override
  String get knowledge => 'Knowledge';

  @override
  String get levels => 'levels';

  @override
  String get share => 'Share';

  @override
  String get close => 'Close';

  @override
  String get yourTime => 'YOUR TIME';

  @override
  String get continueGame => 'CONTINUE';

  @override
  String get retryLevel => 'RETRY LEVEL';
}
