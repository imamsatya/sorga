// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Accueil';

  @override
  String get play => 'Jouer';

  @override
  String get achievements => 'Succès';

  @override
  String get statistics => 'Statistiques';

  @override
  String get chooseCategory => 'Choisir une Catégorie';

  @override
  String levelCompleted(Object id) {
    return 'Niveau $id Terminé!';
  }

  @override
  String get sortItems => 'Trier les éléments';

  @override
  String get sortNames => 'Trier les noms';

  @override
  String get lowToHigh => 'Petit → Grand';

  @override
  String get highToLow => 'Grand → Petit';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Niveau Suivant';

  @override
  String get retry => 'Réessayer';

  @override
  String get dailyChallenge => 'Défi Quotidien';

  @override
  String get streak => 'Série';

  @override
  String get perfect => 'PARFAIT!';

  @override
  String get tryAgain => 'RÉESSAYEZ';

  @override
  String get completed => 'terminé';

  @override
  String get basicNumbers => 'Nombres de Base';

  @override
  String get formattedNumbers => 'Formatés';

  @override
  String get timeFormats => 'Formats de Temps';

  @override
  String get nameSorting => 'Tri de Noms';

  @override
  String get mixedFormats => 'Formats Mixtes';

  @override
  String get knowledge => 'Connaissance';

  @override
  String get levels => 'niveaux';

  @override
  String get share => 'Partager';

  @override
  String get close => 'Fermer';

  @override
  String get yourTime => 'VOTRE TEMPS';

  @override
  String get continueGame => 'CONTINUER';

  @override
  String get retryLevel => 'RÉESSAYER LE NIVEAU';
}
