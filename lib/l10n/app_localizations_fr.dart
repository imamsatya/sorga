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

  @override
  String get yourSortingParadise => 'Votre Paradis du Tri';

  @override
  String get done => 'Terminé';

  @override
  String get progress => 'Progrès';

  @override
  String get time => 'Temps';

  @override
  String get day => 'jour';

  @override
  String get days => 'jours';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get systemDefault => 'Par Défaut du Système';

  @override
  String get soundEffects => 'Effets Sonores';

  @override
  String get vibration => 'Vibration';

  @override
  String get check => 'Vérifier';

  @override
  String get level => 'Niveau';

  @override
  String get items => 'éléments';

  @override
  String get sortAscending => 'Tri ASC';

  @override
  String get sortDescending => 'Tri DESC';

  @override
  String get best => 'Meilleur';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'Trier $count $type $direction';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get startChallenge => 'DÉMARRER LE DÉFI';

  @override
  String get completedToday => 'Terminé Aujourd\'hui!';

  @override
  String get comeBackTomorrow => 'Revenez demain pour un nouveau défi';

  @override
  String get shareResult => 'Partager le Résultat';

  @override
  String get shareAchievement => 'Partager le Succès';

  @override
  String get canYouBeatMyTime => 'Pouvez-vous battre mon temps?';

  @override
  String get dailyStreak => 'Série Quotidienne';

  @override
  String get dailyStreakActive => 'Série Quotidienne Active!';

  @override
  String get categoryProgress => 'Progrès de Catégorie';

  @override
  String get completedLevels => 'Niveaux Terminés';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String get longestStreak => 'Plus Longue Série';

  @override
  String get totalPlayTime => 'Temps de Jeu Total';

  @override
  String get totalAttempts => 'Tentatives Totales';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get statisticsTitle => 'Statistiques';

  @override
  String get selectLevel => 'Sélectionner le Niveau';

  @override
  String get about => 'À propos';

  @override
  String get appDescription => 'Sorga - Un Jeu de Tri';

  @override
  String get version => 'Version';

  @override
  String get levelsDescription =>
      '800 niveaux dans 6 catégories. Entraînez votre cerveau avec des chiffres, du temps, des noms et plus!';

  @override
  String get dragAndDrop => 'Glisser-Déposer';

  @override
  String get dragItemsDescription =>
      'Faites glisser les éléments pour les réorganiser dans le bon ordre';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'SUIVANT';

  @override
  String get shift => 'Décaler';

  @override
  String get swap => 'Échanger';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get daily => 'Quotidien';

  @override
  String get orderNotRight => 'L\'ordre n\'est pas tout à fait correct.';

  @override
  String chancesLeft(Object count) {
    return 'Il vous reste $count chance(s)!';
  }

  @override
  String get sort => 'Trier';

  @override
  String get asc => 'ASC';

  @override
  String get desc => 'DESC';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get getReady => 'Préparez-vous!';

  @override
  String get attempt => 'Tentative';

  @override
  String get noMoreChances => 'Plus de chances. Réessayez!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y terminé';
  }

  @override
  String get sortTheItems => 'Triez les éléments';

  @override
  String get tapCheckWhenDone =>
      'Appuyez sur Vérifier quand vous avez terminé.';

  @override
  String get useDragMode => 'Utilisez le mode Décaler ou Échanger';

  @override
  String get shiftModeDescription =>
      'Le mode Décaler fait glisser les éléments. Le mode Échanger échange les positions.';

  @override
  String get youreReady => 'Vous êtes prêt!';

  @override
  String get startSorting =>
      'Commencez à trier et battez votre meilleur temps!';

  @override
  String get bestTime => 'Meilleur Temps';

  @override
  String get attempts => 'Tentatives';

  @override
  String get iCompletedLevel =>
      'Je viens de terminer ce niveau dans Sorga ! Pouvez-vous battre mon temps ?';

  @override
  String get dailyChallengeShare => '🎯 Sorga Défi Quotidien';

  @override
  String get shiftAndSwap => 'Décaler & Échanger';

  @override
  String get shiftAndSwapDescription =>
      'Utilisez le mode DÉCALER pour déplacer les éléments étape par étape, ou ÉCHANGER pour changer les positions';

  @override
  String get checkAnswer => 'Vérifier la Réponse';

  @override
  String get checkAnswerDescription =>
      'Quand vous êtes prêt, appuyez sur VÉRIFIER pour confirmer votre réponse. Bonne chance !';

  @override
  String get startPlaying => 'COMMENCER À JOUER';

  @override
  String get january => 'Janvier';

  @override
  String get february => 'Février';

  @override
  String get march => 'Mars';

  @override
  String get april => 'Avril';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juin';

  @override
  String get july => 'Juillet';

  @override
  String get august => 'Août';

  @override
  String get september => 'Septembre';

  @override
  String get october => 'Octobre';

  @override
  String get november => 'Novembre';

  @override
  String get december => 'Décembre';

  @override
  String get numbers => 'nombres';

  @override
  String get times => 'heures';

  @override
  String get names => 'noms';

  @override
  String get memorized => 'Mémorisé !';

  @override
  String get memoryMode => 'Mémoire';

  @override
  String get memorizeTime => 'Mémoriser';

  @override
  String get sortTime => 'Trier';

  @override
  String get totalTime => 'Temps Total';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return 'Terminer le niveau $level dans $category pour débloquer';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return 'Trier $count $type $direction';
  }

  @override
  String get ascending => 'croissant';

  @override
  String get descending => 'décroissant';
}
